import 'package:exp/expenseitem.dart';
import 'package:exp/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.expenses, {super.key, required this.ondelete});
  final List<Expense> expenses;
  final void Function(Expense expense) ondelete;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (con, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            ondelete(expenses[index]);
          },
          background: Container(
            color: const Color.fromARGB(255, 194, 118, 238),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          child: ExpenseItem(
            expenses[index],
          ),
        );
      },
    );
  }
}
