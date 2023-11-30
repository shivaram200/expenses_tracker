import 'package:flutter/material.dart';
import 'package:exp/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddExpense});
  final void Function(Expense expense) onaddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpensestate();
  }
}

class _NewExpensestate extends State<NewExpense> {
  final textcontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selecteddate;
  Category selectedcat = Category.leisure;
  @override
  void dispose() {
    textcontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  void validate() {
    final enteredamount = double.tryParse(amountcontroller.text);
    final amountinvalid = enteredamount == null || enteredamount <= 0;
    if (textcontroller.text.trim().isEmpty ||
        amountinvalid ||
        selecteddate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('please make sure to enter valid details'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onaddExpense(Expense(
        title: textcontroller.text,
        amount: enteredamount,
        date: selecteddate!,
        category: selectedcat));
    Navigator.pop(context);
  }

  void datepicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selecteddate = pickedDate;
    });
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: textcontroller,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 30,
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selecteddate == null
                          ? 'no date selected'
                          : formatter.format(selecteddate!),
                    ),
                    IconButton(
                      onPressed: () {
                        datepicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedcat,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedcat = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: validate,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
