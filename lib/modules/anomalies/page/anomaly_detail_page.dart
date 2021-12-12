import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomaly_cubit.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomalydetail_cubit.dart';
import 'package:heart_rate/modules/anomalies/page/history_page.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/modules/home/pages/nav_bar_page.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/common/navigation_methods.dart';
import 'package:heart_rate/src/widgets/buttom_widget.dart';

class AnomalyDetailPage extends StatefulWidget {
  String anomalyId;
  AnomalyDetailPage({Key? key, required this.anomalyId}) : super(key: key);

  @override
  _AnomalyDetailPageState createState() => _AnomalyDetailPageState();
}

class _AnomalyDetailPageState extends State<AnomalyDetailPage> {
  AnswerChoice? marcaPaso,
      hormona,
      fatiga,
      aturdimiento,
      desmayos,
      ansiedad,
      angustia,
      cafeina,
      alcohol,
      fuma,
      dolorPecho,
      respirar,
      ejercicio = AnswerChoice.NO;
  @override
  Widget build(BuildContext context) {
    String title = "";
    String description =
        "No entres en panico. Toma calma y respira hondo. Responde estás preguntas, para descartar la anomalía.";
    return BlocProvider(
      create: (context) => AnomalydetailCubit(context.read()),
      child: BlocBuilder<AnomalydetailCubit, AnomalydetailState>(
        builder: (context, state) {
          if (state is AnomalydetailInitial) {
            context.read<AnomalydetailCubit>().init(widget.anomalyId);
          } else if ((state as AnomalydetailStatus).status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if ((state).status == Status.COMPLETED) {
            if (state.data!.isBradyCardia == 1) {
              title = "Se detectó una anomalía, posible Bradicardia";
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red[200],
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text("$title"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$description",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Tiene marca pasos?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: marcaPaso,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                marcaPaso = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: marcaPaso,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                marcaPaso = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Tiene la hormona tirodea baja?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: hormona,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                hormona = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: hormona,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                hormona = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Usted se siente fatigado?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: fatiga,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                fatiga = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: fatiga,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                fatiga = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Siente mareo o aturdimiento?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: aturdimiento,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                aturdimiento = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: aturdimiento,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                aturdimiento = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha tenido o tuvo desmayos en los ultimos 5 dias?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: desmayos,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                desmayos = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: desmayos,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                desmayos = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtomWidget(
                                onPressed: () {
                                  AnomalyDetail anomalyDetail = AnomalyDetail(
                                      anomalyId: int.parse(widget.anomalyId),
                                      tieneMarcaPasos: enumToInt(marcaPaso!),
                                      hormonaTirodeaBaja: enumToInt(hormona!),
                                      tieneFatiga: enumToInt(fatiga!),
                                      tieneMareoOAturdimiento:
                                          enumToInt(aturdimiento!),
                                      tuvoDesmayos: enumToInt(desmayos!));
                                  context
                                      .read<AnomalydetailCubit>()
                                      .addAnomalyDetail(anomalyDetail);
                                },
                                color: Colors.blueAccent,
                                text: "Guardar",
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state.data!.isTachyCardia == 1) {
              title = "Se detectó una anomalía, posible Taquicardia";
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red[200],
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text("$title"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$description",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha presentado cuadros de ansiedad en los últimos 5 días?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: ansiedad,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                ansiedad = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: ansiedad,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                ansiedad = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha recibido una noticia muy fuerte?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: angustia,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                angustia = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: angustia,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                angustia = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha bebido cafeina en el día?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: cafeina,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                cafeina = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: cafeina,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                cafeina = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha bebido bebidas alcoholicas en el día?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: alcohol,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                alcohol = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: alcohol,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                alcohol = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Usted es un fumador habitual?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: fuma,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                fuma = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: fuma,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                fuma = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha tenido dolor en el pecho en los últimos 5 días?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: dolorPecho,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                dolorPecho = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: dolorPecho,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                dolorPecho = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha tenido dificultad de respirar en los últimos 5 días?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: respirar,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                respirar = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: respirar,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                respirar = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "¿Ha relizado ejercicio en los ultimos 30 minutos?: ",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Si"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.SI,
                                            groupValue: ejercicio,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                ejercicio = value;
                                              });
                                            }),
                                        Text("No"),
                                        Radio<AnswerChoice>(
                                            value: AnswerChoice.NO,
                                            groupValue: ejercicio,
                                            onChanged: (AnswerChoice? value) {
                                              setState(() {
                                                ejercicio = value;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtomWidget(
                                onPressed: () {
                                  AnomalyDetail anomalyDetail = AnomalyDetail(
                                    anomalyId: int.parse(widget.anomalyId),
                                      tieneAnsiedad: enumToInt(ansiedad!),
                                      tuvoAngustia: enumToInt(angustia!),
                                      bebeCafeina: enumToInt(cafeina!),
                                      bebeAlcohol: enumToInt(alcohol!),
                                      fuma: enumToInt(fuma!),
                                      dolorPecho: enumToInt(dolorPecho!),
                                      dificultadRespirar: enumToInt(respirar!),
                                      haceEjercicio: enumToInt(ejercicio!));
                                  context
                                      .read<AnomalydetailCubit>()
                                      .addAnomalyDetail(anomalyDetail);
                                },
                                color: Colors.blueAccent,
                                text: "Guardar",
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
            // return Scaffold(
            //   appBar: AppBar(),
            //   body: SafeArea(
            //     child: Container(
            //       child: SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             Center(
            //               child: Text(""),
            //             ),
            //             Text(""),
            //             Expanded(
            //               child: ListTile(
            //                 title: const Text("¿Tiene Marca pasos?"),
            //                 // trailing: Radio(
            //                 //   value: AnswerChoice.NO,
            //                 //   groupValue: marcaPaso,
            //                 //   onChanged: (value) {
            //                 //     print("prueba");
            //                 //   },
            //                 // ),
            //                 // trailing: Row(
            //                 //   children: [
            //                 //     Text("Si"),
            //                 //     Radio<AnswerChoice>(value: AnswerChoice.SI,
            //                 //     groupValue: marcaPaso, onChanged: (AnswerChoice? value){
            //                 //       print("añañi si ");
            //                 //     }),
            //                 //     Text("No"),
            //                 //     Radio<AnswerChoice>(value: AnswerChoice.NO,
            //                 //     groupValue: marcaPaso, onChanged: (AnswerChoice? value){
            //                 //       print("añañi NO ");
            //                 //     })
            //                 //   ],
            //                 // ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          } else if ((state).status == Status.ERROR) {
            return Container(
              child: Center(
                child: Text(state.message!),
              ),
            );
          }else if ((state).status == Status.SUCCES) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red[200],
                ),
                body: SafeArea(
                  child: Container(
              child: Center(
                child: Text("Gracias por llenar la encuesta"),
              ),
            ),
                ));
            
          }
          return Container();
        },
      ),
    );
  }
}

enum AnswerChoice { SI, NO }

int enumToInt(AnswerChoice data) {
  if (data == AnswerChoice.SI) {
    return 1;
  } else {
    return 0;
  }
}
