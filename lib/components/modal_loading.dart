// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../ruler.dart';
import 'tool_game_provider.dart';

void openLoaderDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white54,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ruler.setText(
                  'Tool Game',
                  size: Ruler.setSize + 4,
                  color: Colors.green,
                ),
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 5000,
                  padding: const EdgeInsets.all(0),
                  percent: 1,
                  animateFromLastPercent: true,
                  lineHeight: 10.0,
                  clipLinearGradient: true,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey[300],
                ),
                Consumer<ToolGameProvider>(
                  builder: (context, value, child) => Ruler.setText(
                    '${value.percent}%',
                    size: Ruler.setSize + 2,
                    color: Colors.green,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Loading hack...",
                      style: TextStyle(
                        fontSize: Ruler.setSize + 2,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

void closeLoaderDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
