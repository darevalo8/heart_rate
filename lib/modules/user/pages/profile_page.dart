import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/user/blocs/user_cubit.dart';
import 'package:heart_rate/src/common/api_fetch.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          context.read<UserCubit>().getProfile();
        } else if ((state as UserStatus).status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if ((state).status == Status.ERROR) {
          return Container(
            child: Center(
              child: Text(state.message!),
            ),
          );
        } else if ((state).status == Status.COMPLETED) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: _AvatarImageBox(avatar: state.data!.avatar150.toString(),),
                    ),
                    Center(
                      child: Text(
                        '${state.data!.fullName}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    _listBody(
                        'Fecha de nacimiento', '${state.data!.dateOfBirth}'),
                    Divider(),
                    _listBody('Edad', state.data!.age.toString()),
                    Divider(),
                    _listBody('Genero', state.data!.gender.toString()),
                    Divider(),
                    _listBody('Estatura', '${state.data!.height} cm'),
                    Divider(),
                    _listBody('Peso', '${state.data!.weight}kg'),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _listBody(String title, String subTile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$subTile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _AvatarImageBox extends StatelessWidget {
  String avatar;
  _AvatarImageBox({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(6),
        child: Container(
          width: 124,
          height: 124,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              this.avatar,
              fit: BoxFit.fill,
            ),
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
