import 'package:golocate/back_end/model/ticket.dart';
import 'package:golocate/back_end/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String _db_name = 'golocate_database.db';
  final String _user_table = 'user_list';
  final String _ticket_table = 'ticket_list';
  final int _db_version = 1;

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if(_database != null){
      return _database;
    }
    _database = await  _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _db_name);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_user_table (id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT, point INTEGER, phone TEXT, gender TEXT, birth TEXT, place TEXT, bio TEXT)');
    await db.execute(
        'CREATE TABLE $_ticket_table (id INTEGER PRIMARY KEY, user_id INTEGER, namaHotel TEXT, kota TEXT, price INTEGER, checkIn TEXT, checkOut TEXT, rating TEXT, status TEXT)');
  }

  Future<int?> insertUser(User user) async {
    var dbClient = await _db;
    return await dbClient!.insert(_user_table, user.toMap());
  }

  Future<List?> getUser() async {
    var dbClient = await _db;
    var result = await dbClient!.query(_user_table, columns: [
      'id',
      'username',
      'email',
      'password',
      'point',
      'phone',
      'gender',
      'birth',
      'place',
      'bio'
    ]);

    return result.toList();
  }

  Future<int?> insertTicket(Ticket ticket) async {
   var dbClient = await _db;
   return await dbClient!.insert(_ticket_table, ticket.toMap());
  }

  Future<List?> getTicket() async {
    var dbClient = await _db;
    var result = await dbClient!.query(_ticket_table, columns: [
      'id',
      'user_id',
      'namaHotel',
      'kota',
      'price',
      'checkIn',
      'checkOut',
      'rating',
      'status'
    ]);

    return result.toList();
  }

  Future<int?> updateTicket(Ticket ticket) async {
    var dbClient = await _db;
    return await dbClient!.update(_ticket_table, ticket.toMap(),
    where: 'id = ?', whereArgs: [ticket.id]);
  }

}
