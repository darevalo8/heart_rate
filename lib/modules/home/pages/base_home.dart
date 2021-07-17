import 'package:flutter/material.dart';
import 'package:heart_rate/src/widgets/curve_painter.dart';

class BaseHome extends StatelessWidget {
  const BaseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [_backgroundInfo()],
        ),
      ),
    );
  }

  Widget _backgroundInfo() {
    return Container(
      width: double.infinity,
      height: 400,
      child: CustomPaint(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '112',
              style: TextStyle(
                color: Colors.white,
                fontSize: 110,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'rpm',
              style: TextStyle(
                color: Colors.white30,
                fontSize: 60,
                // fontWeight: FontWeight.w100,
              ),
            )
          ],
        ),
        painter: CurvePainter(),
      ),
      // decoration: BoxDecoration(
      //   color: Colors.redAccent,
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.elliptical(200, 100)
      //   )
      // ),
    );
  }
}
