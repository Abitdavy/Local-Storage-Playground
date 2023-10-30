import 'package:realm/realm.dart';
part 'model_detail_realm.g.dart';

@RealmModel()
class $TodoDetailDBRealm {
  @PrimaryKey()
  int? uid;
  int? userId;
  String? title;
  bool? completed;
}