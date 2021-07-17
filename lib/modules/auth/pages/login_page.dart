import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/auth/blocs/login_cubit.dart';
import 'package:heart_rate/modules/home/pages/home_page.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/common/navigation_methods.dart';
import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';
import 'package:heart_rate/src/widgets/buttom_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
          // print('Soy un listener ${state.status}');

          switch (state.status) {
            case Status.LOADING:
              // Scaffold.of(context).
              break;
            case Status.ERROR:
              {
                
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Ha sucedido un errorrr')),
                  );

                break;
              }
            case Status.COMPLETED:
              {
                pushAndReplaceTopage(context, HomePage());
                break;
              }
            default:
          }
        }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                      onPressed: () {
                        context.read<LoginCubit>().login();
                      },
                      text: "Enlaza tu Reloj",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }

  Widget _getLogo() {
    return Container(child: Image.asset('assets/images/logo.png'));
  }
}
