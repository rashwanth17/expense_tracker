import 'package:flutter/material.dart';
import 'package:udemy_expense/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.onaddexpense}) : super(key: key);

  final Function(Expense expense) onaddexpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _textcontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;
  Catergory _selectedcategory = Catergory.work;

  void _date() async {
    final now = DateTime.now();
    final last = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: last,
      lastDate: now,
    );
    if (pickeddate != null) {
      setState(() {
        _selecteddate = pickeddate;
      });
    }
  }

  void _submitedvalues() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final _amountinvalid = enteredamount == null || enteredamount <= 0;
    if (_amountinvalid ||
        _textcontroller.text.trim().isEmpty ||
        _selecteddate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              'INVALID INPUT',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          content: Text("PLEASE ENTER ALL VALUES AND MUST BE VALID"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OKAY"),
            )
          ],
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
      return;
    }

    final newExpense = Expense(
      title: _textcontroller.text,
      amount: enteredamount!,
      date: _selecteddate!,
      catergory: _selectedcategory,
    );

    widget.onaddexpense(newExpense);
    Navigator.pop(context); // Close the new expense screen after adding.
  }

  @override
  void dispose() {
    _textcontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _textcontroller,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: Text("\$ "),
                    labelText: 'Amount',
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selecteddate == null
                        ? "No date selected"
                        : formatted.format(_selecteddate!)),
                    IconButton(
                      onPressed: _date,
                      icon: Icon(Icons.calendar_today),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<Catergory>(
                value: _selectedcategory,
                items: Catergory.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedcategory = value;
                    });
                  }
                },
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Cancel button pressed, so just go back.
                },
                child: Text("Cancel"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _submitedvalues,
                child: Text("Submit"),
              )
            ],
          )
        ],
      ),
    );
  }
}
