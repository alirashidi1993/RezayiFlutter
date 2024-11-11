class Device {
  final int? id;
   String name;
   int? moveTime;
   String number;
   int? autoCloseTime;
   String password;

  Device({
    this.id,
    required this.name,
    required this.password,
    required this.number,
    this.moveTime,
    this.autoCloseTime,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'moveTime': moveTime,
      'number': number,
      'autoCloseTime': autoCloseTime,
      'password': password
    };
  }

  static Device fromMap(Map<String, dynamic> map) {
    return Device(
        name: map['name'],
        id: map['id'],
        moveTime: map['moveTime'],
        number: map['number'],
        autoCloseTime: map['autoCloseTime'],
        password: map['password']);
  }
}
