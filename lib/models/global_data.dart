class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  String username = '';
  
  String getUsername() {
  return GlobalData().username;
}
}
