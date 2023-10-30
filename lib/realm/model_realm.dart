import 'package:realm/realm.dart';
import 'package:test_app/realm/model_detail_realm.dart';

part 'model_realm.g.dart';

@RealmModel()
class $TodoDBRealm {
  @PrimaryKey()
  int? id;
  String? version;
  
  late List<$TodoDetailDBRealm> todoDetailDBRealm;
}
