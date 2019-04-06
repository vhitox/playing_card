import 'package:flutter/material.dart';
import 'package:play_cards/utils/card_helper.dart';

void main()=>runApp(MyApp());
Color bl=Colors.black;
Text title=Text("21 Card Card trick");
Color wh=Colors.white;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Cards()
    );
  }
}

class Cards extends StatefulWidget {  
  @override
  _CardsState createState() => new _CardsState();
}

class _CardsState extends State<Cards> {
  final ScrollController _scrollController=ScrollController();
  List crdl=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
  List<List<int>> mat=new List.generate(7, (i)=>[]);
  CardHelper hlp=new CardHelper();
  List c;
  List cSet;
  var t = 0;
  void _selectColumn(int selected) {
    setState(() {
      t++;
      c = hlp.orderSelected(c, selected);
      cSet = hlp.joinMatriz(mat, c, selected);
      mat = hlp.insertData(cSet);
    });
    if (t==3) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => YourCard("${mat[3][1]}")));
    }
  }

  @override
  void initState() {
    super.initState();
    crdl.shuffle();
    mat = hlp.insertData(crdl);
    c = [0,1,2];
    cSet = crdl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 14.0),
          width: 300.0,
          child: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: _buttons())
        ),
        appBar: AppBar(
          title: title,
          backgroundColor: bl
        ),
        body: Container(
          decoration: BoxDecoration(color: bl),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text("Think in a card, and select his column",style: TextStyle(color: wh)
                  )
                )
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {                  
                  return Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/${cSet[index]}.jpg"))));
                }, childCount: cSet.length)
              )
            ]
          )
        ));
  }
  List<Widget> _buttons() {
    List<Widget> retB = List<Widget>();
    for (var i=0;i<=2;i++){
      retB.add(FloatingActionButton(heroTag: "${i}",backgroundColor: Colors.black54,child: Icon(Icons.arrow_upward),onPressed: () {_selectColumn(i);}));
    }
    return retB;
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
          child: Icon(Icons.arrow_back_ios), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));}
        ),
        appBar: AppBar(
          title: title,
          backgroundColor: bl
        ),
        body: Container(
            decoration: BoxDecoration(color: bl),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text("This your card:",style: TextStyle(color: wh))
                ),
                Center(
                  child: Container(
                    width: 150.0,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/${ycard}.jpg"),fit: BoxFit.fitWidth))
                  )
                )
              ]
            ))
      )
    );
  }
}
