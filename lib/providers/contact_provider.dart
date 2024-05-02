import 'package:flutter/foundation.dart';
import 'package:virtual_card/db/dbHelper.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];
  final db = dbHelper();
  Future<int> insertContact(ContactModel contactModel) async{
    final rowId = await db.insertContact(contactModel);
    contactModel.id = rowId;
    contactList.add(contactModel);
    notifyListeners();
    return rowId;
  }
  Future<void> getAllContacts() async{
    contactList = await db.getAllConact();
    notifyListeners();
  }
  /*Future<int> deleteCOntact(int id) async {
    notifyListeners();
    return db.deleteContact(id);
  }*/

  Future<int> deleteContact(int id) async {
    // Perform the delete operation
    int deletedRows = await db.deleteContact(id);
    // Notify listeners only if the delete operation was successful
    if (deletedRows > 0) {
      notifyListeners();
    }
    return deletedRows;
  }
  Future<void> updateContactField(ContactModel contactModel,String field) async {
    await db.updateContactField(contactModel.id, {field : contactModel.favorite ? 0 : 1});
    final index = contactList.indexOf(contactModel);
    contactList[index].favorite = !contactList[index].favorite;
    notifyListeners();
  }
  Future<ContactModel> getContactById(int id) => db.getContactById(id);

}

