import 'package:sqflite/sqflite.dart';

class LocalDatabase{

  static String tableName="SavedPostages";
  static LocalDatabase getInstance=LocalDatabase._init();

  Database? _database;
  LocalDatabase._init();

  Future<Database> getDb() async{
    _database??=await _initDb("saved.db");
    return _database!;
  }

  Future<Database> _initDb(String fileName) async{
    var dbPath=await getDatabasesPath();
    String path=dbPath+fileName;
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String intType="INTEGER";
        String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";

        await db.execute(
            '''
            Create table $tableName(
            id $idType,
            oldIndex $intType
            )
        ''');
      },

    );
    print('Database created');
    return database;
  }

  static void insertToDatabase(int oldIndex) async{
    var database=await getInstance.getDb();
    int id = await database.insert(tableName, {
      "oldIndex":oldIndex
    });
    print("Postage added to Database");
  }

  static Future<void> deleteById(int id) async {
    var database = await getInstance.getDb();

    await database.delete(
        tableName,
        where: 'oldIndex = ?',
        whereArgs: [id]
    );
    print("Postage has been deleted");
  }


  static Future<List> getPostagesFromDb() async{
    var database= await getInstance.getDb();
    var ListOfProducts= await database.query(
        tableName,
        columns:[
          "oldIndex"
        ]);
    List postages = ListOfProducts.map((e) => e["oldIndex"]).toList();
    return postages;
  }








}