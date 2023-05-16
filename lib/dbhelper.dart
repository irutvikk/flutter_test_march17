import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper {

  Future<Database> getdatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    print("{$path}");
    Database database = await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
// When creating the db, create the table
      await db.execute("create table users (ID integer primary key autoincrement, USERNAME text, EMAIL text, PASSWORD text)");
      await db.execute("create table userdata (ID integer primary key autoincrement, leavestartdate text, leaveenddate text, totalleaves integer, startweekday text, endweekday text, userid integer)");
    });
    return database;
  }

  Future<void> insertdata(String usernamee, String emaill, String passwordd, Database db) async {
    String insert = "insert into users (USERNAME, EMAIL, PASSWORD) values ('$usernamee','$emaill','$passwordd')";
    int inserting =await  db.rawInsert(insert);
  }

  Future<List<Map>> selectdata(String emaill, String passwordd, Database db) async {
   String select = "select * from users where EMAIL = '$emaill' and PASSWORD = '$passwordd'";
   List<Map> selecting = await db.rawQuery(select);
   return selecting;

  }

  Future<void> insertuserdata(String leavestartingdate, String leaveendingdate, int totalleaves, String startweekday, String endweekday, int userid, Database db) async {
    String insert = "insert into userdata (leavestartdate,leaveenddate,totalleaves,startweekday,endweekday,userid) values ('$leavestartingdate','$leaveendingdate','$totalleaves','$startweekday','$endweekday','$userid')";
    int insertingdata = await db.rawInsert(insert);
  }

  Future<List<Map>> viewuserdata(int userid, Database db) async {
    String view = "select * from userdata where userid = '$userid'";
    List<Map> viewing = await db.rawQuery(view);

    return viewing;
  }

  Future<List<Map>> viewalluserdata(Database db) async {
    String viewall = "select * from userdata";
    List<Map> viewing = await db.rawQuery(viewall);

    return viewing;
  }


}



