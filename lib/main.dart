import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/new_transactions.dart';
import './widgets/chart.dart';
import './widgets/transactions_list.dart';

// ROOT Widget

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Quicksand",
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

// HOMEPAGE WIDGET

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "1",
      title: "Grocery Items",
      amount: 36,
      date: DateTime(2022, 9, 29),
    ),
    Transaction(
      id: "2",
      title: "Clothing",
      amount: 185,
      date: DateTime(2022, 9, 28),
    ),
    Transaction(
      id: "3",
      title: "Car Gas",
      amount: 12,
      date: DateTime(2022, 9, 27),
    ),
  ];

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(context) {
    showModalBottomSheet(
        context: context,
        builder: (bContext) {
          return NewTransactions(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = (mediaQuery.orientation == Orientation.landscape);
    final navigationBar = CupertinoNavigationBar(
        middle: const Text("Expense Tracker"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () => _startAddNewTransaction(context),
                child: const Icon(CupertinoIcons.add)),
          ],
        ));
    final appBar = AppBar(
      title: const Text("Expense Tracker"),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );

    final chartSwitch = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.vertical) *
          0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Show Chart"),
          Switch.adaptive(
              value: _showChart,
              onChanged: (value) => setState(() {
                    _showChart = value;
                  }))
        ],
      ),
    );

    final transactionList = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.vertical) *
          0.7,
      child: TransactionsList(_userTransactions, _deleteTransaction),
    );

    final chart = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.vertical) *
          (isLandscape ? 0.7 : 0.3),
      child: Chart(
        _userTransactions,
      ),
    );

    final scaffoldBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape) chartSwitch,
            if (isLandscape) _showChart ? chart : transactionList,
            if (!isLandscape) chart,
            if (!isLandscape) transactionList,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: navigationBar,
            child: scaffoldBody,
          )
        : Scaffold(
            appBar: appBar,
            body: scaffoldBody,
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
          );
  }
}
