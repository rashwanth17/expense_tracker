import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:udemy_expense/expense.dart';
import 'package:udemy_expense/expense.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Text(expense.title),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$' + expense.amount.toStringAsFixed(2)),
                  Spacer(),
                  Row(
                    children: [
                      Icon(CatergoryIcons[expense.catergory]),
                      SizedBox(
                        width: 8,
                      ),
                      Text(expense.fortmmatedDate)
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
