import 'package:flutter/material.dart';

class VersionPage extends StatefulWidget {
  const VersionPage({super.key});

  @override
  State<VersionPage> createState() => _VersionPageState();
}

class _VersionPageState extends State<VersionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("version outdated"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Update Version")),
        ),
      ),
    );
  }
}
