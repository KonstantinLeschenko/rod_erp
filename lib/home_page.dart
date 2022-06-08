import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rod_erp/google_sheets_api.dart';
import 'package:rod_erp/user.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  bool timerHasStarted = false;
  var currentUser = User(userName: 'n', userPassword: 'm', userRole: 'none');

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsAPI.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if (GoogleSheetsAPI.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('USERNAME'),
            TextField(
              controller: userNameController,
            ),
            Text('PASSWORD'),
            TextField(
              controller: userPasswordController,
            ),
            ElevatedButton(onPressed: logIN, child: Text('OK'))
          ],
        ),
      ),

    );
  }

  Future logIN() async {
    String name = userNameController.text;
    String password = userPasswordController.text;
   // String role = 'none';
    currentUser = User(userName: 'n', userPassword: 'm', userRole: 'none');

    for (int i = 0; i < GoogleSheetsAPI.users.length; i++) {
      if ((name == GoogleSheetsAPI.users[i][0]) && (password == GoogleSheetsAPI.users[i][1])) {
        //role = GoogleSheetsAPI.users[i][2];
        //currentUser = User(userName: GoogleSheetsAPI.users[i][0], userPassword: GoogleSheetsAPI.users[i][1], userRole: GoogleSheetsAPI.users[i][2]);
        currentUser.setName(GoogleSheetsAPI.users[i][0]);
        currentUser.setPasswsord(GoogleSheetsAPI.users[i][1]);
        currentUser.setRole(GoogleSheetsAPI.users[i][2]);
      }
    }

    //print(currentUser.userName);
    //print(currentUser.userPassword);
    //print(currentUser.userRole);

    if (!(currentUser.userRole == 'none')) {
      Navigator.pushNamed(context, '/mainPage', arguments: {
        'userName' : currentUser.userName,
        'userRole' : currentUser.userRole});
    }
    


  }
}
