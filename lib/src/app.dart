import 'package:flutter/material.dart';
import 'package:dojardim/src/tabs/tabs.dart';
import 'pages/TelaInicial.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "doJardim",
      theme: ThemeData(primaryColor: Color(0xFFFF005C)),
      home: Tabs("", "", "", ""),
    );
  }
}
