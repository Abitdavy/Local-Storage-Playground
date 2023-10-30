import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/db%20config/db_realm_provider.dart';

class RealmPage extends StatefulWidget {
  const RealmPage({super.key});

  @override
  State<RealmPage> createState() => _RealmPageState();
}

class _RealmPageState extends State<RealmPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<DBRealmProvider>().initialize();

      //notify version
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          // margin: const EdgeInsets.only(bottom: 10),
          backgroundColor: context.read<DBRealmProvider>().versionMatch!
              ? Colors.green
              : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: context.read<DBRealmProvider>().versionMatch!
              ? const Text('Version Uptodate')
              : const Text('Version Outdated, Begin downloading....'),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realm Database'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => context.read<DBRealmProvider>().deleteAll(),
          ),
        ],
      ),
      body: Consumer<DBRealmProvider>(
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
                            onPressed: () => value.addItems(),
                            child: const Text('put')),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () => value.getAllItems(),
                            child: const Text('get')),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: value.results?.todoDetailDBRealm == null
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
                                  child: Text('Refresh'),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: value.results?.todoDetailDBRealm.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListTile(
                                leading:
                                    const Icon(Icons.album, color: Colors.blue),
                                title: Text(
                                  '${value.results?.todoDetailDBRealm[index].title}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  'UserId: ${value.results?.todoDetailDBRealm[index].userId.toString()}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        value.updateItem(value.results!
                                            .todoDetailDBRealm[index].uid!);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      onPressed: () {
                                        value.deleteItem(value
                                            .results!.todoDetailDBRealm[index]);
                                      },
                                    ),
                                  ],
                                ),
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
