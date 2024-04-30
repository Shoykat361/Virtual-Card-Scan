const tableContact = 'tableContact';
const tableContactId = 'id';
const tableContactName = 'Name';
const tableContactMobile = 'Mobile';
const tableContactEmail = 'email';
const tableContactAddress = 'address';
const tableContactWebsite = 'website';
const tableContactFavourite = 'favourite';
const tableContactImage = 'image';
const tableContactCompany = 'company';
const tableContactDesignation = 'designation';
class ContactModel{
  int id ;
  String name;
  String mobile;
  String email;
  String company;
  String designation;
  String webSite;
  String address;
  String image;
  bool favourite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.email='',
    this.company='',
    this.designation='',
    this.webSite='',
    this.address='',
    this.image='images/person.png',
    this.favourite=false,
  });

  Map<String,dynamic>toMap(){
    final map = <String,dynamic>{
      tableContactName: name,
      tableContactMobile: mobile,
      tableContactEmail: email,
      tableContactCompany: company,
      tableContactDesignation: designation,
      tableContactWebsite: webSite,
      tableContactAddress: address,
      tableContactImage: image,
      tableContactFavourite:favourite ? 1:0,
    };
    if(id>0){
      map[tableContactId] = id;
    }
    return map;

  }

  factory ContactModel.fromMap(Map<String,dynamic>map)=>ContactModel(
    id: map[tableContactId],
    name: map[tableContactName],
    email: map[tableContactEmail],
    mobile: map[tableContactMobile],
    address: map[tableContactAddress],
    company: map[tableContactCompany],
    designation: map[tableContactDesignation],
    webSite: map[tableContactWebsite],
    image: map[tableContactImage],
    favourite: map[tableContactFavourite]== 1? true:false,

  );

  @override
  String toString() {
    return 'ContactModel{id: $id, Name: $name, mobile: $mobile, email: $email, company: $company, designation: $designation, webSite: $webSite, address: $address, image: $image, favourite: $favourite}';
  }
}