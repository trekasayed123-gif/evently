import 'package:evently/firebase/firebase-function.dart';
import 'package:evently/model/task_model.dart';
import 'package:flutter/material.dart';import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<TaskModel>>(
        stream: FirebaseFunction.getFavoriteTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

          if (tasks.isEmpty) {
            return const Center(child: Text("No Favorite Events Yet"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              var task = tasks[index];
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage("assets/images/${task.category}.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10, left: 10, right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => FirebaseFunction.updateTask(task..isFavorite = false),
                              icon: const Icon(Icons.favorite, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}