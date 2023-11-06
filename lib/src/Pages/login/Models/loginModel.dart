class LoginM {
  String prueba = "hola";
  int? id;
  String? document;
  String? firstName;
  String? secondName;
  String? surnames;
  String? email;
  String? phone;
  Null? fechaNacimiento;
  String? age;
  String? address;
  String? gender;
  String? typeDocument;
  int? status;
  String? createdDate;

  static final LoginM _instance = LoginM._internal();
  factory LoginM() {
    return _instance;
  }

  LoginM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    document = json['document'];
    firstName = json['first_name'];
    secondName = json['second_name'];
    surnames = json['surnames'];
    email = json['email'];
    phone = json['phone'];
    fechaNacimiento = json['fecha_nacimiento'];
    age = json['age'];
    address = json['address'];
    gender = json['gender'];
    typeDocument = json['type_document'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['document'] = this.document;
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['surnames'] = this.surnames;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['fecha_nacimiento'] = this.fechaNacimiento;
    data['age'] = this.age;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['type_document'] = this.typeDocument;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    return data;
  }

  LoginM._internal(); // Constructor privado para garantizar la unicidad del Singleton
}
