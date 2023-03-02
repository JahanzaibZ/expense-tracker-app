import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> userTransactions;

  final Function deleteTransactions;

  const TransactionsList(this.userTransactions, this.deleteTransactions,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (context, contraints) => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(contraints.maxHeight * 0.05),
                  height: contraints.maxHeight * 0.25,
                  child: FittedBox(
                    child: Text(
                      "No transactions added yet!",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: contraints.maxHeight * 0.075,
                ),
                SizedBox(
                  height: contraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    //fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: contraints.maxHeight * 0.075,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  userTransactions[index], deleteTransactions);
            },
          );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: userTransactions.map((tx) {
  //       return Card(
  //         child: Row(children: [
  //           Container(
  //             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //             padding: const EdgeInsets.all(5),
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: Colors.purple,
  //                 width: 2,
  //               ),
  //             ),
  //             child: Text(
  //               "\$${tx.amount}",
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20,
  //                 color: Colors.purple,
  //               ),
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 tx.title,
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //               Text(
  //                 DateFormat.yMMMd().format(tx.date),
  //                 style: const TextStyle(
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ]),
  //       );
  //     }).toList(),
  //   );
  // }
}
