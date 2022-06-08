import 'package:flutter/material.dart';
import 'package:rod_erp/user.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userName = arg['userName'];
    String userRole = arg['userRole'];

    void showAllOrders() {
      if (userRole == 'admin') {
        Navigator.pushNamed(context, '/orders');
      }


    }

    void showMyOrders() {
      Navigator.pushNamed(context, '/my_orders', arguments: {
        'userName' : userName});
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(userName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: showMyOrders, child: Text('Мои заказы')),
            ElevatedButton(onPressed: showAllOrders, child: Text('ВСЕ заказы')),

          ],
        ),
      ),
    );


  }

















}
