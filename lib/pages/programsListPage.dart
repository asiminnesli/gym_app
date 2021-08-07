import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/model/programs.dart';
import 'package:gym_app/pages/createProgramPage.dart';
import 'package:gym_app/pages/startProgramPage.dart';
import 'package:gym_app/utils/dbHelper.dart';
import 'package:gym_app/utils/uiHelper.dart';

class ProgramsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProgramsListPageState();
  }
}

class ProgramsListPageState extends State {
  DbHelper helper = DbHelper();
  List<Programs> programs = [];
  List<List<Exercises>> programExercises = [];
  int count = 0;

  TextEditingController newProgram = TextEditingController();

  void getPrograms() {
    final todosFuture = Programs().getProgramList();
    todosFuture.then((result) => {
          if (programs.length != result.length)
            {
              programs = result,
              count = programs.length,
              programs.forEach((program) async {
                program.exercises =
                    await getExercisesToProgram(program.programId);
              }),
              setState(() => {})
            }
        });
  }

  Future<List<Exercises>> getExercisesToProgram(int programId) async {
    print("$programId");
    return await Programs().getProgramExercises(programId);
  }

  @override
  Widget build(BuildContext context) {
    getPrograms();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back)),
        title: Text("Programs List"),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
        child: Column(
          children: [
            programList,
            bottomGroup,
          ],
        ),
      ),
    );
  }

  Container get programList {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int position) => Center(
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartProgramPage(
                                    programId:
                                        this.programs[position].programId)),
                          )
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF7176A3)),
                                color: Color(0xFF40435D)),
                            margin: EdgeInsets.only(
                                left: 50, right: 50, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    trailing: IconButton(
                                        onPressed: () => {},
                                        icon: Icon(Icons.delete_forever,
                                            color: Color(0xFFB8514F))),
                                    title: Text(
                                      "Program #" +
                                          this
                                              .programs[position]
                                              .programId
                                              .toString(),
                                      style:
                                          TextStyle(color: Color(0xFF3D84B8)),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 100,
                                    child: ListView.builder(
                                      itemCount: this
                                          .programs[position]
                                          .exercises
                                          .length,
                                      itemBuilder: (BuildContext context,
                                              int exercisePosition) =>
                                          Container(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: Text(
                                              this
                                                  .programs[position]
                                                  .exercises[exercisePosition]
                                                  .exerciseName,
                                              style: TextStyle(
                                                  color: Color(0xFF7176A3)),
                                            )),
                                      ),
                                    ))
                              ],
                            )),
                      ),
                    ))));
  }

  Container get bottomGroup {
    return Container(
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            Container(
              width: UiHelper().percentage(context, 0.85),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TextButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProgramPage()),
                        )
                      },
                  child: Container(
                    child: Text("Create New Program",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  )),
            ),
          ],
        ));
  }
}
