import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Color btnColor;
  final double btnRadius;

  MyButton({@required this.text, @required this.btnColor, @required this.btnRadius});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width * 0.85,
      height: 45,
      child: Text(
        widget.text,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: widget.btnColor,
        borderRadius: BorderRadius.circular(widget.btnRadius),
      ),
    );
  }
}