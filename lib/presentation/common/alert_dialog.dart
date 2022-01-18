import 'package:flutter/material.dart';

showAllowNotificationsDialog({
  required void Function() allow,
  required void Function() denie,
}) {
  return AlertDialog(
    title: Text('Allow Notifications'),
    content: Text('Our app would like to send you notifications.'),
    actions: [
      TextButton(
          onPressed: denie,
          child: Text(
            'Don\'t Allow',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          )),
      TextButton(
          onPressed: allow,
          child: Text(
            'Allow',
            style: TextStyle(
                color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold),
          )),
    ],
  );
}
