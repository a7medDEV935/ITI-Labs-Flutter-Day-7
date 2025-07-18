import '../data/models/task_model.dart';

class TaskRepo {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: 1,
      title: 'Task 1',
      description: 'Description for Task 1',
      dueDate: DateTime.now(),
      numberOfTasks: 3,
      isCompleted: false,
    ),
    TaskModel(
      id: 2,
      title: 'Task 2',
      description: 'Description for Task 2',
      dueDate: DateTime.now().add(Duration(days: 1)),
      numberOfTasks: 2,
      isCompleted: false,
    ),
    TaskModel(
      id: 3,
      title: 'Task 3',
      description: 'Description for Task 3',
      dueDate: DateTime.now().add(Duration(days: 2)),
      numberOfTasks: 4,
      isCompleted: false,
    ),
    TaskModel(
      id: 4,
      title: 'Task 4',
      description: 'Description for Task 4',
      dueDate: DateTime.now().add(Duration(days: 3)),
      numberOfTasks: 5,
      isCompleted: false,
    ),
  ];

  List<TaskModel> get tasks => _tasks;

  void addTask(TaskModel task) => _tasks.add(task);

  void removeTask(int id) => _tasks.removeWhere((task) => task.id == id);

  void updateTask(int id , String newContent) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = TaskModel(
        id: _tasks[index].id,
        title: newContent,
        description: _tasks[index].description,
        dueDate: _tasks[index].dueDate,
        isCompleted: _tasks[index].isCompleted,
      );
    }
  }
}
