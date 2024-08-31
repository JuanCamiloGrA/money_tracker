import 'package:flutter/material.dart';
import 'package:money_tracker/model/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      type: TransactionType.income,
      amount: 1000,
      description: 'Salary',
    ),
    Transaction(
      type: TransactionType.expense,
      amount: 200,
      description: 'Groceries',
    ),
    Transaction(
      type: TransactionType.expense,
      amount: 100,
      description: 'Shopping',
    ),
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  double get totalIncome {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalExpense {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0, (sum, transaction) => sum + transaction.amount);
  }

  double get balance {
    return totalIncome - totalExpense;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }
}
