import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:test_app/object%20box/model%20todo%20detail/model_detail.dart';
import 'package:test_app/object%20box/model%20todo/model.dart';
import 'package:test_app/objectbox.g.dart';

class DBProvider extends ChangeNotifier {
  final dio = Dio();
  Faker faker = Faker();

  TodoDBObjectBox? _todoVar = TodoDBObjectBox();
  TodoDBObjectBox? get todoVar => _todoVar;

  set todoVar(TodoDBObjectBox? value) => _todoVar = value;

  //*ObjectBox
  Future<TodoDBObjectBox> getTodoDB() async {
    TodoDBObjectBox todoDB = TodoDBObjectBox();

    try {
      final response = await dio
          .get('https://mocki.io/v1/b225a72a-3742-4cb0-bd80-7c2b8bb8060a');
      if (response.statusCode == 200) {
        todoDB = TodoDBObjectBox.fromMap(response.data);
        for (var e in response.data['todos']) {
          todoDB.detailDB.add(TodoDetailDBObjectBox.fromMap(e));
        }
      }
    } catch (e) {
      rethrow;
    }

    return todoDB;
  }

  Future<void> initiate(Store store) async {
    final box = store.box<TodoDBObjectBox>();

    if (box.isEmpty()) {
      var todoDb = await getTodoDB();
      var todo = box.get(1);

      todo = todoDb;
      todo.uid = '001';

      box.put(todo);
    }

    _todoVar = box.getAll().first;
    notifyListeners();
  }

  Future<void> updateObject(Store store, int idTodoDetail, int index) async {
    final box = store.box<TodoDBObjectBox>();
    final boxDetail = store.box<TodoDetailDBObjectBox>();

    var todo =
        box.query(TodoDBObjectBox_.uid.equals('001')).build().findFirst();

    // var todoDetailDb = todo?.detailDB.firstWhere((element) => element.uid == idTodoDetail);

    TodoDetailDBObjectBox todoDetail = TodoDetailDBObjectBox(
      title: faker.sport.name(),
      completed: faker.randomGenerator.boolean(),
      userId: faker.randomGenerator.integer(10),
      uid: idTodoDetail,
    );

    todo?.detailDB[index] = todoDetail;

    box.put(todo!);

    _todoVar = box.getAll().first;
    _todoVar?.detailDB.sort(
      (a, b) => a.uid!.compareTo(b.uid!),
    );
    notifyListeners();
  }

  Future<void> removeObject(Store store, int id) async {
    final box = store.box<TodoDetailDBObjectBox>();

    box.remove(id);

    final box2 = store.box<TodoDBObjectBox>();
    final currVer =
        box2.query(TodoDBObjectBox_.uid.equals('001')).build().findFirst();
    _todoVar = currVer;
    notifyListeners();
  }

  void storeObject(Store store) async {
    final box = store.box<TodoDBObjectBox>();

    final currVer =
        box.query(TodoDBObjectBox_.uid.equals('001')).build().findFirst();

    final todoDetailDB = TodoDetailDBObjectBox(
      completed: faker.randomGenerator.boolean(),
      title: faker.sport.name(),
      userId: faker.randomGenerator.integer(100),
      uid: faker.randomGenerator.integer(100),
    );

    currVer?.detailDB.add(todoDetailDB);

    box.put(currVer!);

    print('puting object to box...');
  }

  Future<void> getObjectBox(Store store) async {
    final box = store.box<TodoDBObjectBox>();

    bool empty = box.isEmpty();

    if (empty) {
      TodoDBObjectBox getTodo = await getTodoDB();
      final currVer =
          box.query(TodoDBObjectBox_.uid.equals('001')).build().findFirst();
      box.put(getTodo);
      _todoVar = currVer;
    } else {
      TodoDBObjectBox getTodo = await getTodoDB();
      final currVer =
          box.query(TodoDBObjectBox_.uid.equals('001')).build().findFirst();

      currVer?.version = '2.0';

      if (currVer?.version.toString() == getTodo.version.toString()) {
        _todoVar = currVer;
        notifyListeners();
      } else {
        print('downloading from server.....');
      }
    }

    //QUERY FIND UNIQUE ID
    final objects =
        box.query(TodoDBObjectBox_.uid.equals('23000651')).build().findFirst();
  }

  void removeEverything(Store store) {
    final box = store.box<TodoDBObjectBox>();

    box.removeAll();
    _todoVar = null;
    notifyListeners();
  }

  void storeObjectFromAPI(Store store) {
    final box = store.box<TodoDBObjectBox>();

    //get data from api
    Future<TodoDBObjectBox> getTodo = getTodoDB();
    getTodo.then((value) {
      print('future todo: ${value.toMap()}');
      for (var element in value.detailDB) {
        print('future tododetail: ${element.toMap()}');
      }
    });

    //put to object
    getTodo.then((value) {
      final todoDetailDB = TodoDetailDBObjectBox(
        completed: false,
        title: 'hai',
        userId: 102,
      );
      final todoDetailDB2 = TodoDetailDBObjectBox(
        completed: false,
        title: 'hai',
        userId: 102,
      );

      final todoDBObjectBox = TodoDBObjectBox(
        version: "2",
      );

      todoDBObjectBox.detailDB.add(todoDetailDB);
      todoDBObjectBox.detailDB.add(todoDetailDB2);
      box.put(todoDBObjectBox);
    });
  }
}
