import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_memo/model/photo_memo_model.dart';

class DetailViewScreenModel {
  final User user;
  final PhotoMemo photoMemo;
  bool editMode = false;
  late PhotoMemo tempMemo;
  String? progressMessage;
  dynamic photo; // mobile (File) web (Uint8List)
  String? photoMimeType;

  DetailViewScreenModel({required this.user, required this.photoMemo}) {
    tempMemo = photoMemo.clone(); // must be a copy
  }

  void saveTitle(String? value) {
    if (value != null) {
      tempMemo.title = value.trim();
    }
  }

  void saveMemo(String? value) {
    if (value != null) {
      tempMemo.memo = value.trim();
    }
  }

  void saveSharedWith(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      List<String> emailList =
          value.trim().split(RegExp('(, |;| )+')).map((e) => e.trim()).toList();
      tempMemo.sharedWith = emailList;
    }
  }
}
