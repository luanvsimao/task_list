import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth firestore = FirebaseAuth.instance;

  String email = '';
  String password = '';

  void Login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await firestore.signInWithEmailAndPassword(
            email: email, password: password);
        Fluttertoast.showToast(msg: 'Login realizado com sucesso');
        Navigator.of(context).pushNamed('/task-list');
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(msg: 'Email não encontrado');
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(msg: 'Senha incorreta');
          } else {
            Fluttertoast.showToast(msg: 'Erro de autenticação');
          }
        } else {
          Fluttertoast.showToast(msg: 'Erro ao autenticar');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obrigatorio';
                  } else if (!RegExp(
                          r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                      .hasMatch(value)) {
                    return 'Email invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onSaved: (value) => {password = value!},
                  validator: (value) =>
                      value!.isEmpty ? 'Senha invalida' : null),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => Login(context),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/user-register'),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
