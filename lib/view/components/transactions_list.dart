import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<TransactionsProvider>(context).transactions;

    return Expanded(
      child: Container(
        color: Colors.white, // Simplificando BoxDecoration
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final isIncome = transaction.type ==
                TransactionType
                    .income; // Variable para evitar repetir la comparación

            return ListTile(
              leading: Icon(
                isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: isIncome ? Colors.teal : Colors.red,
              ),
              title: Text(transaction.description),
              subtitle: Text(isIncome ? 'Income' : 'Expense'),
              trailing: Text(
                '${isIncome ? '+' : '-'} ${NumberFormat.simpleCurrency().format(transaction.amount)}', // Formato de moneda simplificado
                style: TextStyle(
                  fontSize: 14,
                  color: isIncome ? Colors.teal : Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
