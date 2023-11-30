import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();

const iconCategory = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie_creation_outlined,
  Category.work: Icons.work
};

var uuid = const Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get total {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
