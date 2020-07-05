import 'package:calculate/button_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {

  String equation                   = "0";
  String result                     = "0";
  String expression                 = "";

   final List<String> itemCalulates =
   [
     "C", "+/-", "%", "/",
     "7", "8",   "9", "X",
     "4", "5",   "6", "-",
     "1", "2",   "3", "+",
     "0", "",    ",", "=",
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#9FBEC3').withOpacity(0.98),
      body: Container(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 40, 30, 0),
              child: Text(equation, style: TextStyle(fontSize: 20.0, color: Hexcolor('#0E5C68')),),
            ),


            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 30, 2),
              child: Text(result, style: TextStyle(fontSize: 30.0, color: Hexcolor('#0E5C68') ),),
            ),

            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
                child: Container(
                  color: Hexcolor('#F9FBFB'),
                  child: GridView.builder(
                      itemCount: itemCalulates.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {

                        if(itemCalulates[index] == '=') {

                          return ButtonPage(
                            textColor: Hexcolor('#F9FBFB'),
                            color: Hexcolor('#0E5C68'),
                            buttonText: itemCalulates[index],
                            operation: () => _calculateOperator(itemCalulates[index]),
                          );

                        }else {
                          return ButtonPage(
                            textColor: (_isOperator(itemCalulates[index]))? Hexcolor('#F9FBFB') : Hexcolor('#0E5C68'),
                            color: (_isOperator(itemCalulates[index]))? Hexcolor('#9FBEC3').withOpacity(0.55) : Hexcolor('#F9FBFB'),
                            buttonText: itemCalulates[index],
                            operation: () => _calculateOperator(itemCalulates[index]),
                          );
                        }
                      }
                  ),
                ),
              )
            ),
          ],
        ),
      )
    );
  }

/********* FUNCTIONS *************/

  _isOperator(String x){
    if(x == 'C' ||
       x == '+/-' ||
       x == '%' ||
       x == '/' ||
       x == 'X' ||
       x == '-' ||
       x == '+' ) {
      return true;
    }else{
      return false;
    }
  }

  _calculateOperator(String value){

    setState(() {

      if(value == "C") {

        equation          = "0";
        result            = "0";

      }else if(value == "=") {

        expression        = equation;
        expression        = expression.replaceAll('X', '*');

        try{

          Parser p        = Parser();
          Expression exp  = p.parse(expression);

          ContextModel cm = ContextModel();
          result          = '${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e) {

          result = "Error";
        }

      }else {

        if(equation == "0") {

          equation        = value;

        } else {

          equation        = equation + value;
        }

      }
    });
  }
}
