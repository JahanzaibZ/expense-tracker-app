import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(this.userTransaction, this.deleteTransactions,
      {super.key});

  final Transaction userTransaction;
  final Function deleteTransactions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(userTransaction.amount.toString()),
            ),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                label: const Text("Delete"),
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteTransactions(userTransaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  deleteTransactions(userTransaction.id);
                },
              ),
      ),
    );
  }
}
