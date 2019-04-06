import 'package:flutter/material.dart';
import 'package:play_cards/utils/card_helper.dart';

void main() => runApp(MyApp());
final Color bl = Colors.black;
final Text title = Text("21 Card Card trick");
final Color wh = Colors.white;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Cards(),
    );
  }
}

class Cards extends StatefulWidget {
  Cards({Key key}) : super(key: key);
  @override
  _CardsState createState() => new _CardsState();
}

class _CardsState extends State<Cards> {
  final ScrollController _scrollController = ScrollController();
  List card_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
  List<List<int>> matriz = new List.generate(7, (i) => []);
  CardHelper cHelper = new CardHelper();
  List c;
  List a_repartir;
  var veces = 0;
  void _selectColumn(int selected) {
    setState(() {
      veces++;
      c = cHelper.orderSelected(c, selected);
      a_repartir = cHelper.joinMatriz(matriz, c, selected);
      matriz = cHelper.insertData(a_repartir);
    });
    if (veces == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  YourCard("${matriz[3][1]}")));
    }
  }

  @override
  void initState() {
    super.initState();
    card_list.shuffle();
    matriz = cHelper.insertData(card_list);
    c = [0, 1, 2];
    a_repartir = card_list;
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
          children: _buttons(),
        ),
      ),
         appBar: AppBar(
           title: title,
           backgroundColor: bl,
         ),
        body: Container(
          decoration: BoxDecoration(color: bl),
          child: CustomScrollView(                    
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  "Think in a card, and select his column",                  
                  style: TextStyle(color: wh,),
                  ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                print("card${index}");
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${a_repartir[index]}.jpg"))),
                );
              }, childCount: a_repartir.length),
            )
          ],
        ),
        ));
  }
  List<Widget> _buttons(){
    List<Widget> retB = List<Widget>();
    for(var i = 0; i<=2; i++){
      retB.add(FloatingActionButton(
              heroTag: "${i}",
              backgroundColor: Colors.black54,
              child: Icon(Icons.arrow_upward), onPressed: () {
                _selectColumn(i);
              },
            ));
    }
    return retB;
  }
}

class YourCard extends StatelessWidget {  
  String yourcard;
  YourCard(this.yourcard);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white54,
          child: IconButton(            
            icon: Icon(Icons.arrow_back_ios), onPressed: () {
              Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ),
        
        appBar: AppBar(
          title: title,
          backgroundColor: bl,
        ),
        body: Container(
          decoration: BoxDecoration(color: bl),
            child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text("This your card:", style: TextStyle(color: wh),),
            ),
            Center(
              child: Container(
                width: 150.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/${yourcard}.jpg"),
                        fit: BoxFit.fitWidth)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
