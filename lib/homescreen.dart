import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'diaryscreen.dart';

class HomeScreeN extends StatefulWidget {
  const HomeScreeN({super.key});

  @override
  State<HomeScreeN> createState() => _HomeScreeNState();
}

class _HomeScreeNState extends State<HomeScreeN> {
  bool favourite1 = false;
  bool favourite2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 165, 224),
      appBar: AppBar(
        title: const Text(
          "Your Memories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(185, 58, 199, 1),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout, color: Colors.indigo),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search your memories...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("diary")
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                print(snapshot.data?.docs.length);
                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(child: Text("No diary entries yet"));
                }

                return ListView.builder(
                  itemCount: docs.length,

                  itemBuilder: (context, index) {
                    final diary = docs[index];
                    final docId = diary.id;
                    return DiaryCard(
                      title: diary["title"],
                      description: diary["description"],
                      mood: diary["mood"],
                      date: (diary["date"] as Timestamp)
                          .toDate()
                          .toString()
                          .split(" ")[0],
                      isFavourite: diary["isFavourite"],
                      onFavoritePressed: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("diary")
                            .doc(docId)
                            .update({"isFavourite": !diary["isFavourite"]});
                      },
                      
                      
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 180, 52, 194),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddDiaryScreen()),
          );
        },
      ),
    );
  }
}
