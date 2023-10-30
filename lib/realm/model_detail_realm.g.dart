// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_detail_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TodoDetailDBRealm extends $TodoDetailDBRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  TodoDetailDBRealm(
    int? uid, {
    int? userId,
    String? title,
    bool? completed,
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'completed', completed);
  }

  TodoDetailDBRealm._();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': uid,
      'userId': userId,
      'title': title,
      'completed': completed
    };
  }

  TodoDetailDBRealm.fromJson(Map<String, dynamic> map) {
     uid = map['id'];
     title = map['title'];
     completed = map['completed'];
     userId = map['userId'];
  }

  @override
  int? get uid => RealmObjectBase.get<int>(this, 'uid') as int?;
  @override
  set uid(int? value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int? get userId => RealmObjectBase.get<int>(this, 'userId') as int?;
  @override
  set userId(int? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  bool? get completed => RealmObjectBase.get<bool>(this, 'completed') as bool?;
  @override
  set completed(bool? value) => RealmObjectBase.set(this, 'completed', value);

  @override
  Stream<RealmObjectChanges<TodoDetailDBRealm>> get changes =>
      RealmObjectBase.getChanges<TodoDetailDBRealm>(this);

  @override
  TodoDetailDBRealm freeze() =>
      RealmObjectBase.freezeObject<TodoDetailDBRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TodoDetailDBRealm._);
    return const SchemaObject(
        ObjectType.realmObject, TodoDetailDBRealm, 'TodoDetailDBRealm', [
      SchemaProperty('uid', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.int, optional: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('completed', RealmPropertyType.bool, optional: true),
    ]);
  }
}
