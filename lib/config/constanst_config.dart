class ConstanstConfig {
  static String localhost = "http://10.0.2.2:3001";
  // static String production = "";
  static String signIn = "$localhost/api/user/sign-up";
  // static String signIn1 = "$production/api/user/sign-up";
  static String login = "$localhost/api/user/sign-in";
  // static String login1 = "$production/api/user/sign-in";
  static String getUser = "$localhost/api/user/get-details";
  // static String getUser1 = "$production/api/user/get-details";

  static String updateUser = "$localhost/api/user/update-user";
  // static String updateUser1 = "$production/api/user/update-user";

  static String createPost = "$localhost/api/post/add-post";
  // static String createPost1 = "$production/api/post/add-post";
  static String review = "$localhost/api/post/review-post";
  // static String review1 = "$production/api/post/review-post";


  static const String apiSocket = "http://10.0.2.2:8800";

  //chat
  static String getChat = "$localhost/api/chat/get-user-chats";
  //message
  static String getMess = "$localhost/api/message/get-message";
  static String createMess = "$localhost/api/message/create-message";

  // static String updateUser1 = "$production/api/user/update-user";

  // static String updateUser = "$localhost/api/user/update-user";

  static String postImage = "$localhost/api/post/upload/";

  static String logout = "$localhost/api/user/log-out";
}
