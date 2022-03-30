class MyUser {
  int userid;
  String firstname;
  String lastname;
  String email;
  String password;
  String district;
  bool readyforoverposure;
  

  MyUser({this.userid,this.email,this.password,this.firstname,this.lastname,this.district,this.readyforoverposure});

  factory MyUser.fromJson(Map<String, dynamic> responseData) {
    return MyUser(
        userid: responseData['UserID'],
        firstname: responseData['FirstName'],
        lastname: responseData['LastName'],
        email: responseData['Email'],
        password: responseData['Password'],
        district: responseData['District'],
        readyforoverposure: responseData['ReadyForOverposure']      
    );
  }

  Map<String, dynamic> toJson() => {
        'UserID': userid,
        'FirstName': firstname,
        'LastName': lastname,
        'Password':password,
        'Email':email,
        'District':district,
        'ReadyForOverposure':readyforoverposure
      };

  Map toMap() => {"UserID":userid, "FirstName":firstname, "LastName":lastname,"Password": password,"Email":email,"District":district};
}