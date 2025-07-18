import 'package:flutter/material.dart';
import 'package:fourth_day/core/extensions/extensions.dart';

import '../../../core/constants/app_colors.dart';
import '../data/models/task_model.dart';
import '../repo/task_repo.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final TextEditingController controller = TextEditingController();
  final TaskRepo taskRepo = TaskRepo();

  List<TaskModel> newTasks = [];

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

  Future<void> _selectTimeRange() async {
    final TimeOfDay? pickedStart = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 0),
    );

    if (pickedStart == null) return;

    final TimeOfDay? pickedEnd = await showTimePicker(
      context: context,
      initialTime: pickedStart.replacing(hour: pickedStart.hour + 1),
    );

    if (pickedEnd == null) return;

    setState(() {
      _startTime = pickedStart;
      _endTime = pickedEnd;
    });
  }

  Future<void> _addTasks() async {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a task name')),
      );
      return;
    }
    if (_startTime == null || _endTime == null) {
      await _selectTimeRange();
      if (_startTime == null || _endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a valid time range')),
        );
        return;
      }
    }
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: controller.text,
      description: 'Description for ${controller.text}',
      dueDate: DateTime.now(),
      startTime: _startTime ?? const TimeOfDay(hour: 10, minute: 0),
      endTime: _endTime ?? const TimeOfDay(hour: 11, minute: 0),
      numberOfTasks: 1,
      isCompleted: false,
    );
    taskRepo.addTask(task);
    newTasks.add(task);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task added successfully')),
    );
    controller.clear();
    setState(() {
      _startTime = null;
      _endTime = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    _startTime = null;
    _endTime = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: controller,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter task name',
                  filled: true,
                  fillColor: AppColors.kBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => _addTasks(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: AppColors.kOnPrimary),
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: newTasks.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Task is Complete
                    setState(() {
                      newTasks[index] = newTasks[index].copyWith(
                        isCompleted: !newTasks[index].isCompleted,
                      );
                      taskRepo.updateTask(newTasks[index].id,
                          newTasks[index].isCompleted.toString());
                    });
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController editController =
                              TextEditingController(
                                  text: newTasks[index].title);
                          return AlertDialog(
                            title: Text('Edit Task'),
                            content: TextField(
                              controller: editController,
                              decoration: InputDecoration(
                                  hintText: 'Enter new task title'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  taskRepo.updateTask(
                                      newTasks[index].id, editController.text);
                                  setState(() {
                                    newTasks[index] = newTasks[index]
                                        .copyWith(title: editController.text);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kOnPrimary.withAlpha(10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListTile(
                      leading: Icon(Icons.task, color: AppColors.kOnPrimary),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newTasks[index].title,
                            style: TextStyle(color: AppColors.kOnPrimary),
                          ),
                          Text(
                            newTasks[index].dueDate.toHumanized(),
                            style: TextStyle(color: AppColors.kOnPrimary),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              Text(
                                newTasks[index].startTime.format(context),
                                style: TextStyle(
                                  color: AppColors.kOnPrimary.withAlpha(150),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                newTasks[index].endTime.format(context),
                                style: TextStyle(
                                  color: AppColors.kOnPrimary.withAlpha(150),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        newTasks[index].isCompleted
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: newTasks[index].isCompleted
                            ? AppColors.kSecondary
                            : AppColors.kOnPrimary.withAlpha(150),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
