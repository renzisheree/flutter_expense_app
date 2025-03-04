import 'package:expenese_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('\$${expense.amount}')),
          ),
        ),
        title: Row(
          children: [Icon(categoryIcon[expense.category]), Text(expense.title)],
        ),
        subtitle: Text(expense.formattedDate.toString()),
        trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
      ),
    );
  }
}
