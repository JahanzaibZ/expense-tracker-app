import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addNewTransaction;

  const NewTransactions(this.addNewTransaction, {super.key});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    } else {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.tryParse(_amountController.text);
      if (enteredAmount == null || enteredAmount < 0) {
        return;
      }
      widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
    }

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return null;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: const InputDecoration(
                label: Text("Amount"),
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Selected!"
                        : DateFormat.yMMMd().format(_selectedDate!)),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                "Add Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
