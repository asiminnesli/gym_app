import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    /// factory means only works 1 time "singelaton"
    return _dbHelper;
  }

  DbHelper.initializeDb();
  Future<Database> get db async {
    return _db;
  }

  get exercises => null;

  String tblExercises = "exercises";
  String colId = "id";
  String colExerciseName = "ExerciseName";

  String tblPrograms = "programs";
  String colProgramId = "programId";
  String colExerciseId = "exerciseId";

  String tblProgramHistory = "programHistory";
  String colRep = "reps";
  String colWeight = "weight";

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path + "/gymApp.db";
    print(path);
    var dbGymApp = await openDatabase(path, version: 1, onCreate: _createDb);

    return dbGymApp;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE $tblExercises ($colId INTEGER PRIMARY KEY, 
                                       $colExerciseName TEXT )''');

    await db.execute('''CREATE TABLE $tblPrograms ($colId INTEGER PRIMARY KEY, 
                                      $colProgramId INTEGER ,
                                      $colExerciseName TEXT)''');

    await db.execute(
        '''CREATE TABLE $tblProgramHistory ($colId INTEGER PRIMARY KEY, 
                                             $colProgramId INTEGER , 
                                             $colExerciseName TEXT,
                                             $colRep INTEGER,
                                             $colWeight DOUBLE
                                             )''');
    print("created tables");
  }
}
