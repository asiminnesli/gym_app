import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/model/programs.dart';
import 'package:gym_app/utils/dbHelper.dart';

class CreateProgramPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateProgramPageState();
  }
}

List<String> selectedExerciseList = [];

List<String> getAllExercises() {
  final exercisesFuture = Exercises().getList();
  List<String> exercisesNames = [];
  exercisesFuture.then((result) => {
        result.forEach((element) {
          exercisesNames.add(element.exerciseName);
        })
      });
  return exercisesNames;
}

class CreateProgramPageState extends State {
  DbHelper helper = DbHelper();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    getAllExercises();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.ac_unit)),
        title: Text("Create Program"),
      ),
      body: Column(
        children: [
          selectedExercises,
          bottomGroup,
        ],
      ),
    );
  }

  Container get bottomGroup {
    int programId;
    return Container(
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              items: getAllExercises(),
              label: "Select Exercise",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (data) {
                selectedExerciseList.add(data!);
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TextButton(
                  onPressed: () async => {
                        programId = await Programs().getLastProgramId() + 1,
                        selectedExerciseList.forEach((selectedExercise) {
                          Programs().insertOne(programId, selectedExercise);
                        }),
                        Navigator.pop(context)
                      },
                  child: Text("Create Program and Return",
                      style: TextStyle(fontSize: 24, color: Colors.black))),
            ),
          ],
        ));
  }

  Expanded get selectedExercises {
    return Expanded(
      child: ListView.builder(
          itemCount: selectedExerciseList.length,
          itemBuilder: (BuildContext context, int position) => Card(
                child: ListTile(
                  title: (selectedExerciseList.length == 0)
                      ? Text("")
                      : Text(selectedExerciseList[position]),
                  trailing: IconButton(
                      onPressed: () => {
                            selectedExerciseList.removeAt(position),
                            setState(() => {})
                          },
                      icon: Icon(Icons.delete)),
                ),
              )),
    );
  }
}
