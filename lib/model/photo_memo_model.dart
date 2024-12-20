enum PhotoSource {
  camera, 
  gallery,
}

enum DocKeyPhotoMemo {
  title, 
  memo, 
  createdBy, 
  photoFilename, 
  photoURL, 
  timestamp, 
  sharedWith,
}

class PhotoMemo {
  String? docId; //doc id generated by FireStore
  String createdBy; //email of the user
  String title;
  String memo;
  String photoFilename; //image/photo to store Storage
  String photoURL; //URL of the image
  DateTime? timestamp;
  late List<dynamic> sharedWith;

  PhotoMemo({
    this.docId,
    required this.createdBy,
    required this.title,
    required this.memo,
    required this.photoFilename,
    required this.photoURL,
    this.timestamp,
    List<dynamic>? sharedWith,
  }) {
    this.sharedWith = sharedWith == null ? [] : [...sharedWith];
  }

PhotoMemo clone() { 
  PhotoMemo copy = PhotoMemo( 
    docId: docId,
    createdBy: createdBy,
     title: title,
      memo: memo,
       photoFilename: photoFilename,
        photoURL: photoURL,
        timestamp: timestamp,
        );
        copy.sharedWith = [...sharedWith];
        return copy;
}


void copyFrom(PhotoMemo p) {  
  docId = p.docId;
  createdBy = p.createdBy;
  title = p.title;
  memo = p.memo;
  photoFilename = p.photoFilename;
  photoURL = p.photoURL;
  timestamp = p.timestamp;
  sharedWith.clear();
  sharedWith.addAll(p.sharedWith);
}


  Map<String, dynamic> toFirestoreDoc() {
    return {
     DocKeyPhotoMemo.title.name: title,
     DocKeyPhotoMemo.createdBy.name: createdBy,
     DocKeyPhotoMemo.memo.name: memo,
     DocKeyPhotoMemo.photoFilename.name: photoFilename,
     DocKeyPhotoMemo.photoURL.name: photoURL,
     DocKeyPhotoMemo.timestamp.name: timestamp,
     DocKeyPhotoMemo.sharedWith.name: sharedWith,
    };
  }

  // deserialization
  factory PhotoMemo.fromFirestoreDoc({
    required Map<String, dynamic> doc, // document from Firestore
    required String docId,
    }) {
      return PhotoMemo(
        docId: docId,
        createdBy: doc[DocKeyPhotoMemo.createdBy.name] ??= '', 
        title: doc[DocKeyPhotoMemo.title.name] ??= '', 
        memo: doc[DocKeyPhotoMemo.memo.name] ??= '', 
        photoFilename: doc[DocKeyPhotoMemo.photoFilename.name] ??= '',
        photoURL: doc[DocKeyPhotoMemo.photoURL.name] ??= '',
        sharedWith: doc[DocKeyPhotoMemo.sharedWith.name] ??=[],
        timestamp: doc[DocKeyPhotoMemo.timestamp.name] != null
        ? DateTime.fromMillisecondsSinceEpoch(
          doc[DocKeyPhotoMemo.timestamp.name].millisecondsSinceEpoch,
        )
      : null,
      );
  }

  static String? validateTitle(String? value) {
    return (value == null || value.trim().length < 3)
    ? 'Title too short' 
    : null;
  }

  bool isValid() {
    if (createdBy.isEmpty ||
    title.isEmpty ||
    memo.isEmpty ||
    photoFilename.isEmpty ||
    photoURL.isEmpty ||
    timestamp == null) {
      return false;
    } else {
      return true;
    }
  }

  static String? validateMemo(String? value) {
    return (value == null || value.trim().length < 5) ? 'Memo too short' : null;
  }


static String? validateSharedWith(String? value) {
if(value == null || value.trim().isEmpty) return null;

List<String> emailList = 
 value.trim().split(RegExp('(,|;| )+')).map((e)=>e.trim()).toList();

 for (String e in emailList) {
  if (e.contains('@') && e.contains('.')) {
    continue;
  } else {
    return 'Invalid email address: comma, semicolon, space separated list';
  }
 }
 return null;
}
}