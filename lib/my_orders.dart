import 'package:flutter/material.dart';
import 'package:rod_erp/google_sheets_api.dart';
import 'package:rod_erp/loading_circle.dart';
import 'package:rod_erp/order.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {








  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userName = arg['userName'];

    List<List<dynamic>> myOrders = [];

    for (int i = 0; i < GoogleSheetsAPI.currentOrders.length; i++) {
      if (GoogleSheetsAPI.currentOrders[i][4] == userName) {
        myOrders.add(
          [
            GoogleSheetsAPI.currentOrders[i][0],
            GoogleSheetsAPI.currentOrders[i][1],
            GoogleSheetsAPI.currentOrders[i][2],
            GoogleSheetsAPI.currentOrders[i][3],
            GoogleSheetsAPI.currentOrders[i][4],
            GoogleSheetsAPI.currentOrders[i][5],
            GoogleSheetsAPI.currentOrders[i][6],
            GoogleSheetsAPI.currentOrders[i][7],
            GoogleSheetsAPI.currentOrders[i][8],
          ]
        );
      }
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Мои заказы $userName')
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(child:
          GoogleSheetsAPI.loading == true
              ? const LoadingCircle()
              : ListView.builder(
              itemCount: myOrders.length,
              itemBuilder: (context, index) {
                return Order(
                    zaknum: myOrders[index][0],
                    adress: myOrders[index][1],
                    kolvo: myOrders[index][2],
                    kolvomkv: myOrders[index][3],
                    zakazchik: myOrders[index][4],
                    datedostav: myOrders[index][5],
                    series: myOrders[index][6],
                    summan: myOrders[index][7],
                    propl: myOrders[index][8]);

              })
          )

        ],
      ),
    );
  }
}
