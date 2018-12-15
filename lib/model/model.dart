import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;
  final bool completed;

  Item({@required this.id, @required this.body, this.completed = false});

  Item copyWith({int id, String body, bool completed}){
    return Item(
      id: id ?? this.id,
      body: body ?? this.body,
      completed: completed ?? this.completed
    );
  }

  Item.fromJson(Map json) 
  : body = json['body'], 
    id = json['id'],
    completed = json['completed'];

  Map toJson() =>{
    'body': body,
    'id' : id,
    'completed' : completed
  };

}

class AppState {
  final List<Item> items;

  const AppState({@required this.items});

  AppState.fromJson(List json): items = json.map<Item>((i){
    return Item.fromJson(i);
  }).toList();

  List<Map> toJson()=> items.map<Map>((item){
    return item.toJson();
  }).toList();

  AppState.initState(): items = List.unmodifiable(<Item>[]);
}
