import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenModel {
  User user;
  List<PhotoMemo>? photoMemoList;
  String? loadingErrorMessage;
  int? deleteIndex;
  bool deleteInProgress = false;

  HomeScreenModel({required this.user});
}