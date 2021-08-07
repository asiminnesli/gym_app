import 'package:flutter/material.dart';
import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/utils/dbHelper.dart';
import 'package:gym_app/utils/uiHelper.dart';

class ExerciseListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExerciseListPageState();
  }
}

class ExerciseListPageState extends State {
  DbHelper helper = DbHelper();
  List<Exercises> exercises = [];
  int count = 0;

  TextEditingController newExerciseName = TextEditingController();

  void getData() {
    final todosFuture = Exercises().getList();
    todosFuture.then((result) => {
          if (exercises.length != result.length)
            {
              setState(() => {
                    exercises = result,
                    count = exercises.length,
                  })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back)),
        title: Text("Exercises List"),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
        child: Column(
          children: [
            exerciseList,
            bottomGroup,
          ],
        ),
      ),
    );
  }

  Container get exerciseList {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int position) => Card(
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFF565A7D)),
                        child: ListTile(
                          title: (exercises.length == 0)
                              ? Text("")
                              : Text(this.exercises[position].exerciseName,
                                  style: Theme.of(context).textTheme.bodyText2),
                          trailing: IconButton(
                              onPressed: () => {
                                    Exercises()
                                        .delete(this.exercises[position].id),
                                    getData()
                                  },
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xffccceda),
                              )),
                        ),
                      ),
                    ))));
  }

  Container get bottomGroup {
    return Container(
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.only(left: 20),
              child: TextFormField(
                controller: newExerciseName,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xffccceda)),
                  hintText: 'Add new exercise',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TextButton(
                  onPressed: () => {
                        Exercises()
                            .insertOne("exercises", newExerciseName.text),
                        getData()
                      },
                  child: Text("+",
                      style:
                          TextStyle(fontSize: 24, color: Color(0xffccceda)))),
            ),
          ],
        ));
  }
}
