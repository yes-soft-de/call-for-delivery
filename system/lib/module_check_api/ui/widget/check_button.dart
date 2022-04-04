import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CheckButton extends StatelessWidget {
  final bool loading;
  final String text;

  CheckButton( {required this.loading,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child:loading ?LoadingIndicator(
          indicatorType:
          Indicator.ballTrianglePathColoredFilled,
          colors: [Colors.white],
        ): Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
