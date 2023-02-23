import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return _groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            (element['amount'] as double) + previousValue);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _groupedTransactions
                // .map((data) => Text('${data['day']} ${data['amount']}'))
                .map(
                  (data) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'] as String,
                        data['amount'] as double,
                        maxSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / maxSpending),
                  ),
                )
                .toList()),
      ),
    );
  }
}
