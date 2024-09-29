import 'package:flutter/material.dart';
import 'package:udemy_expense/chart.dart';
import 'package:udemy_expense/expense.dart';
import 'package:udemy_expense/expense_list.dart';
import 'package:udemy_expense/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _dummydata = [
    Expense(
        title: "canteen",
        amount: 20.00,
        date: DateTime.now(),
        catergory: Catergory.food),
    Expense(
        title: "movie",
        amount: 100.00,
        date: DateTime.now(),
        catergory: Catergory.leisure),
  ];

  void _bottomsheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onaddexpense: _addedvalue));
  }

  void _addedvalue(Expense expense) {
    setState(() {
      _dummydata.add(expense);
    });
  }

  void deletevalue(int index, Expense expense) {
    setState(() {
      _dummydata.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('EXPENSE HAS BEEN DELETED'),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _dummydata.insert(index, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = Center(
      child: Text("NO EXPENSES ADDED"),
    );

    if (_dummydata.isNotEmpty) {
      maincontent = ExpenseList(
        expense: _dummydata,
        deleteTask: deletevalue,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense tracker"),
        actions: [IconButton(onPressed: _bottomsheet, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [Chart(expenses: _dummydata), Expanded(child: maincontent)],
      ),
    );
  }
}
