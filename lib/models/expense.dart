import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, bills, transport, others }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.bills: Icons.money_off_csred_outlined,
  Category.transport: Icons.flight_takeoff,
  Category.others: Icons.multiple_stop_outlined,
};

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
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
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenese, this.category)
    : expenses = allExpenese.where((e) => e.category == category).toList();
  final Category category;
  final List<ExpenseModel> expenses;
  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
