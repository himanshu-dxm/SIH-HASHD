import 'package:flutter/material.dart';
import 'package:hashd/model/getDatabase.dart';
import 'package:hashd/model/maps.dart';
import 'package:hashd/screens/home.dart';
import '../model/language.dart';
import 'help.dart';
class TempPage extends StatelessWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("For IMSH"),
      ),
        body: DatabaseData.notif()
    );
  }
}
