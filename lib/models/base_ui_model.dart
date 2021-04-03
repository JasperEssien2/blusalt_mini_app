abstract class BaseUIModel {
  bool _isLoading = false;
  bool _useShimmerEffect = true;

  bool get isLoading => _isLoading;

  bool get useShimmerEffect => _useShimmerEffect;

  void toggleLoadingStatus(bool showLoad, {bool useShimmerEffect = true}) {
    _isLoading = showLoad;
    _useShimmerEffect = useShimmerEffect;
  }
}
