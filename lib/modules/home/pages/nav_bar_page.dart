import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/anomalies/page/history_page.dart';
import 'package:heart_rate/modules/home/blocs/navbar_cubit.dart';
import 'package:heart_rate/modules/home/pages/base_home.dart';
import 'package:heart_rate/modules/user/pages/profile_page.dart';
class NavBarPage extends StatelessWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    const List<Widget> _widgetOptions = [
    BaseHome(),
    HistoryPage(),
    ProfilePage()
  ];
    return BlocBuilder<NavbarCubit, int>(builder: (context, state){
      print("soyyy un state $state");
      return Scaffold(
      // backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: state,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => context.read<NavbarCubit>().changePosition(index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home,),
            title: Text('Home'),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('Alertas'),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text(
              'Perfil',
            ),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
          ),
          // BottomNavyBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   activeColor: Colors.blue,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
      body: _widgetOptions[state],
      
    );
    });
  }
}