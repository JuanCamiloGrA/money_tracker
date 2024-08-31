import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'Income';
  TransactionType type = TransactionType.income;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);

    return SizedBox(
      height: 680,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 50,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'New Transaction',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
            CupertinoSlidingSegmentedControl(
              groupValue: _transactionType,
              children: const {
                'Income': Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Income'),
                ),
                'Expense': Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Expense'),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  _transactionType = value.toString();
                  type = value == 'Income'
                      ? TransactionType.income
                      : TransactionType.expense;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'AMOUNT',
              style: textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            TextFormField(
              controller: _amountController,
              inputFormatters: [
                CurrencyTextInputFormatter.currency(symbol: '\$'),
              ],
              textAlign: TextAlign.center,
              decoration: const InputDecoration.collapsed(
                hintText: '\$0.00',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount =
                    double.tryParse(value.replaceAll(RegExp(r'[^\d.]'), ''));
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submitTransaction(transactionsProvider),
            ),
            const SizedBox(height: 20),
            Text(
              'DESCRIPTION',
              style: textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            TextFormField(
              controller: _descriptionController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Enter a description here',
                  hintStyle: TextStyle(color: Colors.grey)),
              keyboardType: TextInputType.text,
              onFieldSubmitted: (_) => _submitTransaction(transactionsProvider),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => _submitTransaction(transactionsProvider),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTransaction(TransactionsProvider transactionsProvider) {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(
          _amountController.text.replaceAll(RegExp(r'[^\d.]'), ''));

      final newTransaction = Transaction(
        type: type,
        amount: amount,
        description: _descriptionController.text,
      );

      transactionsProvider.addTransaction(newTransaction);
      Navigator.of(context).pop();
      _formKey.currentState!.reset();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }
}
