import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_memo/model/photo_memo_model.dart';

class HomeScreenModel {
  User user;
  List<PhotoMemo>? photoMemoList;
  String? loadingErrorMessage;
  int? deleteIndex;
  bool deleteInProgress = false;

  HomeScreenModel({required this.user});
}
