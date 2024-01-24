class Student {
  final int id;
  final String name;
  final String address;
  final String sex;
  final String birth;
  final String whereBorn;
  final String classOfStudent;
  final int course;
  final String educationLevel;
  final String typeOfEducation;
  final String major;

  Student({
    required this.id,
    required this.name,
    required this.address,
    required this.sex,
    required this.birth,
    required this.whereBorn,
    required this.classOfStudent,
    required this.course,
    required this.educationLevel,
    required this.typeOfEducation,
    required this.major,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'sex': sex,
      'birth': birth,
      'whereBorn': whereBorn,
      'class': classOfStudent,
      'course': course,
      'educationLevel': educationLevel,
      'typeOfEducation': typeOfEducation,
      'major': major,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      sex: json['sex'],
      birth: json['birth'],
      whereBorn: json['whereBorn'],
      classOfStudent: json['classOfStudent'],
      course: json['course'],
      educationLevel: json['educationLevel'],
      typeOfEducation: json['typeOfEducation'],
      major: json['major']);

  @override
  String toString() {
    return 'Student{id: $id, name: $name, address: $address, sex: $sex, birth: $birth, whereBorn: $whereBorn, classOfStudent: $classOfStudent, course: $course, educationLevel: $educationLevel, typeOfEducation: $typeOfEducation, major: $major,}';
  }
}
