//おまじない
import 'package:flutter/material.dart';
import 'package:straight_machine/screens/home_screen.dart';

// runApp関数でアプリを実行するので記載
void main() => runApp(MyApp());

// まずアプリ全体の作成1/6。アプリ全体の状態は変わらないのでstateless
// extendsで継承して、メソッド（関数）のオーバーライド -> StatelessWidgetクラスを継承して使って工数カット
class MyApp extends StatelessWidget {
  @override
  // 継承しているので、実際はbuoild()メソッド以外にも存在。StatelessWidgetでf4
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "レスポンスマシーン",
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
