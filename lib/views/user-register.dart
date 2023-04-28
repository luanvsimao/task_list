import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegisterPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  void register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        Navigator.of(context).pushNamed('/task-list');
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Não foi possível criar uma conta. Por favor, tente novamente mais tarde."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
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
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  onSaved: (value) => {password = value!},
                  validator: (value) =>
                      value!.isEmpty ? 'Senha invalida' : null),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  register(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
