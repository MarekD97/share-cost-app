import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/person_model.dart';
import 'package:share_cost_app/services/cloud_firebase_service.dart';

class CreateExpenseView extends StatefulWidget {
  const CreateExpenseView({Key? key}) : super(key: key);

  @override
  State<CreateExpenseView> createState() => _CreateExpenseViewState();
}

class _CreateExpenseViewState extends State<CreateExpenseView> {
  DateTime _selectedDate = DateTime.now();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _paidByController = TextEditingController();

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
    final groupId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['id'];

    void onSubmitForm() async {
      final name = _nameController.text;
      final element = await CloudFirebaseService.getGroupById(groupId).first;
      Group group =
          Group.fromJson(element.docs[0].data() as Map<String, dynamic>);
      final paidBy = group.members.firstWhere(
          (person) => person.name == _paidByController.text, orElse: () {
        Person member = Person(name: _paidByController.text);
        CloudFirebaseService.addMemberToGroup(groupId, member);
        return member;
      });
      final amountSpend = num.parse(_amountController.text
          .substring(0, _amountController.text.length - 4)
          .replaceFirst(',', '.')
          .replaceAll(RegExp(r"\s+"), ""));
      Expense expense = Expense(
          name: name,
          paidBy: paidBy,
          paidFor: [paidBy],
          amountSpent: amountSpend,
          category: 'Unknown',
          createdAt: _selectedDate);
      CloudFirebaseService.addExpenseToGroup(groupId, expense);
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Create new expense')),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            shrinkWrap: true,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  CurrencyTextInputFormatter(locale: 'pl', decimalDigits: 2)
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Amount spent'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _dateController,
                keyboardType: TextInputType.none,
                showCursor: false,
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_month)),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _paidByController,
                decoration: const InputDecoration(
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
