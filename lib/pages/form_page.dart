import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/models/contact_model.dart';
import 'package:virtual_card/providers/contact_provider.dart';

class FormPage extends StatefulWidget {
  static const String routeName = '/form';
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final addresController = TextEditingController();
  final webSiteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: Icon(Icons.save),
          )],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Contact Name',
                  filled:  true,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value){
                  if(value == null || value.isEmpty ){
                    return 'This Field Can not be Empty';
                  }
                  if(value.length < 5){
                    return 'Enter Full Name';
                  }
                  return null;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number',
                  filled:  true,
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value){
                  if(value == null || value.isEmpty ){
                    return 'This Field Can not be Empty';
                  }
                  if(value.length <11){
                    return 'Mobile number is 11 digit';
                  }
                  return null;
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                  filled:  true,
                  prefixIcon: Icon(Icons.email),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: companyController,
                decoration: InputDecoration(
                  labelText: 'Enter Company Name',
                  filled:  true,
                  prefixIcon: Icon(Icons.shop),
                ),


              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                controller: designationController,
                decoration: InputDecoration(
                  labelText: 'Enter Designation',
                  filled:  true,
                  prefixIcon: Icon(Icons.label),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                keyboardType: TextInputType.url,
                controller: webSiteController,
                decoration: InputDecoration(
                  labelText: 'Enter WebSite',
                  filled:  true,
                  prefixIcon: Icon(Icons.web),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: addresController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  filled:  true,
                  prefixIcon: Icon(Icons.label),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() async{
    if(formKey.currentState!.validate()){
      final contact = ContactModel(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        company: companyController.text,
        designation: designationController.text,
        address: addresController.text,
        website: webSiteController.text,

      );
      Provider.of<ContactProvider>(context,listen: false)
      .insertContact(contact)
      .then((rowId) {
        if(rowId>0){
          Navigator.pop(context);
        }
      });

    }
  }
  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    companyController.dispose();
    webSiteController.dispose();
    addresController.dispose();
    super.dispose();
  }
}




