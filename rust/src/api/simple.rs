use std::path::Path;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb]
pub async fn delete_to_trash(file_path: String) -> Option<String> {
    trash::delete(&file_path).map_err(|e| e.to_string()).err()
}

#[flutter_rust_bridge::frb]
pub async fn delete_all_to_trash(file_paths: Vec<String>) -> Option<String> {
    trash::delete_all(&file_paths)
        .map_err(|e| e.to_string())
        .err()
}

#[flutter_rust_bridge::frb]
pub async fn has_png_transparency_rust(file_path: String) -> Result<bool, String> {
    let path = Path::new(&file_path);
    // 检查文件扩展名
    if let Some(ext) = path.extension() {
        if ext.to_str() != Some("png") {
            return Ok(false);
        }
    } else {
        return Ok(false);
    }
    // 读取并解码PNG图像
    let img = match image::open(path) {
        Ok(img) => img,
        Err(e) => return Err(format!("Failed to open image: {}", e)),
    };
    // 检查透明度
    let has_transparency = match img {
        image::DynamicImage::ImageRgba8(img) => img.pixels().any(|pixel| pixel.0[3] < 255),
        image::DynamicImage::ImageRgba16(img) => img.pixels().any(|pixel| pixel.0[3] < 65535),
        _ => false, // 非RGBA格式没有透明度通道
    };
    Ok(has_transparency)
}

#[flutter_rust_bridge::frb]
pub async fn has_png_transparency_batch_rust(file_paths: Vec<String>) -> Vec<Result<bool, String>> {
    let mut results = Vec::new();
    for file_path in file_paths {
        results.push(has_png_transparency_rust(file_path).await);
    }
    results
}

#[flutter_rust_bridge::frb]
pub async fn delete_transparent_pngs_rust(file_paths: Vec<String>) -> Vec<String> {
    let mut errors = Vec::new();
    for file_path in file_paths {
        match has_png_transparency_rust(file_path.clone()).await {
            Ok(true) => {
                // 有透明像素，删除文件
                if let Err(e) = trash::delete(&file_path) {
                    errors.push(format!("Failed to delete transparent PNG: {}", e));
                }
            }
            Ok(false) => {
                // 没有透明像素，不删除，不返回任何信息
            }
            Err(e) => {
                // 检测失败
                errors.push(format!("Transparency check failed: {}", e));
            }
        }
    }
    errors
}
