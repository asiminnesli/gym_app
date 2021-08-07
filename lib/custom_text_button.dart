import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Widget page;
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              )
            },
        child: Text("$text"));
  }
}
