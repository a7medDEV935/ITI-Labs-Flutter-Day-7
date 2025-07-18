import 'package:flutter/material.dart';
import 'package:fourth_day/core/extensions/extensions.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/task_model.dart';
import '../../repo/task_repo.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.name});
  final String? name;
  static List<TaskModel> taskModel = TaskRepo().tasks;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Welcome, $name!",
                style: TextStyle(
                  color: AppColors.kOnPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/home.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kOnPrimary.withAlpha(10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      taskModel[index].dueDate.toHumanized() == 'Today'
                          ? Image.asset("assets/images/Today_Task.png")
                          : Image.asset("assets/images/Tomorrow.png"),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.task, color: AppColors.kOnPrimary),
                        title: Text(
                          taskModel[index].dueDate.toHumanized(),
                          style: TextStyle(color: AppColors.kOnPrimary),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Text(
                                  taskModel[index].startTime.format(context),
                                  style: TextStyle(
                                    color: AppColors.kOnPrimary.withAlpha(150),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  taskModel[index].endTime.format(context),
                                  style: TextStyle(
                                    color: AppColors.kOnPrimary.withAlpha(150),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              taskModel[index].numberOfTasks > 0
                                  ? '${taskModel[index].numberOfTasks} tasks'
                                  : 'No tasks',
                              style: TextStyle(
                                color: AppColors.kOnPrimary.withAlpha(150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
