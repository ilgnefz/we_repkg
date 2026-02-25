// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FilterState)
final filterStateProvider = FilterStateProvider._();

final class FilterStateProvider
    extends $NotifierProvider<FilterState, WallpaperFilter> {
  FilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterStateHash();

  @$internal
  @override
  FilterState create() => FilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WallpaperFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WallpaperFilter>(value),
    );
  }
}

String _$filterStateHash() => r'1191d2bbc41815163a2da978fcd37b1f2a895bdf';

abstract class _$FilterState extends $Notifier<WallpaperFilter> {
  WallpaperFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WallpaperFilter, WallpaperFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WallpaperFilter, WallpaperFilter>,
              WallpaperFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
