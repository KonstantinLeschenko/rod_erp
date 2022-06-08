import 'package:flutter/material.dart';
import 'package:rod_erp/google_sheets_api.dart';
import 'package:rod_erp/loading_circle.dart';
import 'package:rod_erp/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Все заказы'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(child:
          GoogleSheetsAPI.loading == true
          ? const LoadingCircle()
          : ListView.builder(
            itemCount: GoogleSheetsAPI.currentOrders.length,
              itemBuilder: (context, index) {
              return Order(
                  zaknum: GoogleSheetsAPI.currentOrders[index][0],
                  adress: GoogleSheetsAPI.currentOrders[index][1],
                  kolvo: GoogleSheetsAPI.currentOrders[index][2],
                  kolvomkv: GoogleSheetsAPI.currentOrders[index][3],
                  zakazchik: GoogleSheetsAPI.currentOrders[index][4],
                  datedostav: GoogleSheetsAPI.currentOrders[index][5],
                  series: GoogleSheetsAPI.currentOrders[index][6],
                  summan: GoogleSheetsAPI.currentOrders[index][7],
                  propl: GoogleSheetsAPI.currentOrders[index][8]);

              })
          )
        ],
      ),
    );
  }
}
