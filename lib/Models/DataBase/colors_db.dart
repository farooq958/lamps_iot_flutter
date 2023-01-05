import 'package:flutter/cupertino.dart';
import 'package:keptua/Models/DataBase/color_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///Steps
///01: add package
///02: open and close our DB (01-08)
///03: create our DB Table (work inside _createDB() method)
///04: create model
///05: create() method
///06: read() method
///07: update() method
///08: delete() method

///01:
class ColorsDatabase {
  ///02:
  //this class private constructor
  ColorsDatabase._init();

  ///03:
  //global instance to call this class constructor
  static final ColorsDatabase colorDatabaseInstance = ColorsDatabase._init();

  ///04:
  //this field is for our database
  static Database? _database;

  ///05:
  //before CRUD operation we will use this for connection
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(
        'colors.db'); //file 'colors.db' is where our db will be stored

    return _database!;
  }

  ///06:
  //here we are initializing our database
  Future<Database> _initDB(String filePath) async {
    //01.here we are storing our db in our file storage system
    final dbPath = await getDatabasesPath();
    //On Android, it is typically data/data/ /databases
    // On iOS and MacOS, it is the Documents directory.
    //if you want to add other path you can use path_provider package
    //and replace 'getDatabasePath()' method with desired path

    //02.from our 'dbPath' and 'filePath' (which we define above) we here
    //create a new path object
    final path = join(dbPath, filePath);

    //03.now we are opening our db and putting our path inside here
    //secondly we are supplying a version here (default 1)
    //third we are defining our db schema (data skeleton) here
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///07:
  //here we made this method to close our app
  Future close() async {
    //01. we are accessing our db here
    final db = await colorDatabaseInstance.database;
    //02. then we simply call this close() method
    db.close();
  }

  ///08:
  ///here we are defining our db schema
  ///note: this method will only executed one time when we initially want to set a local db
  Future _createDB(Database db, int version) async {
    //Note: here first create a model 'here: ColorModel' then continue here further

    //01. first call this method 'await db.execute()' method
    //02. then inside we put our 'CREATE TABLE' statement
    //03. then we access our 'tableColors' field that we have defined in model class
    // this basically means we want to create table "tableColors"
    //04. then we put structure/scheme of our table (after :await db.execute('''CREATE TABLE $tableColors''');)
    //05. then here '(after :await db.execute('''CREATE TABLE $tableColors (here...)''');)' inside we need
    //to define all of our columns

    //Note:  ${ColorsFields.id}, ===> column name & 'final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';' will be its type
    //Combine we write these as   '${ColorsFields.id} $idType,' (same for all other fields)

    const idType =
        'INTEGER PRIMARY KEY AUTOINCREMENT'; //final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT'; (try for all)
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    await db.execute('''
    CREATE TABLE $tableColors (
     ${ColorsFields.id} $idType,
     ${ColorsFields.red} $integerType,
     ${ColorsFields.green} $integerType,
     ${ColorsFields.blue} $integerType,
     ${ColorsFields.opacity} $integerType,
     ${ColorsFields.shadow} $integerType,
     ${ColorsFields.colorValue} $integerType
    )
    ''');
  }

  ///09:
  //CRUD operations methods
  //create new color
  Future<ColorModel?> create(ColorModel color) async {
    try {
      //01. get db reference
      final db = await colorDatabaseInstance.database;

      //02.call insert method
      final id = await db.insert(tableColors, color.toJson());

      //03. here 'id' is a unique  id which we want to pass to our 'color' object
      return color.copy(id: id);
    } catch (error) {
      debugPrint('error at adding color method $error');
      return null;
    }
  }

  ///10:
  //read single color
  Future<ColorModel> read(int id) async {
    //01. get db reference
    final db = await colorDatabaseInstance.database;

    final maps = await db.query(
      tableColors,
      columns: ColorsFields.values,
      where: '${ColorsFields.id} = ?',
      whereArgs: [id],
    );

    //now convert our 'maps' to Color object
    if (maps.isNotEmpty) {
      return ColorModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  ///11:
  // read all colors
  Future<List<ColorModel>> readAllColors() async {
    //01. get db reference
    final db = await colorDatabaseInstance.database;
    const orderBy =
        '${ColorsFields.id} ASC'; // final orderBy = '${ColorsFields.id} ASC'; (try)
    final result = await db.query(tableColors, orderBy: orderBy);
    return result.map((json) => ColorModel.fromJson(json)).toList();
  }

  ///12:
  //update all colors
  Future<int> update(ColorModel colorModel) async {
    //01. get db reference
    final db = await colorDatabaseInstance.database;

    return db.update(
      tableColors,
      colorModel.toJson(),
      where: '${ColorsFields.id} = ?',
      whereArgs: [colorModel.id],
    );
  }

  ///13:
  //delete color
  Future<int?> delete(int id) async {
    // try {
    //
    // } catch (error) {
    //   debugPrint('error at adding color method $error');
    //   return null;
    // }
    //01. get db reference
    final db = await colorDatabaseInstance.database;

    return await db.delete(
      tableColors,
      where: '${ColorsFields.id} = ?',
      whereArgs: [id],
    );
  }
}
