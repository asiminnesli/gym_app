import 'dart:convert';

import 'package:gym_app/model/exercises.dart';
import 'package:gym_app/utils/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class ProgramHistory {
  late int _id;
  late int _programId;
  late int _exerciseId;
  late String _exerciseName;
  late int _count;
  late int _rep;
  late double _weight;

  late Database _db;
  late Future _doneFuture;

  ProgramHistory() {
    _doneFuture = _init();
  }

  Future _init() async {
    _db = await DbHelper().initializeDb();
  }

  Future get initializationDone => _doneFuture;

  String tbl = "programHistory";
  String colId = "id";
  String colprogramId = "programId";
  String colExerciseName = "exerciseName";
  String colRep = "reps";
  String colWeight = "weight";

  ProgramHistory.withId(this._id, this._programId, this._exerciseId,
      this._exerciseName, this._rep, this._weight);

  int get id => _id;
  int get programId => _programId;
  int get exerciseId => _exerciseId;
  String get exerciseName => _exerciseName;
  int get count => _count;
  int get rep => _rep;
  double get weight => _weight;

  set programId(int newProgramId) {
    _programId = programId;
  }

  set exerciseId(int newExerciseId) {
    _exerciseId = exerciseId;
  }

  set exerciseName(String newExerciseName) {
    _exerciseName = exerciseName;
  }

  set rep(int newRep) {
    _rep = rep;
  }

  set weight(double newWeight) {
    _weight = weight;
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

  ProgramHistory.fromObject(dynamic o) {
    this._id = o["id"];
    this._exerciseName = o["exerciseName"];
    this._exerciseId = o["exerciseId"];
    this._programId = o["programId"];
    this._rep = o["reps"];
    this._weight = o["weight"];
  }

  Future<int> delete(int id) async {
    _db = await DbHelper().initializeDb();

    var result = await _db.delete(tbl, where: "$colId = ?", whereArgs: [id]);
    return result;
  }

  void insertOne(
      int programId, String exerciseName, int rep, double weight) async {
    _db = await DbHelper().initializeDb();

    await _db.rawQuery(
        'INSERT INTO $tbl VALUES(NULL,"$programId","$exerciseName","$rep","$weight")');
  }

  Future<int> getCount() async {
    _db = await DbHelper().initializeDb();
    var result =
        Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM $tbl"));
    return result;
  }

  Future<ProgramHistory> getHistoryData(
      int programId, String exerciseName) async {
    _db = await DbHelper().initializeDb();
    ProgramHistory resultProgramHistory;
    var result = await _db.rawQuery('''
    SELECT * FROM $tbl where $colprogramId = $programId and $colExerciseName = "$exerciseName" Order by id DESC LIMIT 1''');
    if (result.length == 0) {
      result = [
        {
          "id": null,
          "exerciseName": null,
          "exerciseId": null,
          "programId": null
        }
      ];
    }
    return ProgramHistory.fromObject(result[0]);
  }
}
