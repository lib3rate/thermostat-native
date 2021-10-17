// @immutable
class AppState {
  final int selectedUnit;

  AppState({
    this.isLoading = false,
    this.selectedUnit: 100,
  });

  factory AppState.loading() => AppState(isLoading: true);
}


