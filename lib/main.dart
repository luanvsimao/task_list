import 'package:flutter/material.dart';
import 'views/app.dart';
import 'package:firebase_core/firebase_core.dart';

// Initialize Firebase
// Your web app's Firebase configuration
const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyBppI6u4UkjZH9VjFKLEiF6JFet92W-gRs",
    authDomain: "task-list-luan.firebaseapp.com",
    projectId: "task-list-luan",
    storageBucket: "task-list-luan.appspot.com",
    messagingSenderId: "384047106600",
    appId: "1:384047106600:web:390ff68d8806025a27c31d",
    measurementId: "G-TTDD6NNHBX");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(App());
}
