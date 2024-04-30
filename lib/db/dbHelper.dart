import 'package:path/path.dart'as p;
import 'package:sqflite/sqflite.dart';
import 'package:virtual_card/models/contact_model.dart';
class dbHelper{
  final String _createContact = '''
  create table $tableContact(
  $tableContactId integer  primary key autoincrement,
  $tableContactName text,
  $tableContactMobile text,
  $tableContactEmail text,
  $tableContactAddress text,
  $tableContactDesignation text,
  $tableContactWebsite text,
  $tableContactImage text,
  $tableContactFavourite text)''';
  Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbpath = p.join(root,'contact,db');
    return openDatabase(dbpath,version: 1,onCreate: (db,version){
      db.execute(_createContact);
    });

  }
  Future<int> insertContact(ContactModel contactModel) async{
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }
  Future<List<ContactModel>> getAllConact() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

}