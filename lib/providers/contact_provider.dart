import 'package:flutter/foundation.dart';
import 'package:virtual_card/db/dbHelper.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];
  final db = DbHelper();
  Future<int> insertContact(ContactModel contactModel) async{
    final rowId = await db.insertContact(contactModel);
    contactModel.id = rowId;
    contactList.add(contactModel);
    notifyListeners();
    return rowId;
  }
  Future<void> getAllContacts() async{
    contactList = await db.getAllContacts();
    notifyListeners();
  }

}

