// import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:soundpool/soundpool.dart';



// ~~~~ homeScreenとしてmain.dartから呼び込み。material.dartをimport~~~~
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ++++++【変数定義】+++++++++++++++++
  // String _text01 = "おめでとうございます";
  // String _text02 = "合格です";
  // String _text03 = "よくできました";
  // String _text04 = "残念でした";
  // String _text05 = "不合格です";
  // String _text06 = "頑張りましょう";
  // 配列リスト内の型は同じでないといけない
  List<String> _texts = [
    "おめでとうございます",
    "合格です",
    "よくできました",
    "残念でした",
    "不合格です",
    "頑張りましょう"
  ];

  // IDを振り、どの音声かを紐付けたい -> 整数を格納するリストを変数定義
  List<int> _soundIds = [0, 0, 0, 0, 0, 0];

  Soundpool _soundpool;  // 一旦変数定義
  // インスタンスは、画面開いた際に一回通り格納
  // int number = 3;


  // ========【initState()】=========================
  @override
  // void initState() async{  // initStateではasync-await禁止！buildに流れなくなる
  void initState() {
    super.initState();  // parentの処理を引き継ぎますsuper
    // await _initSounds();
    _initSounds();
    // _soundpool = Soundpool();  // 一旦変数定義していたものの、メソッド化
    print("initState終了 -> build()発動");
  }

  // asunc-awaitの戻り値の型はFUTUERE！！！
  // void _initSounds() async {
  Future<void> _initSounds() async {  // asyncで呼び出しもとから一度離婚
    // 例外処理のハンドリング追加
    try {
      _soundpool = Soundpool();  // 一旦変数定義していたものの、メソッド化

      _soundIds[0] = await loadSound("assets/sounds/sound1.mp3");
      _soundIds[1] = await loadSound("assets/sounds/sound2.mp3");
      _soundIds[2] = await loadSound("assets/sounds/sound3.mp3");
      _soundIds[3] = await loadSound("assets/sounds/sound4.mp3");
      _soundIds[4] = await loadSound("assets/sounds/sound5.mp3");
      _soundIds[5] = await loadSound("assets/sounds/sound6.mp3");
      //  _soundsIds[0] = awaitrootBundle
      //     .load("assets/sounds/sound1.mp3")
      //     .then((value) => _soundpool.load(value));
      print("initSounds終了 -> 効果音発動(これが、先に音ならないといけないのに、後にきている ->setState()してないから");
      // initStateの中で非同期処理と行う ->setStateで処理ｎタイミングを図らないと、流れてしまい音がならない
      setState(() {}); // buildMethod 呼び出すのが目的故空。initStateから飛んできたメソゆえ、こちらでsetState()必須
    } on IOException catch(error) {
      print("例外エラー内容:$error");
    }
  }
  // +++++ _initSounds()内のloadsound()のクラス +++++++++
  // 反復処理なのでメソッド化する、loadSound。
  // これで効果音ファイルをメモリにロードしてサウンドidをつけた
  Future<int> loadSound(String soundPath) {
    // rootBundleとは、画像や音を格納する金庫（Bundle)で、道路でバイトデータを運ぶまで。ビルドで作成。
    //loadで運べた -> loadメソッド(F12で型引数チェック) -> 戻り値の型をFUTURE  -> 01
    return rootBundle.load(soundPath).then((value) => _soundpool.load(value));
  }



  // ========【dispose()】=========================
  // 作成したインスタンスsoundなので短い音は、机メモリに残ってしまうので破棄dispose
  @override
  void dispose() {
    _soundpool.release();  // soundpoolメソッドにrelease()
    super.dispose();
  }



  // ========【build()】=========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("レスポンスマシーン"),
        centerTitle: true,
      ),
      body: Padding(
        // padding: EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Container(  // container wrapping! for padding
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[  //columnに複数の行rowゆえchildren
              Expanded(
                flex: 1,
                child: Row(  //このrowが1行文（1行×2列の作成）→rowが３つ
                  // クロス軸を設けて整頓する。縦方向にもexpandするには
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // _text01のコメントを、網目ごとに表示させるためボタンの引数へ
                    // Expanded(flex: 1, child: _soundButton(_text01)),
                    Expanded(flex: 1, child: _soundButton(_texts[0], _soundIds[0])),
                    Expanded(flex: 1, child: _soundButton(_texts[1], _soundIds[1])),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(  // F12 at Row -> List<Widget> children = const <Widget>[],  List is available!
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(flex: 1, child: _soundButton(_texts[2], _soundIds[2])),
                    Expanded(flex: 1, child: _soundButton(_texts[3], _soundIds[3])),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // []配列リストをchildren配下にして、同種をまとめて扱う。[リスト]の前にリストの<型>を指定。
                  // children[0],children[1],children[2]で指定可能
                  children: <Widget>[
                    Expanded(flex: 1, child: _soundButton(_texts[4], _soundIds[4])),
                    Expanded(flex: 1, child: _soundButton(_texts[5], _soundIds[5])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------【外だしメソッド】-------------
  // 困ったらWidget型でいい
  // opt*ret -> method選択
  // ボタン押下時に場合分けしつつ読み込む。予め表示しておく。引数displayText指定
  Widget _soundButton(String displayText, int soundId) {  // idに紐づけた音鳴らす -> 引数で受け取り -> [int soundId]の追加
    return Container(  // wrap by container for padding
      padding: EdgeInsets.all(8.0),

      child: RaisedButton(
        color: Colors.blueGrey,
        onPressed: () => _playSound(soundId), // idに紐付いた音をここのメソッドで

        shape: RoundedRectangleBorder( // 角丸
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        // RaisedButtonにtext add -> 1つ child:
        child: Text(displayText, style: TextStyle(color: Colors.cyan)),
      ),
    );
  }
  // --------【外だしメソッド】-------------
  void _playSound(int soundId) async {
    await _soundpool.play(soundId);
  }
// Widget _initSounds() async {
//   // xxx = await xxx;
//   // }
// }m
}

// FIXME: --------------
// 音は２種類ありコード上異なる取り扱い）
// -> 短い音７秒(sound)SoundPool。メモリにロード
// -> 長い音８秒以上(music)MusicPlayer。ストリーミング
// pub.devにフラッター関係のライブラリあり
// 状態を管理するときの３つ＝initState, setState, dispose
// 非同期処理(async-await)＝時間のかかる処理をシンクロasyncで実行、awaitで本処理に戻す
// ->非同期での戻り値をfutureに一時格納（どのタイミングで本処理に戻すか場合による為）

// Widgetとは石。動かない動けないもの。動いたあとの状態の石を生み出すbuild()。
// ->statefulは動きが有りなので、石を矯正的に変化させるbuild()するためにクラス2つ宣言
// MVCのイメージで言うと、widgetがビューで、stateがコントローラー

// コンパイルエラー；文法ゆえ動かない -> コード修正
// ランタイムエラー；実行時想定外が発生 -> デバッグでわかる、コード修正
// 論理エラー；理想と現実とギャップ

// try-catch-finally