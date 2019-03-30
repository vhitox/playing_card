import 'package:flutter/material.dart';
import 'package:play_cards/utils/card_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List card_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
  List<List<int>> matriz = new List.generate(7, (i) => []);
  CardHelper cHelper = new CardHelper();
  List c = [0,2,1];
  List prueba;
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //c = cHelper.orderSelected(c, 2);
    //print(c);
    matriz = cHelper.insertData(card_list, matriz);
    c = cHelper.orderSelected(c, 2);
    prueba = cHelper.joinMatriz(matriz, c, 2);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Play Cards"),
        ),
        body: Container(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            crossAxisCount: 3,
            children: _repartir(prueba)            
          ),
        ),
      ),
    );
  }

  List<Widget> _repartir(List cards){
    // cards.shuffle();
    // print(cards);
    List<Widget> listCards = new List<Widget>();
    cards.forEach((e){
      listCards.add(Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/${e}.jpg")
          )
        ),
      ));
    });
    return listCards;
  }
}
