import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/anomalies/blocs/historydetail_cubit.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/src/common/api_fetch.dart';

class HistoryDetailPage extends StatelessWidget {
  String anomalyId;
  HistoryDetailPage({Key? key, required this.anomalyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistorydetailCubit(context.read()),
      child: BlocBuilder<HistorydetailCubit, HistorydetailState>(
        builder: (context, state) {
          if (state is HistorydetailInitial) {
            context.read<HistorydetailCubit>().getResultData(anomalyId);
          } else if ((state as HistoryDetailStatus).status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if ((state).status == Status.COMPLETED) {
            final Anomaly anomalia = state.data!["anomalia"];
            final List<String> messages = state.data!["messages"];
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red[200],
                title: anomalia.isTachyCardia == 1
                    ? Text("Posible Taquicardia")
                    : Text("Posible Bradicardia"),
              ),
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(child: _getLogo()),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    '${messages[index]}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  )
                ],
              )),
            );
          } else if ((state).status == Status.ERROR) {
            return Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: Container(
                  child: Center(
                    child: Text("${state.message}"),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

Widget _getLogo() {
  return Container(child: Image.asset('assets/images/cora4.jpg'));
}
