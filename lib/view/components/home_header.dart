import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/view/widgets/header_card.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TransactionsProvider>(context);
    final totalIncome = provider.totalIncome;
    final totalExpense = provider.totalExpense;
    final balance = provider.balance;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            'MONEY TRACKER',
            style: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Balance:',
            style: textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Text(
            NumberFormat.simpleCurrency().format(balance),
            style: textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                HeaderCard(
                  title: 'Incomes',
                  amount: totalIncome,
                  icon: Icons.attach_money,
                  color: Colors.teal,
                ),
                const SizedBox(width: 12),
                HeaderCard(
                  title: 'Expenses',
                  amount: totalExpense,
                  icon: Icons.money_off,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
