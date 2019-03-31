import 'package:flutter/material.dart';
import 'package:play_cards/utils/card_helper.dart';

void main() => runApp(Cards());

class Cards extends StatefulWidget {
  Cards();
  @override
  _CardsState createState() => new _CardsState();
}

class _CardsState extends State<Cards> {
  List card_list = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21
  ];
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
    print(a_repartir);
    matriz.forEach((element) => print(element));
    print(veces);
  }

  @override
  void initState() {
    super.initState();
    card_list.shuffle();
    matriz = cHelper.insertData(card_list);
    c = [0, 1, 2];
    a_repartir = card_list;
    print(a_repartir);
    matriz.forEach((element) => print(element));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            bottomNavigationBar: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                    child: Text("uno"),
                    onPressed: () {
                      _selectColumn(0);                      
                    }),
                RaisedButton(
                  child: Text("dos"),
                  onPressed: () {
                    _selectColumn(1);                    
                  },
                ),
                RaisedButton(
                  child: Text("tres"),
                  onPressed: () {
                    _selectColumn(2);                    
                  },
                ),
              ],
            ),
            appBar: AppBar(
              title: Text("Play Cards"),
            ),
            body: Container(
              child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20.0),
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 3,
                  children: _repartir(a_repartir)),
            )));
  }

  List<Widget> _repartir(List cards) {
    // cards.shuffle();
    // print(cards);
    List<Widget> listCards = new List<Widget>();
    cards.forEach((e) {
      listCards.add(Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/${e}.jpg"))),
      ));
    });
    return listCards;
  }
}

class YourCard extends StatelessWidget {
  String yourcard = "";

  YourCard(this.yourcard);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your result"),
      ),
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/${yourcard}.jpg"))),
        ),
      ),
    );
  }
}
