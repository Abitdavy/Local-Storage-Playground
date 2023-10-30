// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TodoDBRealm extends $TodoDBRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  TodoDBRealm(
    int? id, {
    String? version,
    Iterable<TodoDetailDBRealm> todoDetailDBRealm = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'version', version);
    RealmObjectBase.set<RealmList<TodoDetailDBRealm>>(this, 'todoDetailDBRealm',
        RealmList<TodoDetailDBRealm>(todoDetailDBRealm));
  }

  TodoDBRealm._();

  @override
  int? get id => RealmObjectBase.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get version =>
      RealmObjectBase.get<String>(this, 'version') as String?;
  @override
  set version(String? value) => RealmObjectBase.set(this, 'version', value);

  @override
  RealmList<TodoDetailDBRealm> get todoDetailDBRealm =>
      RealmObjectBase.get<TodoDetailDBRealm>(this, 'todoDetailDBRealm')
          as RealmList<TodoDetailDBRealm>;
  @override
  set todoDetailDBRealm(covariant RealmList<TodoDetailDBRealm> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TodoDBRealm>> get changes =>
      RealmObjectBase.getChanges<TodoDBRealm>(this);

  @override
  TodoDBRealm freeze() => RealmObjectBase.freezeObject<TodoDBRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TodoDBRealm._);
    return const SchemaObject(
        ObjectType.realmObject, TodoDBRealm, 'TodoDBRealm', [
      SchemaProperty('id', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('version', RealmPropertyType.string, optional: true),
      SchemaProperty('todoDetailDBRealm', RealmPropertyType.object,
          linkTarget: 'TodoDetailDBRealm',
          collectionType: RealmCollectionType.list),
    ]);
  }
}
