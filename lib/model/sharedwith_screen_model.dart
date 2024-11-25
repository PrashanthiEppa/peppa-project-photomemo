import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_memo/model/photo_memo_model.dart';

class SharedWithScreenModel {
  List<PhotoMemo>? sharedWithList;
  final User user;
  String? loadingErrorMessage;

  SharedWithScreenModel({required this.user});
}
