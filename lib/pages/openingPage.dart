import 'package:flutter/material.dart';
import 'package:gym_app/pages/historyPage.dart';
import 'package:gym_app/pages/exerciseListPage.dart';
import 'package:gym_app/pages/programsListPage.dart';
import 'package:gym_app/utils/uiHelper.dart';
import '../custom_text_button.dart';

class OpeningPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
      child: Column(
        children: [
          Spacer(),
          Center(
            child: Column(
              children: [
                CustomTextButton(
                    text: "Exercise List", page: ExerciseListPage()),
                CustomTextButton(
                    text: "Prepare Exercise", page: ProgramsListPage()),
                CustomTextButton(text: "History Page", page: HistoryPage()),
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
