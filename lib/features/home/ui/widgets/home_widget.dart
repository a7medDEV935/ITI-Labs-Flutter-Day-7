import 'package:flutter/material.dart';
import 'package:fourth_day/core/extensions/extensions.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/task_model.dart';
import '../../repo/task_repo.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.name});
  final String? name;
  static List<TaskModel> taskModel = TaskRepo().tasks;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Welcome, ${(widget.name == null || widget.name!.trim().isEmpty) ? "Guest" : widget.name!}!",
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
                itemCount: HomeWidget.taskModel.length,
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
                        HomeWidget.taskModel[index].dueDate.toHumanized() ==
                                'Today'
                            ? Image.asset("assets/images/Today_Task.png")
                            : Image.asset("assets/images/Tomorrow.png"),
                        SizedBox(height: 10),
                        ListTile(
                          leading:
                              Icon(Icons.task, color: AppColors.kOnPrimary),
                          title: Text(
                            HomeWidget.taskModel[index].dueDate.toHumanized(),
                            style: TextStyle(color: AppColors.kOnPrimary),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 5,
                                children: [
                                  Text(
                                    HomeWidget.taskModel[index].startTime
                                        .format(context),
                                    style: TextStyle(
                                      color:
                                          AppColors.kOnPrimary.withAlpha(150),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    HomeWidget.taskModel[index].endTime
                                        .format(context),
                                    style: TextStyle(
                                      color:
                                          AppColors.kOnPrimary.withAlpha(150),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                HomeWidget.taskModel[index].numberOfTasks > 0
                                    ? '${HomeWidget.taskModel[index].numberOfTasks} tasks'
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
      ),
    );
  }
}
