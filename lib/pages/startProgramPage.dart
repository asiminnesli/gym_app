import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/model/programHistory.dart';
import 'package:gym_app/model/programs.dart';
import 'package:gym_app/pages/finishExercisePage.dart';
import 'package:gym_app/utils/uiHelper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StartProgramPage extends StatefulWidget {
  dynamic programId;
  StartProgramPage({Key? key, required this.programId}) : super(key: key);
  @override
  _StartProgramPageState createState() =>
      _StartProgramPageState(programId: programId);
}

class _StartProgramPageState extends State<StartProgramPage> {
  final programId;
  late TextEditingController repInputController = TextEditingController();
  late TextEditingController weightInputController = TextEditingController();
  List<Exercises> exercisesList = [];
  late ProgramHistory previousData;
  _StartProgramPageState({
    required this.programId,
  });
  int exercisePosition = 0;
  int exerciseCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(Icons.arrow_back)),
          title: Text("Exercising"),
        ),
        body: Container(
            decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
            child: exercisingPageBody()));
  }

  Center exercisingPageBody() {
    if (exercisesList.length == 0) {
      getProgramExercises(programId);
      return Center(child: Text("Şuanlık boş"));
    }
    return Center(
        child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 80),
            child: Text(exercisesList[exercisePosition].exerciseName,
                style: TextStyle(fontSize: 24, color: Colors.redAccent))),
        inputArea("Tekrar Sayısı (Rep)", repInputController, 1),
        inputArea("Ağırlık (Weight)", weightInputController, 0.5),
        Padding(padding: EdgeInsets.only(top: 40)),
        Container(
          width: UiHelper().percentage(context, 0.7),
          child: StepProgressIndicator(
            size: 8,
            totalSteps: exerciseCount,
            currentStep: exercisePosition,
            selectedColor: Color(0xFF9EA0A7),
            unselectedColor: Color(0xFF50567D),
          ),
        ),
        IconButton(
          onPressed: () async => {
            previousData = await ProgramHistory()
                .getHistoryData(programId, exercisesList[0].exerciseName),
            ProgramHistory().insertOne(
                programId,
                exercisesList[exercisePosition].exerciseName,
                int.parse(repInputController.text),
                double.parse(weightInputController.text)),
            if (exerciseCount != (exercisePosition + 1))
              {exercisePosition++}
            else
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinishedExercise()),
                )
              },
            setState(() {
              previousData = previousData;
              print(previousData.rep);
              // ignore: unnecessary_null_comparison
              if (previousData.rep != null) {
                repInputController.text = previousData.rep.toString();
                weightInputController.text = previousData.weight.toString();
              } else {
                repInputController.text = "0";
                weightInputController.text = "0.0";
              }
            })
          },
          icon: Container(
            padding: EdgeInsets.only(top: 20),
            child: Icon(Icons.play_circle_outline, color: Color(0xFF9EA0A7)),
          ),
          iconSize: 80,
        ),
      ],
    ));
  }

  Container inputArea(
      String label, TextEditingController controller, var step) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: UiHelper().percentage(context, 0.65),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "$label",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Color(0xFF4C5176),
                  borderRadius: BorderRadius.circular(50)),
              width: UiHelper().percentage(context, 0.9),
              child: Row(
                children: [
                  customIconButton(
                      Icon(AntDesign.minus),
                      () => {
                            if (step.runtimeType == int)
                              {
                                controller.text =
                                    (int.parse(controller.text) - step)
                                        .toString()
                              }
                            else
                              {
                                controller.text =
                                    (double.parse(controller.text) - step)
                                        .toString()
                              }
                          }),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      controller: controller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  customIconButton(
                      Icon(AntDesign.plus),
                      () => {
                            if (step.runtimeType == int)
                              {
                                controller.text =
                                    (int.parse(controller.text) + step)
                                        .toString()
                              }
                            else
                              {
                                controller.text =
                                    (double.parse(controller.text) + step)
                                        .toString()
                              }
                          }),
                ],
              )),
        ],
      ),
    );
  }

  Container customIconButton(Icon icon, Function()? f) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 48,
      decoration: BoxDecoration(
          color: Color(0xFF343A60), borderRadius: BorderRadius.circular(25)),
      child: IconButton(
        onPressed: f,
        iconSize: 24,
        icon: icon,
        color: Colors.white,
      ),
    );
  }

  void getProgramExercises(int programId) async {
    exercisesList = await Programs().getProgramExercises(programId);
    exerciseCount = exercisesList.length;

    previousData = await ProgramHistory()
        .getHistoryData(programId, exercisesList[0].exerciseName);
    setState(() {
      if (previousData.rep != null) {
        repInputController.text = previousData.rep.toString();
        weightInputController.text = previousData.weight.toString();
      } else {
        repInputController.text = "0";
        weightInputController.text = "0.0";
      }
    });
  }
}
