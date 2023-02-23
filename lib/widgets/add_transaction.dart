import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addExpenseHandler;

  const AddTransaction({
    super.key,
    required this.addExpenseHandler,
  });

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateChosen;

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _dateChosen == null) {
      return;
    }
    widget.addExpenseHandler(enteredTitle, enteredAmount, _dateChosen);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selDate) {
      if (selDate == null) return;
      setState(() {
        _dateChosen = selDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      _dateChosen == null
                          ? const Text('Date not chosen')
                          : Expanded(
                              child: Text(
                                'Picked Date: ${DateFormat.yMd().format(_dateChosen!)}',
                              ),
                            ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Choose Date'),
                      )
                    ],
                  ),
                ),
                FilledButton(
                    onPressed: _submitData, child: const Text('Add Expense'))
              ],
            )),
      ),
    );
  }
}
