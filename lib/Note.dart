import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/Controller/NoteController.dart';

class NoteScreen extends StatefulWidget {
  final String? title;
  final String? decription;
  final String? id;
  NoteScreen({
    super.key,
    this.title,
    this.decription,
    this.id,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteController noteController = Get.put(NoteController());

  String getFormattedDateTime() {
    final now = DateTime.now();
    return DateFormat('MMMM d HH:mm EEE')
        .format(now); // Example: January 12 23:39 Sun
  }

  @override
  void initState() {
    noteController.titleController.text = widget.title ?? '';
    noteController.descriptionController.text = widget.decription ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(noteController.titleController.text);
    print(noteController.descriptionController.text);

    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Row(
              children: [
                Icon(
                  Icons.undo,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.redo,
                  color: Colors.black,
                  size: 30,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: [
                  // Title Input Field
                  TextField(
                    controller: noteController.titleController,
                    cursorColor: Colors.blue, // Set the cursor color
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Remove the border
                      enabledBorder:
                          InputBorder.none, // Remove the enabled border
                      focusedBorder:
                          InputBorder.none, // Remove the focused border
                      hintText: "Input title", // Remove hint text
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24), // Optional: Customize text style
                  ),
                  Text(
                    getFormattedDateTime(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Content Input Field
                  TextField(
                    controller: noteController.descriptionController,
                    maxLines: null, // Allows unlimited lines
                    keyboardType:
                        TextInputType.multiline, // Supports multiline input
                    textInputAction: TextInputAction.newline,
                    cursorColor: Colors.blue, // Set the cursor color
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Remove the border
                      enabledBorder:
                          InputBorder.none, // Remove the enabled border
                      focusedBorder:
                          InputBorder.none, // Remove the focused border
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ), // Optional: Customize text style
                  ),
                  SizedBox(height: 20), // Spacer
                ],
              ),
            ),

            // Icons container at the bottom
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.font_download_outlined,
                    color: Color(0xFF080808),
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF080808),
                  ),
                  const Icon(
                    Icons.image_outlined,
                    color: Color(0xFF080808),
                  ),
                  const Icon(
                    Icons.mic_sharp,
                    color: Color(0xFF080808),
                  ),
                  InkWell(
                    onTap: (){
                      Get.back();
                      noteController.deleteNote(widget.id!);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xFF080808),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.id != null) {
      noteController.updateNote(
        widget.id!,
        noteController.titleController.text,
        noteController.descriptionController.text,
      );
    } else if (noteController.titleController.text.isNotEmpty ||
        noteController.descriptionController.text.isNotEmpty) {
      noteController.saveNote();
    }

    noteController.titleController.clear();
    noteController.descriptionController.clear();
    super.dispose();
  }
}
