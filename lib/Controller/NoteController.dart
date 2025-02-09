import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/Model/NoteModel.dart';

class NoteController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxList allNotes = <Note>[].obs;

  Future<void> saveNote() async {
    try {
      var title = titleController.text;
      var description = descriptionController.text;

      print('Save method is called');
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      if (userEmail != null) {
        DocumentReference docRef =
            await firebaseFirestore.collection(userEmail).add({
          'title': title,
          'description': description,
          'time': FieldValue.serverTimestamp(),
        });

        await docRef.update({'id': docRef.id});

        print('Note saved with ID: ${docRef.id}');
      } else {
        print('User email is null, cannot save note');
      }
    } catch (e) {
      print('Error saving note: $e');
    }
  }

  Future<void> updateNote(
      String docId, String updatedTitle, String updatedDescription) async {
    try {
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      if (userEmail != null) {
        DocumentReference docRef =
            firebaseFirestore.collection(userEmail).doc(docId);

        await docRef.update({
          'title': updatedTitle,
          'description': updatedDescription,
          'time': FieldValue.serverTimestamp(),
        });
        print('Note updated successfully');
      } else {
        print('User email is null, cannot update note');
      }
    } catch (e) {
      print('Error updating note: $e');
    }
  }
  Future<void> deleteNote(String docId) async {
    try {
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      if (userEmail != null) {
        DocumentReference docRef = firebaseFirestore.collection(userEmail).doc(docId);

        await docRef.delete();
        print('Note deleted successfully');
      } else {
        print('User email is null, cannot delete note');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }


  Stream<List<Note>> getNotesStream() {
    try {
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      // Listen to the collection of notes from Firestore
      return firebaseFirestore
          .collection(userEmail.toString())
          .orderBy('time', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
      });
    } catch (e) {
      print("Error fetching notes: $e");
      return const Stream.empty();
    }
  }


  String formatTime(DateTime dateTime) {
    DateTime today = DateTime.now();
    DateTime noteDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (noteDate.isAtSameMomentAs(today)) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('MMMM dd').format(dateTime);
    }
  }



  @override
  void onClose() {
    print("screen closed ");
    super.onClose();
  }

  @override
  void dispose() {
    // saveNote();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
  }
}
