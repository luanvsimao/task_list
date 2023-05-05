import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskList extends StatelessWidget {
  var image = const AssetImage("assets/images/travis.jpg");

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Atualizar a tarefa
  void update(String id, bool value) {
    firestore.collection('tasks').doc(id).update({'finished': value});
  }

  //
  void delete(String id) {
    firestore.collection('tasks').doc(id).delete();
  }

  void handleViewCretaTask(BuildContext context) {
    Navigator.pushNamed(context, '/task-create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context).pushNamed('/user-login');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('tasks')
            .where('uid', isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var tasks = snapshot.data!.docs;
          return ListView(
            children: tasks
                .map((task) => Dismissible(
                      key: Key(task.id),
                      onDismissed: (_) => delete(task.id),
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 12),
                      ),
                      child: CheckboxListTile(
                        title: Text(task['name']),
                        onChanged: (value) => update(task.id, value!),
                        value: task['finished'],
                      ),
                    ))
                .toList(),
          );
        },
      ),
      // ignore: prefer_const_constructors
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/task-create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
