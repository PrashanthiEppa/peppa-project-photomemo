import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_memo/firebase_options.dart';
import 'package:photo_memo/model/photo_memo_model.dart';
import 'package:photo_memo/view/detailview_screen.dart';
import 'package:photo_memo/view/error_screen.dart';
import 'package:photo_memo/view/sign_up_screen.dart';
import 'package:photo_memo/view/startdispatcher.dart';
import 'package:photo_memo/view/createphotomemo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PhotoMemoApp());
}

class PhotoMemoApp extends StatelessWidget {
  const PhotoMemoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartDispatcher.routeName,
      routes: {
        StartDispatcher.routeName: (context) => const StartDispatcher(),
        SignUpWidget.routeName: (context) => const SignUpWidget(),
        CreatePhotoMemoScreen.routeName: (context) =>
            const CreatePhotoMemoScreen(),
        //  SharedWithScreen.routeName: (context) => const SharedWithScreen(),
        DetailViewScreen.routeName: (context) {
          Object? args = ModalRoute.of(context)?.settings.arguments;
          if (args == null) {
            return const ErrorScreen('args is null from HomeScreen');
          } else {
            var photoMemo = args as PhotoMemo;
            return DetailViewScreen(photoMemo: photoMemo);
          }
        },
        //  CreateAccountScreen.routeName:(context) => const CreateAccountScreen(),
      },
    );
  }
}
