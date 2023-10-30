import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import 'package:test_app/realm/model_detail_realm.dart';
import 'package:test_app/realm/model_realm.dart';
import 'package:path_provider/path_provider.dart';

class DBRealmProvider extends ChangeNotifier {
  final Configuration _config =
      Configuration.local([TodoDBRealm.schema, TodoDetailDBRealm.schema]);
  late Realm _realm;
  final dio = Dio();
  Faker faker = Faker();
  var uuid = Uuid;
  bool? versionMatch;

  TodoDBRealm? _results;

  TodoDBRealm? get results => _results;

  Future<TodoDBRealm> getItemsFromApi() async {
    TodoDBRealm todoDB = TodoDBRealm(0);

    try {
      final response = await dio
          .get('https://mocki.io/v1/ef4462cf-6ee6-4a75-b8e4-056dc74b3ca6');
      if (response.statusCode == 200) {
        todoDB.version = response.data['version'];
        for (var e in response.data['todos']) {
          todoDB.todoDetailDBRealm.add(TodoDetailDBRealm(
            e['id'],
            completed: e['completed'],
            title: e['title'],
            userId: e['userId'],
          ));
        }
      }
    } catch (e) {
      rethrow;
    }

    return todoDB;
  }

  Future<String> getVersionAPI() async {
    String ver = 'N/A';

    try {
      final response = await dio
          .get('https://mocki.io/v1/63472e18-eb8f-4fc4-b149-f52729ea9ec9');
      if (response.statusCode == 200) {
        ver = response.data['version'];
      }
    } catch (e) {
      rethrow;
    }

    return ver;
  }

  Future<void> initialize() async {
    _realm = Realm(_config);
    await addAllItemsFirstTime();
  }

  Future<void> addAllItemsFirstTime() async {
    var items = _realm.all<TodoDBRealm>();

    final directory = await getApplicationDocumentsDirectory();

    if (items.isEmpty) {
      TodoDBRealm todoDB = await getItemsFromApi();
      _realm.write(() {
        //*FromAPI
        _realm.add<TodoDBRealm>(todoDB);
      });

      final jsonList = {
        'version': todoDB.version,
        'todo detail': todoDB.todoDetailDBRealm.map((e) {
          return {
            'id': e.uid,
            'title': e.title,
            'completed': e.completed,
            'userId': e.userId
          };
        }).toList()
      };

      final jsonString = jsonEncode(jsonList);

      final file = File(directory.path + '/data.json');

      if (file.existsSync()) {
        await file.writeAsString(jsonString);
      } else {
        File(directory.path + '/data.json').create(recursive: true);
        final newFile = File(directory.path + '/data.json');
        await newFile.writeAsString(jsonString);
      }
    } else {
      String ver = await getVersionAPI();
      // ver = '3';

      final file = File(directory.path + '/data.json');
      final contents = await file.readAsString();

      print(contents);

      if (ver == items.first.version) {
        versionMatch = true;
        print('version match');
      } else {
        TodoDBRealm todoDB = await getItemsFromApi();
        versionMatch = false;
        print('version outdated');
      }
    }
  }

  void getAllItems() {
    _results = _realm.all<TodoDBRealm>().toList().first;

    notifyListeners();
  }

  void addItems() {
    final todoDb = TodoDetailDBRealm(faker.randomGenerator.integer(100),
        title: faker.sport.name(),
        userId: faker.randomGenerator.integer(100),
        completed: faker.randomGenerator.boolean());

    _realm.write(() {
      _results?.todoDetailDBRealm.add(todoDb);
      // _realm.add<TodoDBRealm>(_results!, update: true);
    });
  }

  void deleteItem(TodoDetailDBRealm todoDetailDBRealm) {
    _realm.write(() {
      _realm.delete(todoDetailDBRealm);
    });
    notifyListeners();

    getAllItems();
  }

  void updateItem(int uid) {
    final updated = TodoDetailDBRealm(uid,
        title: faker.sport.name(),
        userId: faker.randomGenerator.integer(100),
        completed: faker.randomGenerator.boolean());
    _realm.write(() {
      _realm.add<TodoDetailDBRealm>(updated, update: true);
    });
    getAllItems();
  }

  void deleteAll() {
    _realm.write(() {
      _realm.deleteAll<TodoDBRealm>();
      _realm.deleteAll<TodoDetailDBRealm>();
    });
    _results = null;
    notifyListeners();

    _realm.close();

    print('delete everything ... ${_results?.todoDetailDBRealm.length}');
  }
}
