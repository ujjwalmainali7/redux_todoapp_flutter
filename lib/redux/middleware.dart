import 'dart:async';
import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/action.dart';


Middleware<AppState> _loadfromPrefs(AppState state){
  return (Store<AppState> store, action, NextDispatcher next){
    next(action);
    loadFromPrefs().then((state) => store.dispatch(LoadedItemsAction(state.items)));
  };
}

Middleware<AppState> _saveToPrefs(AppState state){
  return (Store<AppState> store, action, NextDispatcher next){
    next(action);
    saveToPrefs(state);
  };
}
void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var jsonString = json.encode(state.toJson());
  await preferences.setString('itemsState', jsonString);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var jsonState = preferences.getString('itemsState');
  if(jsonState != null){
    List stateListJson = json.decode(jsonState);
    return AppState.fromJson(stateListJson);
  }

  return AppState.initState();
}

List<Middleware<AppState>> appStateMiddleWare([
  AppState state = const AppState(items: []),
  ]){
  final loadItems = _loadfromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
    TypedMiddleware<AppState, ItemCompletedAction>(saveItems),
  ];
}