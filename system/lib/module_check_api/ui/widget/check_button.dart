import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CheckButton extends StatelessWidget {
  final bool loading;

  CheckButton(this.loading);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
      ),
      child: Center(
        child:loading ?LoadingIndicator(
          indicatorType:
          Indicator.ballTrianglePathColoredFilled,
          colors: [Colors.blue.shade900],
        ): Text(
          'Check',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8185E2),
          ),
        ),
      ),
    );
  }
}
