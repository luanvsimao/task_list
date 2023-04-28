import 'package:flutter/material.dart';
import 'package:task_list/views/task-list.dart';
import 'package:task_list/views/task-create.dart';
import 'package:task_list/views/user-login.dart';
import 'package:task_list/views/user-register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: {
        '/task-list': (context) => TaskList(),
        '/task-create': (context) => TaskCreatePage(),
        '/user-login': (context) => UserLoginPage(),
        '/user-register': (context) => UserRegisterPage(),
      },
      initialRoute: '/user-login',
    );
  }
}
