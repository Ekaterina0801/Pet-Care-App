class AppUrl {
  static  String liveBaseURL = "https://jsonplaceholder.typicode.com/users";
  //static  String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static  String baseURL = liveBaseURL;
  static String login = baseURL;
  static  String register = baseURL + "/registration";
  static  String forgotPassword = baseURL + "/forgot-password";
}