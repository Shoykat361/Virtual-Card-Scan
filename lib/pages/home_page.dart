import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/models/contact_model.dart';
import 'package:virtual_card/pages/contact_details_page.dart';
import 'package:virtual_card/pages/form_page.dart';
import 'package:virtual_card/providers/contact_provider.dart';
import 'package:virtual_card/utils/helpers.dart';
class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isFirst){
      Provider.of<ContactProvider>(context,listen: false)
          .getAllContacts();
    }
    isFirst = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,FormPage.routeName);

        },
        shape: CircleBorder(),
        backgroundColor: Colors.red,
        foregroundColor: Colors.blueAccent,
        child: Icon(Icons.add),

      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.blueAccent,
          onTap: (index) {
            setState(() {
              selectedIndex =index;
            });

          },
          items:   [BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'All',
            backgroundColor: Colors.red,
          ),BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favourite',
          ),
            ],
        ),
      ),
      body:  Consumer<ContactProvider>(
        builder: (context, provider, _) {
          if(provider.contactList.isEmpty){
            return const Center(child: Text("please Add "),);
          }
          return ListView.builder(
            itemCount: provider.contactList.length,
              itemBuilder: (context, index) {
              final contact = provider.contactList[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: FractionalOffset.centerRight,
                  color: Colors.redAccent,
                  child: const Icon(Icons.delete,color: Colors.white,),
                ),
                confirmDismiss: _showConfirmedDismiss,
                onDismissed: (direction) async {
                 await provider.deleteContact(contact.id);
                 showMsg(context, 'Deleted ');
                },
                child: ListTile(
                  onTap: ()=> Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact.id),
                  title: Text(contact.name),
                  trailing: IconButton(onPressed: () {
                    //contact.favorite = !contact.favorite;
                    provider.updateContactField(contact,tblContactColFavorite);

                  },
                  icon:Icon(contact.favorite?Icons.favorite :Icons.favorite_border),),
                ),
              );

              },
          );

        },
      ),
    );
  }

  Future<bool?> _showConfirmedDismiss(DismissDirection direction) {
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Delete The Contact'),
      icon: const Icon(Icons.delete,color: Colors.blueAccent,),
      content: const Text('Are you Sure Delete This'),
      actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Yes'),
          ),
        ],

    ),);
  }
}


