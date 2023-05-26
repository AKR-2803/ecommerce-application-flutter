// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_major_project/features/admin/widgets/sales_graph/individual_bar.dart';

class SalesData {
  final num mobileSales;
  final num essentialsSales;
  final num booksSales;
  final num appliancesSales;
  final num fashionSales;
  SalesData({
    required this.mobileSales,
    required this.essentialsSales,
    required this.booksSales,
    required this.appliancesSales,
    required this.fashionSales,
  });

  List<IndividualBar> salesBarData = <IndividualBar>[];

  void initializeBar() {
    salesBarData = [
      IndividualBar(earnings: double.parse(mobileSales.toString()), label: '0'),
      IndividualBar(
          earnings: double.parse(essentialsSales.toString()), label: '1'),
      IndividualBar(earnings: double.parse(booksSales.toString()), label: '2'),
      IndividualBar(
          earnings: double.parse(appliancesSales.toString()), label: '3'),
      IndividualBar(
          earnings: double.parse(fashionSales.toString()), label: '4'),
    ];
  }
}
