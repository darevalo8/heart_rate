import 'package:flutter/material.dart';
import 'package:heart_rate/src/widgets/buttom_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _getLogo(),
          SizedBox(
            height: 40,
          ),
          Text('Heart Rate',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Conoce el estado de tu corazon, con heart rate te alerta sobre anomalias en tu ritmo cardiaco',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ButtomWidget(
            onPressed: () {},
            text: "Enlaza tu Reloj",
          ),
          SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }

  Widget _getLogo() {
    return Container(child: Image.asset('assets/images/logo.png'));
  }
}
