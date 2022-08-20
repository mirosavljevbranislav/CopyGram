import 'package:flutter/material.dart';

class FailedLoginWidget extends StatefulWidget {
  const FailedLoginWidget({Key? key}) : super(key: key);

  @override
  State<FailedLoginWidget> createState() => _FailedLoginWidgetState();
}

class _FailedLoginWidgetState extends State<FailedLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const [
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
