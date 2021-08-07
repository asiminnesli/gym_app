import 'package:gym_app/utils/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class Exercises {
  late int _id;
  late String _exerciseName;
  late Database _db;
  late int _count;
  late Future _doneFuture;

  Exercises() {
    _doneFuture = _init();
  }

  Future _init() async {
    print("worked");
    _db = await DbHelper().initializeDb();
  }

  Future get initializationDone => _doneFuture;

  String tbl = "exercises";
  String colId = "id";
  String colExerciseName = "ExerciseName";
  String nowExersizetbl = "nowExercise";
  String colRep = "reps";

  Exercises.withId(this._id, this._exerciseName);

  int get id => _id;
  String get exerciseName => _exerciseName;
  int get count => _count;

  set exerciseName(String newExerciseName) {
    _exerciseName = exerciseName;
  }

  Map<String, dynamic> toMap() {
    ////sqlite için gerekiyor
    var map = Map<String, dynamic>();
    map["exerciseName"] = exerciseName;
    map["id"] = id;
    return map;
  }

  Exercises.fromObject(dynamic o) {
    ////exercise class için gerekiyor
    this._id = o["id"];
    this._exerciseName = o["ExerciseName"];
  }

  Future<int> delete(int id) async {
    _db = await DbHelper().initializeDb();

    var result = await _db.delete(tbl, where: "$colId = ?", whereArgs: [id]);
    return result;
  }

  void insertOne(String _tbl, String exerciseName) async {
    _db = await DbHelper().initializeDb();

    await _db.rawQuery('INSERT INTO $_tbl VALUES(NULL,"$exerciseName")');
  }

  Future<List<Exercises>> getList() async {
    List<Exercises> exercises = [];

    _db = await DbHelper().initializeDb();

    var result = await _db.rawQuery("SELECT * FROM $tbl ASC");

    result.forEach((e) {
      exercises.add(Exercises.fromObject(e));
    });

    return exercises;
  }

  Future<int> getCount() async {
    _db = await DbHelper().initializeDb();

    var result =
        Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tbl"));
    return result;
  }

  Future<int> update(Exercises exercises) async {
    _db = await DbHelper().initializeDb();

    var result = await _db.update(tbl, exercises.toMap(),
        where: "$colId = ?", whereArgs: [exercises.id]);
    return result;
  }
}
