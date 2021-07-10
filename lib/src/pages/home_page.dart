import 'package:flutter/material.dart';
import 'package:heart_rate/src/widgets/curve_painter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home,),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Alertas'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text(
              'Perfil',
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          // BottomNavyBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   activeColor: Colors.blue,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
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
