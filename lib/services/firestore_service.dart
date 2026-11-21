import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  // Menambah tugas / Todo ke FIrestore
  Future<void> addTodo(String taskName) async{
    final newTodo = Todo(
      id: '',
      task: taskName,
      isDone: false,
    );
    await _todosCollection.add(newTodo.toMap());
  }

  // Mengubah atau mengambil tugas / Todo dari Firestore
  Stream<List<Todo>> getTodos(){
    return _todosCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList());
  }

  //Update status Todo
  Future<void> UpdateTodoStatus(String id, bool currentStatus) async{
    await _todosCollection.doc(id).update({'isDone': !currentStatus});
  }

  //Delete Tugas atau Todo
  Future<void> deleteTodo(String id) async{
    await _todosCollection.doc(id).delete();
  }
}