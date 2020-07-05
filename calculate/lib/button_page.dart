import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final Function operation;

  ButtonPage({@required this.color, @required this.textColor, @required this.buttonText, @required this.operation});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.2)),
      child: Container(
        color: this.color,
        child: SizedBox(
          width: 10.0,
          height: 10.0,
          child: Center(
              child: FlatButton(
                child: Text(
                  this.buttonText,
                  style: TextStyle(color: this.textColor, fontSize: 30.0),
                ),
                onPressed: operation,
              )),
        ),
      ),
    );
  }
}
