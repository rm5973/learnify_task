import 'package:flutter/material.dart';

class VerificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User Verified'),
      content: Text('You have been successfully verified.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
