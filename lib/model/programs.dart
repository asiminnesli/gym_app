import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/utils/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class Programs {
  late int _id;
  late int _programId;
  late int _exerciseId;
  late String _exerciseName;
  late int _count;
  late List<Exercises> exercises = [];
  late Database _db;
  late Future _doneFuture;

  Programs() {
    _doneFuture = _init();
  }

  Future _init() async {
    _db = await DbHelper().initializeDb();
  }

  Future get initializationDone => _doneFuture;

  String tbl = "programs";
  String colId = "id";
  String colprogramId = "programId";
  String colExerciseName = "exerciseName";
  String colExercisId = "exerciseId";

  Programs.withId(
      this._id, this._programId, this._exerciseId, this._exerciseName);

  int get id => _id;
  int get programId => _programId;
  int get exerciseId => _exerciseId;
  String get exerciseName => _exerciseName;
  int get count => _count;

  set programId(int newProgramId) {
    _programId = programId;
  }

  set exerciseId(int newExerciseId) {
    _exerciseId = exerciseId;
  }

  set exerciseName(String newExerciseName) {
    _exerciseName = exerciseName;
  }

  Map<String, dynamic> toMap() {
    ////sqlite için gerekiyor
    var map = Map<String, dynamic>();
    map["exerciseName"] = exerciseName;
    map["exerciseId"] = exerciseId;
    map["programId"] = programId;
    map["id"] = id;
    return map;
  }

  Programs.fromObject(dynamic o) {
    this._id = o["id"];
    this._exerciseName = o["exerciseName"];
    this._exerciseId = o["exerciseId"];
    this._programId = o["programId"];
  }

  Future<int> delete(int id) async {
    _db = await DbHelper().initializeDb();

    var result = await _db.delete(tbl, where: "$colId = ?", whereArgs: [id]);
    return result;
  }

  void insertOne(int programId, String exerciseName) async {
    _db = await DbHelper().initializeDb();

    await _db
        .rawQuery('INSERT INTO $tbl VALUES(NULL,"$programId","$exerciseName")');
  }

  Future<List<Programs>> getProgramList() async {
    List<Programs> programs = [];

    _db = await DbHelper().initializeDb();

    var result =
        await _db.rawQuery("SELECT * FROM $tbl GROUP BY $colprogramId");

    result.forEach((e) {
      programs.add(Programs.fromObject(e));
    });

    return programs;
  }

  Future<int> getCount() async {
    _db = await DbHelper().initializeDb();

    var result =
        Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tbl"));
    return result;
  }

  Future<int> update(Programs programs) async {
    _db = await DbHelper().initializeDb();

    var result = await _db.update(tbl, programs.toMap(),
        where: "$colId = ?", whereArgs: [programs.id]);
    return result;
  }

  Future<int> getLastProgramId() async {
    _db = await DbHelper().initializeDb();

    var result = Sqflite.firstIntValue(
        await _db.rawQuery("SELECT MAX($colprogramId) FROM $tbl"));
    if (result == null) {
      result = 0;
    }
    return result;
  }

  Future<List<Exercises>> getProgramExercises(int programId) async {
    _db = await DbHelper().initializeDb();
    List<Exercises> exercisesList = [];
    var result = await _db
        .rawQuery("SELECT * FROM $tbl WHERE $colprogramId = $programId");
    result.forEach((exercise) {
      exercisesList.add(Exercises.fromObject(exercise));
    });
    return exercisesList;
  }
}




// DropdownSearch<String>(
//               mode: Mode.BOTTOM_SHEET,
//               items: itemGet(),
//               label: "Select Exercise",
//               popupItemDisabled: (String s) => s.startsWith('I'),
//               onChanged: (data) {
//                 nowExercise().insertOne("nowExercise", data!, 0);
//                 setState(() {});
//               },
//             ),
            