import 'package:flutter/material.dart';
import 'package:play_cards/utils/chelper.dart';

void main() => runApp(MyApp());
Color bl = Colors.black;
Text tl = Text("21 Card Card trick");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Cards());
  }
}

class Cards extends StatefulWidget {
  @override
  _CardState createState() => new _CardState();
}

class _CardState extends State<Cards> {
  final ScrollController _sCtlr = ScrollController();
  List crdl = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
  List<List<int>> mat = new List.generate(7, (i) => []);
  CHelper hlp = new CHelper();
  List c;
  List cSet;
  var t = 0;
  void _sCol(int chs) {
    setState(() {
      t++;
      c = hlp.order(c, chs);
      cSet = hlp.joinMatriz(mat, c, chs);
      mat = hlp.dataIn(cSet);
    });
    if (t == 3) { Navigator.push(context, MaterialPageRoute(builder: (context) => YourCard("${mat[3][1]}")));}
  }

  @override
  void initState() {
    super.initState();
    crdl.shuffle();
    mat = hlp.dataIn(crdl);
    c = [0, 1, 2];
    cSet = crdl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
            margin: EdgeInsets.only(right: 14.0),
            width: 300.0,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _btns())),
        appBar: AppBar(title: tl, backgroundColor: bl),
        body: Container(            
            child: CustomScrollView(
                controller: _sCtlr,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Text("Think in a card & select his column",
                              style: TextStyle(color: bl)))),
                  SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("img/${cSet[index]}.jpg"))));
                      }, childCount: cSet.length))
                ])));
  }

  List<Widget> _btns() {
    List<Widget> r = List<Widget>();
    for (var i = 0; i <= 2; i++) {
      r.add(FloatingActionButton(
          heroTag: "${i}",
          backgroundColor: Colors.black54,
          child: Icon(Icons.arrow_upward),
          onPressed: () {_sCol(i);}));
    }
    return r;
  }
}

class YourCard extends StatelessWidget {
  String ycard;
  YourCard(this.ycard);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white54,
                child: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                }),
            appBar: AppBar(title: tl, backgroundColor: bl),
            body: Container(                
                child: Stack(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text("Your card:", style: TextStyle(color: bl))),
                  Center(
                      child: Container(
                          width: 150.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("img/${ycard}.jpg"),
                                  fit: BoxFit.fitWidth))))
                ]))));
  }
}
