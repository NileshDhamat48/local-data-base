import 'database_helper.dart';

class User {
  int? id;
  String? email;
  String? fullname;
  String? description;
  String? phonenumber;
  String? dateofjoining;
  String? employeecode;

  User({
    this.id,
    this.email,
    this.fullname,
    this.description,
    this.phonenumber,
    this.dateofjoining,
    this.employeecode,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullname = json['fullname'];
    description = json['description'];
    phonenumber = json['phonenumber'];
    dateofjoining = json['dateofjoining'];
    employeecode = json['employeecode'];
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'description': description,
      'dateofjoining': dateofjoining,
      'phonenumber': phonenumber,
      'employeecode': employeecode,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{$COLUMN_ID: $id, $COLUMN_EMAIL: $email, $COLUMN_FULL_NAME: $fullname,$COLUMN_PHONE_NUMBER: $phonenumber,$COLUMN_CODE: $employeecode, $COLUMN_DESCRIPTION: $description, $COLUMN_DATE_OF_JOINING: $dateofjoining}';
  }
}
