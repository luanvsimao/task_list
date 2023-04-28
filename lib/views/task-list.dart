import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskList extends StatelessWidget {
  var image = const AssetImage("assets/images/travis.jpg");

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        title: const Text('Tarefas Pendentes'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              // .where('status', isEqualTo: false)
              .orderBy('name')
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
                        onDismissed: (direction) => delete(task.id),
                        background: Container(
                          color: Colors.red,
                          child: const ListTile(
                            leading: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: CheckboxListTile(
                          title: Text(task['name']),
                          onChanged: (value) => update(task.id, value!),
                          value: task['finished'],
                        ),
                      ))
                  .toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleViewCretaTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}