import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  String title;
  String description;
  DateTime time;

  // Constructor
  Note({
    required this.title,
     this.id,
    required this.description,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
    };
  }

  // Method to create a Note object from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      time: map['time'] != null
          ? (map['time'] as Timestamp).toDate()
          : DateTime.now(),
      id: map['id'],
    );
  }
}
