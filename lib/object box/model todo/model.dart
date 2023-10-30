// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:test_app/object%20box/model%20todo%20detail/model_detail.dart';

class TodoDB {
  int? version;
  TodoDetailDB? detailDB;
  TodoDB({
    this.version,
    this.detailDB,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'detailDB': detailDB?.toMap(),
    };
  }

  factory TodoDB.fromMap(Map<String, dynamic> map) {
    return TodoDB(
      version: map['version'] != null ? map['version'] as int : null,
      detailDB: map['detailDB'] != null
          ? TodoDetailDB.fromMap(map['detailDB'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() => 'TodoDB(version: $version, detailDB: $detailDB)';

  @override
  bool operator ==(covariant TodoDB other) {
    if (identical(this, other)) return true;

    return other.version == version && other.detailDB == detailDB;
  }

  @override
  int get hashCode => version.hashCode ^ detailDB.hashCode;
}

@Entity()
class TodoDBObjectBox {
  int? id;
  
  @Index()
  String? uid;

  String? version;
  // TodoDetailDB? detailDB;
  final detailDB = ToMany<TodoDetailDBObjectBox>();

  TodoDBObjectBox({
    this.version,
    this.uid
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'version': version,
    };
  }

  factory TodoDBObjectBox.fromMap(Map<String, dynamic> map) {
    return TodoDBObjectBox(
      version: map['version'] != null ? map['version']: null,
      // detailDB: map['detailDB'] != null
      //     ? TodoDetailDB.fromMap(map['detailDB'] as Map<String, dynamic>)
      //     : null,
    );
  }

  @override
  bool operator ==(covariant TodoDBObjectBox other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.uid == uid &&
      other.version == version;
  }

  @override
  int get hashCode => id.hashCode ^ uid.hashCode ^ version.hashCode;
}
