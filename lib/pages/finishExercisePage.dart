import 'package:flutter/material.dart';
import 'package:gym_app/pages/openingPage.dart';
import 'package:gym_app/utils/uiHelper.dart';

class FinishedExercise extends StatefulWidget {
  FinishedExercise({Key? key}) : super(key: key);

  @override
  _FinishedExerciseState createState() => _FinishedExerciseState();
}

class _FinishedExerciseState extends State<FinishedExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(Icons.arrow_back)),
          title: Text("Finished Exercising"),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Column(
                  children: [
                    Center(
                      child: Text("Egzersiz Bitmiştir."),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpeningPage()),
                          )
                        },
                        child: Center(
                          child: Text("Geri gitmek için Tıklayınız."),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ));
  }
}
