import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_todo/features/home/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<void> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  });

  Future<void> editTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    required String uid,
  });

  Future<void> deleteTodo({required String uid});

  Future<List<TodoModel>> fetchTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  // will inject through DI
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  TodoRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<void> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  }) async {
    try {
      DateTime dateTime = DateFormat("MMM dd, yyyy").parse(dueDate);
      final docRef = await firebaseFirestore.collection('todo').add({
        'title': title,
        'description': description,
        'category': category,
        'priority': priority,
        'dueDate': Timestamp.fromDate(dateTime),
        'uid': firebaseAuth.currentUser?.uid,
      });
      debugPrint('Doc created with id : ${docRef.id}');
    } catch (e) {
      debugPrint("error : ${e.toString()}");
    }
  }

  @override
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final snapshot = await firebaseFirestore.collection('todo').get();

      final todoList = snapshot.docs
          .map((doc) => TodoModel.fromMap(doc.data(), doc.id))
          .toList();

      return todoList;
    } catch (e) {
      debugPrint("error : ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> editTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    required String uid,
  }) async {
    try {
      DateTime dateTime = DateFormat("MMM dd, yyyy").parse(dueDate);
      await firebaseFirestore.collection('todo').doc(uid).update({
        'title': title,
        'description': description,
        'category': category,
        'priority': priority,
        'dueDate': Timestamp.fromDate(dateTime),
      });
    } catch (e) {
      debugPrint("error : ${e.toString()}");
    }
  }

  @override
  Future<void> deleteTodo({required String uid}) async {
    try {
      await firebaseFirestore.collection('todo').doc(uid).delete();
    } catch (e) {
      debugPrint("error : ${e.toString()}");
    }
  }
}
