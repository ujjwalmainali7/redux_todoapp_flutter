import 'package:redux/redux.dart';
import 'package:todo_redux/model/model.dart';
import 'action.dart';

AppState appStateReducer(AppState state, action){
  return AppState(
    items: itemReducer(state.items, action)
  );
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemsCompletedReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action){
  return []..addAll(items)..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action){
  return List.unmodifiable(List.from(items)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action){
  return <Item>[];
}

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action){
  return action.items;
}

List<Item> itemsCompletedReducer(List<Item> items, ItemCompletedAction action){
  return items.map((item) => item.id == action.item.id ? (item.copyWith(completed: !item.completed)): item);
}




// List<Item> itemReducer(List<Item> state, action){
//   if (action is AddItemAction){
//     return []..addAll(state)..add(Item(id: action.id, body: action.item));
//   }
//   if(action is RemoveItemAction){
//     return List.unmodifiable(List.from(state)..remove(action.item));
//   }

//   if(action is RemoveItemsAction){
//     return [];
//   }

//   if(action is LoadedItemsAction){
//     return action.items;
//   }
//   return state;
// }