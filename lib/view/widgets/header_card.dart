import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  const HeaderCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount = NumberFormat.simpleCurrency().format(amount);

    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(formattedAmount, style: textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
