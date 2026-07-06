import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDiaryScreen extends StatefulWidget {
  final String? mood;
  final String? docId;
  final String? title;
  final String? description;
  const AddDiaryScreen({super.key, this.docId, this.title, this.description, this.mood});

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController moodController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.title ?? "";
    descriptionController.text = widget.description ?? "";
    moodController.text = widget.mood ?? "";
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    moodController.dispose();
    super.dispose();
  }

  Future<void> uploadTaskToDB() async {
    try {
      if (widget.docId == null) {
        // Add new diary
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("diary")
            .add({
              "title": titleController.text.trim(),
              "description": descriptionController.text.trim(),
              "mood": moodController.text.trim(),
              "date": FieldValue.serverTimestamp(),
              "isFavourite": false,
            });
      } else {
        // Update existing diary
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("diary")
            .doc(widget.docId)
            .update({
              "title": titleController.text.trim(),
              "description": descriptionController.text.trim(),
              "mood": moodController.text.trim(),
            });
      }

      print("Saved Successfully");
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 194, 236),
      appBar: AppBar(
        title: const Text("How its Going Dear"),
        backgroundColor: const Color.fromRGBO(185, 58, 199, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),

                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'How are you feeling today?',
                          style: TextStyle(fontSize: 20),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              controller: moodController,

                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22),
                              decoration: InputDecoration(
                                labelText: "Mood",
                                labelStyle: TextStyle(),
                                hintText: "😊only emoji",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'add title to your memory',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Write about your day...",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    print(titleController.text);
                    print(descriptionController.text);
                    print(moodController.text);

                    await uploadTaskToDB();
                    titleController.clear();
                    descriptionController.clear();
                    moodController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Diary saved successfully")),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(185, 58, 199, 1),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),

                  child:  Text(
                    widget.docId == null? "Save Entry" : "Update",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryCard extends StatelessWidget {
  final String title;
  final String description;
  final String mood;
  final String date;
  final bool isFavourite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const DiaryCard({
    super.key,
    required this.title,
    required this.description,
    required this.mood,
    required this.date,
    required this.isFavourite,
    this.onTap,
    this.onFavoritePressed,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(mood, style: const TextStyle(fontSize: 24)),
                  const Spacer(),
                  IconButton(
                    onPressed: onFavoritePressed,
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 6),
                  Text(date),
                  const Spacer(flex: 23),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: onDelete,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: onEdit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
