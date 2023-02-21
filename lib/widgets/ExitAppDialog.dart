import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Change design according to the ConfirmDialog or even consider using the same widget for every case
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: const Text("This will close the app."),
      actions: [
        TextButton(
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => SystemNavigator.pop(),
        ),
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      title: const Text("Exit App?"),
    );
  }
}
