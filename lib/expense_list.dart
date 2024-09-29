import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:udemy_expense/expense_item.dart';

import 'expense.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key, required this.expense, required this.deleteTask});

  final List<Expense> expense;
  final Function(int, Expense) deleteTask;
  // final Function(Expense[index]) deletetask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (ctx, index) => Slidable(
              endActionPane: ActionPane(motion: StretchMotion(), children: [
                SlidableAction(
                  onPressed: (BuildContext) =>
                      deleteTask(index, expense[index]),
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                ),
              ]),
              child: ExpenseItem(
                expense[index],
              ),
            ));
  }
}
