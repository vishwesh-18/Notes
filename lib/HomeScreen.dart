import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes/Controller/NoteController.dart';
import 'package:notes/Model/NoteModel.dart';
import 'package:notes/Note.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(top: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "Notes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.search, color: Colors.black, size: 30),
                  const SizedBox(width: 10),
                  InkWell(
                    child: const Icon(Icons.more_horiz, size: 30),
                  ),
                ],
              ),
            ),
          ),

          // Notes List
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: noteController.getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No notes available."));
                } else {
                  final notes = snapshot.data!;
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      Note note = notes[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFf6f6f6),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            note.title.isEmpty ? note.description : note.title,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(noteController.formatTime(note.time)),
                          onTap: () {
                            Get.to(NoteScreen(
                              title: note.title,
                              decription: note.description,
                              id: note.id ?? "",
                            ));
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text('${note.title} tapped!'),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          // Bottom Bar
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(NoteScreen());
                  },
                  child: const Icon(Icons.note_alt_outlined,
                      color: Color(0xFF080808)),
                ),
                const Text(
                  "New Note",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
