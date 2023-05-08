import 'package:flutter/material.dart';

class Sales {
  final String? title;
  final double? total;

  Sales({this.title, this.total});
}

List demoSales = [
  Sales(title: "Shampoo", total: 0.0),
  Sales(title: "Hair Conditioner", total: 0.0),
  Sales(title: "Fabric Conditioner", total: 0.0),
  Sales(title: "Liquid Detergent", total: 0.0),
];
