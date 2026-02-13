import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../firebase/firebase-function.dart';
import '../provider/home_page_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider()..getTasks(),
      builder: (context, child) {
        var provider = Provider.of<HomePageProvider>(context);
        var providerWatch = context.watch<HomePageProvider>();

        return Column(
          children: [

            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: provider.categories.length,
                separatorBuilder: (c, i) => const SizedBox(width: 12),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    provider.changeCategory(index);
                  },
                  child: Chip(
                    backgroundColor: index == provider.selectedCategoryIndex
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    label: Text(provider.categories[index]),
                    labelStyle: GoogleFonts.poppins(
                      color: index == provider.selectedCategoryIndex
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                      fontSize: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (providerWatch.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (providerWatch.errorMessage.isNotEmpty) {
                    return Center(child: Text(provider.errorMessage));
                  }
                  if (providerWatch.filteredTasks.isEmpty) {
                    return const Center(child: Text("No Tasks Yet"));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                    itemCount: providerWatch.filteredTasks.length,
                    itemBuilder: (context, index) {
                      var task = providerWatch.filteredTasks[index];
                      var date = DateTime.fromMillisecondsSinceEpoch(task.date);

                      return SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                "assets/images/${providerWatch.filteredTasks[index].category}.png",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF4F7FF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      dateFormat.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          providerWatch
                                              .filteredTasks[index]
                                              .date,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: const Color(0XFFF4F7FF),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            providerWatch
                                                .filteredTasks[index]
                                                .title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var task = providerWatch
                                                .filteredTasks[index];
                                            task.isFavorite = !task.isFavorite;
                                            FirebaseFunction.updateTask(task);
                                          },

                                          child: Icon(
                                            providerWatch
                                                    .filteredTasks[index]
                                                    .isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
