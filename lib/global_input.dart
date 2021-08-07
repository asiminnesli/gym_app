import 'package:flutter/material.dart';

class GlobalInput extends StatelessWidget {
  final Function f;
  const GlobalInput({
    Key? key,
    required this.f,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: IconButton(onPressed: () => {f}, icon: Icon(Icons.play_arrow)));
  }
}
