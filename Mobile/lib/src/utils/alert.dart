import 'package:Mobile/src/utils/mcolors.dart';
import 'package:flutter/material.dart';

Future showSuccessAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: Column(
        children: [
          Text('Success'),
          Icon(
            Icons.check_circle_outline_rounded,
            color: MColors.success,
          )
        ],
      ),
    ),
  );
}
