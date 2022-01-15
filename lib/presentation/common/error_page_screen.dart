import 'package:flutter/material.dart';

class ErrorPageScreen extends StatelessWidget {
  final String route;
  const ErrorPageScreen({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(fontSize: 20);

    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'The route \n', style: defaultStyle),
              TextSpan(
                  text: route,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              TextSpan(text: "\n doesn\'t exists.", style: defaultStyle),
            ],
          ),
        )
            // Text(
            //   'The route $route doesn\'t exists.',
            //   style: TextStyle(color: Colors.white, fontSize: 25),
            // ),
            ),
      ),
    );
  }
}
