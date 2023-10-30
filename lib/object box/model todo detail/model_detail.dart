// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:objectbox/objectbox.dart';

class TodoDetailDB {
  int? userId;
  int? id;
  String? title;
  bool? completed;
  TodoDetailDB({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory TodoDetailDB.fromMap(Map<String, dynamic> map) {
    return TodoDetailDB(
      userId: map['userId'] != null ? map['userId'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      completed: map['completed'] != null ? map['completed'] as bool : null,
    );
  }
}

@Entity()
class TodoDetailDBObjectBox {
  int? id;

  @Index()
  int? uid;
  int? userId;
  String? title;
  bool? completed;
  TodoDetailDBObjectBox({
    this.userId,
    this.uid,
    this.title,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  factory TodoDetailDBObjectBox.fromMap(Map<String, dynamic> map) {
    return TodoDetailDBObjectBox(
      uid: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      completed: map['completed'] != null ? map['completed'] as bool : null,
    );
  }
}
