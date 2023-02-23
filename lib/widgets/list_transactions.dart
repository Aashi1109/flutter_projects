import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    // print('printing $transactions.isEmpty');

    return SizedBox(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  const Text(
                    'No expenses found.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // style: Theme.of(),
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    margin: const EdgeInsets.all(10),
                    child: Image.asset('assets/images/waiting.png'),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? TextButton.icon(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.redAccent,
                            ),
                            label: const Text('Delete'),
                          )
                        : IconButton(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.redAccent,
                            )),
                  ),
                  // child: Container(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     children: [
                  //       Card(
                  //         margin: const EdgeInsets.only(right: 10),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               border:
                  //                   Border.all(color: Colors.purple, width: 2),
                  //               borderRadius:
                  //                   const BorderRadius.all(Radius.circular(6))),
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 15),
                  //           child: Text(
                  //             '\$${transactions[index].amount.toStringAsFixed(2)}',
                  //             style: const TextStyle(
                  //               fontSize: 24,
                  //               color: Colors.purple,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             transactions[index].name,
                  //             style: const TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 18,
                  //             ),
                  //             // style: Theme.of(context).textTheme.titleLarge,
                  //           ),
                  //           Text(DateFormat.yMMMEd()
                  //               .format(transactions[index].date)),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
