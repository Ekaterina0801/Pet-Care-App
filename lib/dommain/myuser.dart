class MyUser {
  int id;
  String name;
  String password;
  String email;
  List<String> address;
  

  MyUser({this.id, this.name, this.email, this.password, this.address});

  factory MyUser.fromJson(Map<String, dynamic> responseData) {
    return MyUser(
        id: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        password: responseData['username'],
        address: null,
        //address: responseData['address'],
        
    );
  }
  Map toMap() => {"id":id, "name":name, "password": password,"email":email,"address":address};
}