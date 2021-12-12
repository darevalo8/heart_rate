import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomaly_cubit.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomalydetail_cubit.dart';
import 'package:heart_rate/modules/anomalies/blocs/historydetail_cubit.dart';
import 'package:heart_rate/modules/home/blocs/home_cubit.dart';
import 'package:heart_rate/modules/home/blocs/navbar_cubit.dart';

import 'package:heart_rate/modules/home/pages/nav_bar_page.dart';
import 'package:heart_rate/modules/user/blocs/user_cubit.dart';

class RunHome extends StatelessWidget {
  const RunHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavbarCubit>(create: (context) => NavbarCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit(context.read(), context.read())),
        BlocProvider<UserCubit>(create: (context)=> UserCubit(context.read())),
        BlocProvider<AnomalyCubit>(create: (context)=> AnomalyCubit(context.read())),
        BlocProvider<HistorydetailCubit>(create: (context)=> HistorydetailCubit(context.read())),
        BlocProvider<AnomalydetailCubit>(create: (context)=> AnomalydetailCubit(context.read())),

        
        // BlocProvider(create: (context) => MenuCubit(context.read())..init()),

      ],
      child: NavBarPage(),
    );
  }
}