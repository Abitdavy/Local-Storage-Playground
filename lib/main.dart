import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/db%20config/database_config.dart';
import 'package:test_app/db%20config/db_provider.dart';
import 'package:test_app/db%20config/db_realm_provider.dart';
import 'package:test_app/object%20box/objectbox_config.dart';
import 'package:test_app/objectbox_page.dart';
import 'package:test_app/realm_page.dart';

late ObjectBox objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseConfig.copyDatabaseFileFromAssets();

  //instantiate object box
  objectBox = await ObjectBox.create();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DBProvider()),
      ChangeNotifierProvider(create: (context) => DBRealmProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Database objectbox'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: Size(200, 80)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ObjectBoxPage(
                              objectBox: objectBox,
                            ),
                          ));
                    },
                    child: const Text(
                      'Object Box',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 80)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RealmPage(),
                          ));
                    },
                    child: const Text(
                      'Realm',
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
