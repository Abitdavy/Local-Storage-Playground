import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/object%20box/model%20todo/model.dart';
import 'package:test_app/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    store
        .box<TodoDBObjectBox>()
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: join(docsDir.path, "objBoxTest2"));

    return ObjectBox._create(store);
  }
}
