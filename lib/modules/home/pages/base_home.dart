import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/main.dart';
import 'package:heart_rate/modules/anomalies/page/anomaly_detail_page.dart';
import 'package:heart_rate/modules/home/blocs/home_cubit.dart';
import 'package:heart_rate/modules/home/models.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/common/navigation_methods.dart';
import 'package:heart_rate/src/widgets/buttom_widget.dart';
import 'package:heart_rate/src/widgets/curve_painter.dart';
import 'package:provider/provider.dart';

class BaseHome extends StatefulWidget {
  const BaseHome({Key? key}) : super(key: key);

  @override
  _BaseHomeState createState() => _BaseHomeState();
}

class _BaseHomeState extends State<BaseHome> {
  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeCubit>().init();
        } else if ((state as HomeStatus).status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if ((state).status == Status.COMPLETED) {
          // return Scaffold(
          //   body: SafeArea(
          //     child: Column(
          //       verticalDirection: VerticalDirection.up,
          //       children: [
          //         Expanded(
          //           flex: 2,
          //           child: _backgroundInfo(state.data),
          //         ),
          //         Expanded(
          //             child: Container(
          //           child: Center(
          //             child: ButtomWidget(
          //               onPressed: () {
          //                 context.read<HomeCubit>().addAnomaliy();
          //               },
          //               text: 'Notificar Anomalia',
          //               color: Colors.red,
          //             ),
          //           ),
          //         )),
          //         // _Dots(),
          //         // Expanded(child: _Slides()),
          //       ],
          //     ),
          //   ),
          // );
          return ChangeNotifierProvider(
            create: (_) => new SliderModel(),
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _backgroundInfo(state.data),
                    ),
                    Expanded(
                        child: Container(
                      child: Center(
                        child: ButtomWidget(
                          onPressed: () {
                            context.read<HomeCubit>().addAnomaliy();
                          },
                          text: 'Notificar Anomalia',
                          color: Colors.red,
                        ),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: Center(
                        child: ButtomWidget(
                          onPressed: () {
                            context.read<HomeCubit>().addAnomaliy2();
                          },
                          text: 'Notificar Bradicardia',
                          color: Colors.red,
                        ),
                      ),
                    )),
                    
                    // _Dots(),
                    Expanded(child: _Slides()),
                  ],
                ),
              ),
            ),
          );
        } else if ((state).status == Status.ERROR) {
          return Container(
            child: Center(
              child: Text(state.message!),
            ),
          );
        }
        return Container();
      },
    );

  }

  Widget _backgroundInfo(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      height: 400,
      child: CustomPaint(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${data["value"]["restingHeartRate"]}",
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

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      print("se ejecuta o no");
      if (payload != null) {
        print("no tenemos pyloa $payload");
        pushTopage(
            context,
            AnomalyDetailPage(
              anomalyId: payload,
            ));
      }
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.add(null);
    selectNotificationSubject.close();
    super.dispose();
  }
}

// TODO verificar por que el provider jode la pantalla

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(
            index: 0,
          ),
          _Dot(
            index: 1,
          ),
          _Dot(
            index: 2,
          ),
          _Dot(
            index: 3,
          )
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (pageViewIndex == index) ? Colors.blue : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key}) : super(key: key);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      print("Página actual ${pageViewController.page}");
      // Actualizar el provider , SliderModel
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: PageView(
        controller: pageViewController,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fondo1.jpeg")
              )
            ),
      
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fondo2.jpeg")
              )
            ),
          ),
          Container(
            child: Center(
              child: Text('Mensajes de cuidado de tu ritmo #3'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Mensajes de cuidado de tu ritmo #4'),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: unused_element
class _Slide extends StatelessWidget {
  final String svg;
  const _Slide({Key? key, required this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: Text('hola'),
    );
  }
}
