import 'package:expenese_app/widget/chart/chart.dart';
import 'package:expenese_app/widget/expense_list/expense_list.dart';
import 'package:expenese_app/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenese_app/models/expense.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseModel> _registerExpenses = [
    ExpenseModel(
      title: "Flutter course",
      amount: 100.00,
      date: DateTime.now(),
      category: Category.bills,
    ),
    ExpenseModel(
      title: "Trip to HN",
      amount: 80.00,
      date: DateTime.now(),
      category: Category.transport,
    ),
    ExpenseModel(
      title: "Secret Santa",
      amount: 23.99,
      date: DateTime.now(),
      category: Category.others,
    ),
  ];
  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense: _addExpense),
    );
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registerExpenses.indexWhere(
      (e) => e.id == expense.id,
    );
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Expense removed"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(("No expenses found, start adding some?")),
    );
    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registerExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
