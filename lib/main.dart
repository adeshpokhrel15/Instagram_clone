import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/utils/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialization the binding
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyA5eQDfUKUG1hjUoNUqiLFU5iDIjwSGZlA',
            appId: '1:761620703273:web:1b10389eafced9469ed438',
            messagingSenderId: '761620703273',
            projectId: 'instagram-clone-5df25',
            storageBucket: 'instagram-clone-5df25.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  await Firebase.initializeApp(); //initialization the app

  runApp(ProviderScope(child: const HomePage()));
}
