class AppUrl {
  //static  String liveBaseURL = "https://jsonplaceholder.typicode.com/users";
  static String liveBaseURL =
      "https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json";
  //static  String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static String baseURL = liveBaseURL;
  static String login = baseURL;
  static String register = baseURL;
  static String addnote = baseURL + "/Notes";
  static String forgotPassword = baseURL + "/forgot-password";
}
