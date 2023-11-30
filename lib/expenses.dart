import 'package:exp/chart.dart';
import 'package:exp/expenseslist.dart';
import 'package:exp/model/expense.dart';
import 'package:exp/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredexpenses = [
    Expense(
        title: 'flutter',
        amount: 40.0,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Goa',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void addexpenseoverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onaddExpense: addExpense,
            ));
  }

  void addExpense(Expense expense) {
    setState(() {
      registeredexpenses.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final ind = registeredexpenses.indexOf(expense);
    setState(() {
      registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:const Text('expense removed'),
          duration:const Duration(seconds: 3),
          action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredexpenses.insert(ind, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget main = const Center(
      child: Text('no expenses found'),
    );
    if (registeredexpenses.isNotEmpty) {
      main = ExpenseList(
        registeredexpenses,
        ondelete: deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: addexpenseoverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses:registeredexpenses),
          Expanded(
            child: main,
          ),
        ],
      ),
    );
  }
}
