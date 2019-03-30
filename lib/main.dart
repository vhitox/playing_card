import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List card_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
            children: _repartir(card_list)            
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
