import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomaly_cubit.dart';
import 'package:heart_rate/modules/anomalies/page/anomaly_detail_page.dart';
import 'package:heart_rate/modules/anomalies/page/history_detail_page.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/common/navigation_methods.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    context.read<AnomalyCubit>().getAllAnomaly();
    return BlocBuilder<AnomalyCubit, AnomalyState>(
      builder: (context, state) {
        if (state is AnomalyInitial) {
          
        } else if ((state as AnomalyStatus).status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == Status.COMPLETED) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Icon(Icons.notification_important_outlined,
                              color: Colors.redAccent)),
                      Expanded(child: Text("Realizar Encuesta")),
                      Expanded(
                          child: Icon(Icons.check, color: Colors.greenAccent)),
                      Expanded(child: Text("Encuesta Terminada")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: _AnomalyList(),
                ),
              ],
            )),
          );
        } else if (state.status == Status.ERROR) {
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
}

class _AnomalyList extends StatelessWidget {
  const _AnomalyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<AnomalyCubit>().state;
    return ListView.builder(
      itemCount: (state as AnomalyStatus).data!.length,
      itemBuilder: (BuildContext contex, int index) {
        return Container(
          child: _AnomalyItem(
            anomaly: (state).data![index],
          ),
        );
      },
    );
  }
}

class _AnomalyItem extends StatelessWidget {
  Anomaly? anomaly;
  _AnomalyItem({Key? key, this.anomaly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = "";
    if (anomaly!.isBradyCardia == 1) {
      message = "Posible Bradicardia";
    } else if (anomaly!.isTachyCardia == 1) {
      message = "Posible Taquicardia";
    }
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text("$message"),
            leading: anomaly!.status == 0
                ? Icon(Icons.notification_important_outlined,
                    color: Colors.redAccent)
                : Icon(Icons.check, color: Colors.greenAccent),
            subtitle: Text("${anomaly!.createAt}"),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.blueGrey,
            ),
            onTap: () {
              if (anomaly!.status == 0) {
                pushTopageBloc(context, AnomalyDetailPage(anomalyId: anomaly!.id.toString()), context.read<AnomalyCubit>());
                // pushTopage(context,
                //     AnomalyDetailPage(anomalyId: anomaly!.id.toString()));
              } else if (anomaly!.status == 1) {
                pushTopageBloc(context, HistoryDetailPage(anomalyId: anomaly!.id.toString()), context.read<AnomalyCubit>());
                // pushTopage(context,
                //     HistoryDetailPage(anomalyId: anomaly!.id.toString()));
              }
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
