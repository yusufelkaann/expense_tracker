import 'package:flutter/material.dart';

class IncomeWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final TextStyle titleStyle;
  final String amount;
  final TextStyle amountStyle;

  const IncomeWidget({
    super.key,
    required this.icon,
    this.iconSize = 16,
    this.iconColor = Colors.greenAccent,
    this.iconBackgroundColor = Colors.white30,
    required this.title,
    required this.titleStyle,
    required this.amount,
    required this.amountStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 25,
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Text(
              amount,
              style: amountStyle,
            ),
          ],
        ),
      ],
    );
  }
}
