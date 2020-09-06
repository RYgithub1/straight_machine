//おまじない
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// まずアプリ全体の作成1/6。アプリ全体の状態は変わらないのでstateless
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "レスポンスマシーン",
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
