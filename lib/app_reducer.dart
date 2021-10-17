import 'package:redux/redux.dart';

import 'app_actions.dart';
import 'app_state.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetUnit>(_selectedUnitReducer),
]);

AppState _selectedUnitReducer(AppState state, SetUnit action) {
  return action.newUnit;
}

// AppState appReducer(AppState state, action) {
//   return AppState(
//     isLoading: loadingReducer(state.isLoading, action),
//     thermostat: thermostatReducer(state.thermostat, action),
//     unit: unitReducer(state.unit, action),
//   );
// }