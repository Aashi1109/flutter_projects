import 'dart:io';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/add_transaction.dart';
import './widgets/list_transactions.dart';
import '../models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Tracker',
        home: const ExpenseTracker(),
        theme: ThemeData(
          fontFamily: 'Quicksand',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //         titleLarge: const TextStyle(
          //       fontFamily: 'OpenSans',
          //       fontSize: 18,
          //     )),
          appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    titleLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                  )
                  .bodyMedium,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    titleLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .titleLarge),
        ));
  }
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Transaction> _transactions = [
    Transaction(
        amount: 25.56,
        date: DateTime(2023, 2, 19),
        name: 'Travelling',
        id: 't1'),
    Transaction(
        amount: 45.67, date: DateTime(2023, 2, 17), name: 'Food', id: 't2'),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _newExpense(String title, double amount, DateTime chosenDate) {
    setState(() {
      _transactions.add(Transaction(
          amount: amount,
          date: chosenDate,
          name: title,
          id: DateTime.now().toString()));
    });
  }

  void _startNewExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(addExpenseHandler: _newExpense);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        ElevatedButton(
          child: const Icon(Icons.add),
          onPressed: () => _startNewExpense(context),
        ),
      ],
    );
    final transactionsWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TransactionList(
          transactions: _transactions, deleteTransaction: _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _startNewExpense(context),
              child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          if (isLandscape)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Show Chart'),
              Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  })
            ]),
          if (!isLandscape)
            SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
          if (!isLandscape) transactionsWidget,
          if (isLandscape)
            _showChart
                ? SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        .7,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : transactionsWidget
        ]),
      ),
    );
  }
}
