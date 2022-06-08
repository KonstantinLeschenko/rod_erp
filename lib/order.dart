import 'package:flutter/material.dart';

class Order extends StatelessWidget {

  final String zaknum;
  final String adress;
  final String kolvo;
  final String kolvomkv;
  final String zakazchik;
  final String datedostav;
  final String series;
  final String summan;
  final String propl;

  Order({
    required this.zaknum,
    required this.adress,
    required this.kolvo,
    required this.kolvomkv,
    required this.zakazchik,
    required this.datedostav,
    required this.series,
    required this.summan,
    required this.propl
  });



  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 12.0,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.grey[100],
          child: Column(
            children: [
              Text('Заказ: $zaknum'),
              Text('Заказчик: $zakazchik'),
              Text('Адрес: $adress'),
              Text('Серия: $series'),
              Text('Количество, шт: $kolvo'),
              Text('Количество, м.кв.: $kolvomkv'),
              Text('Доставка: $datedostav'),
              Text('Стоимость: $summan'),
              Text('Оплата: $propl'),

            ],
          ),
        ),
      ),);
  }
}