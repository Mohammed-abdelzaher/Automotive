class User {
  int id;
  String name;
  String email;
  String pass;
  User({this.id, this.name, this.email, this.pass});
  factory User.fromMap(Map<String, dynamic> data) => new User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      pass: data['pass']);
  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "email": email, "pass": pass};
}
