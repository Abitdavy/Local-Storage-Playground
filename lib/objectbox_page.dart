import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/db%20config/db_provider.dart';
import 'package:test_app/main.dart';
import 'package:test_app/object%20box/model%20todo/model.dart';
import 'package:test_app/object%20box/objectbox_config.dart';

class ObjectBoxPage extends StatefulWidget {
  final ObjectBox objectBox;

  const ObjectBoxPage({super.key, required this.objectBox});

  @override
  State<ObjectBoxPage> createState() => _ObjectBoxPageState();
}

class _ObjectBoxPageState extends State<ObjectBoxPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<DBProvider>(context, listen: false)
          .initiate(objectBox.store);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DBProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object Box'),
      ),
      body: Consumer<DBProvider>(
        builder: (context, value, _) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => prov.storeObject(objectBox.store),
                            child: const Text('put')),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () => prov.getObjectBox(objectBox.store),
                            child: const Text('get')),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () =>
                                prov.removeEverything(objectBox.store),
                            child: const Text('remove')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: prov.todoVar == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  Icons
                                      .sentiment_satisfied_alt, // Emoticon icon
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                const Text(
                                  'No Items Found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Add your action here when the user clicks the button
                                  },
                                  child: const Text('Refresh'),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: prov.todoVar?.detailDB.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListTile(
                                leading:
                                    const Icon(Icons.album, color: Colors.blue),
                                title: Text(
                                  '${prov.todoVar?.detailDB[index].title.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  'UserId: ${prov.todoVar?.detailDB[index].userId.toString()}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          value.updateObject(
                                              objectBox.store,
                                              value.todoVar!.detailDB[index]
                                                  .id!, index);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          value.removeObject(
                                              objectBox.store,
                                              value.todoVar!.detailDB[index]
                                                  .id!);
                                        },
                                      ),
                                    ]),
                                tileColor: Colors.yellow.withOpacity(0.2),
                                onTap: () {
                                  // Add your custom onTap action here
                                },
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
