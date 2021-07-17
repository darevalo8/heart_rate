import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 40.0,),
            Center(child: _AvatarImageBox()),
            Center(
              child: Text(
                'Daniel Arévalo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 60.0,),
            _listBody('Edad', '26'),
            Divider(),
            _listBody('Genero', 'Masculino'),
            Divider(),
            _listBody('Estatura', '1.80 cm'),
            Divider(),
            _listBody('Peso', '60kg'),
          ],
        ),
      ),
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
  // Widget _profileImage() {
  //   return Container(
  //     height: 400,
  //     width: 400,
  //     decoration: BoxDecoration(
  //       image:
  //     ),
  //   );
  // }
}

class _AvatarImageBox extends StatelessWidget {
  const _AvatarImageBox({Key? key}) : super(key: key);

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
              'https://firebasestorage.googleapis.com/v0/b/mi-cameo.appspot.com/o/avatars%2Fno-avatar.png?alt=media&token=1e70e97a-7a29-498d-9e00-819804af693a',
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
