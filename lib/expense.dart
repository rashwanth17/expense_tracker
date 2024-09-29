import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Catergory { food, travel, leisure, work }

final formatted = DateFormat.yMd();

const CatergoryIcons = {
  Catergory.food: Icons.fastfood,
  Catergory.travel: Icons.travel_explore,
  Catergory.leisure: Icons.movie,
  Catergory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catergory})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catergory catergory;

  String get fortmmatedDate {
    return formatted.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.catergory,
    required this.expenses,
  });

  ExpenseBucket.forCatergory(List<Expense> allExpenses, this.catergory)
      : expenses = allExpenses
            .where((expense) => expense.catergory == catergory)
            .toList();

  final Catergory catergory;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
