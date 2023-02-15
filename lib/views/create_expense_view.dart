import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CreateExpenseView extends StatefulWidget {
  const CreateExpenseView({Key? key}) : super(key: key);

  @override
  State<CreateExpenseView> createState() => _CreateExpenseViewState();
}

class _CreateExpenseViewState extends State<CreateExpenseView> {
  DateTime _selectedDate = DateTime.now();

  final _dateController = TextEditingController();

  Future _selectDate(context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (selectedDate != null) {
      _selectedDate = selectedDate;
      _dateController.text = DateFormat.yMMMd().format(_selectedDate);
      _dateController.selection = TextSelection.fromPosition(TextPosition(
          offset: _dateController.text.length,
          affinity: TextAffinity.upstream));
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSubmitForm() {
      //TODO: create an expense
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Create new expense')),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            shrinkWrap: true,
            children: [
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Title'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  CurrencyTextInputFormatter(locale: 'pl', decimalDigits: 2)
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Amount'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _dateController,
                keyboardType: TextInputType.none,
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Date'),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Paid by'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: onSubmitForm, child: const Text('Create expense'))
            ],
          ),
        ));
  }
}
