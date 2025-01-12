class Student {
  int? id;
  final String name;
  final int age;
  final String department;
  final String email;
  final String imageurl;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.department,
    required this.email,
    required this.imageurl,
  });

  static fromMap(Map<String, dynamic> std) {
    return Student(
      id: std['id'],
      name: std['name'] ?? '',
      age: std['age'] ?? 0,
      department: std['department'] ?? '',
      email: std['email'] ?? '',
      imageurl: std['imageurl'] ?? '',
    );
  }
}
