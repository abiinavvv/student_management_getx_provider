// class Student {
//   int? id;
//   final String name;
//   final int age;
//   final String department;
//   final String email;
//   final String imageurl;

//   Student({
//     this.id,
//     required this.name,
//     required this.age,
//     required this.department,
//     required this.email,
//     required this.imageurl,
//   });

//   static fromMap(Map<String, dynamic> std) {
//     return Student(
//       id: std['id'],
//       name: std['name'] ?? '',
//       age: std['age'] ?? 0,
//       department: std['department'] ?? '',
//       email: std['email'] ?? '',
//       imageurl: std['imageurl'] ?? '',
//     );
//   }
// }
class Student {
  //FIELDS AS ATTRIBUTES OF CLASS
  int? id;
  final String name;
  final int age;
  final String department;
  final String email;
  final String? imgurl;

  //CONSTRUCTOR FOR INITIALIZATION
  Student(
      {this.id,
      required this.name,
      required this.age,
      required this.department,
      required this.email,
      this.imgurl});

  //TO EXTRACT VALUES FROM MAP(TO FETCH DATA FROM DB)
 static fromMap(Map<String, dynamic> std) {
    return Student(
        id: std['id'],
        name: std['name'],
        age: std['age'],
        department: std['department'],
        email: std['email'],
        imgurl: std['imgurl']);
  }
}