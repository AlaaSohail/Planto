class TaskModel {
  final int id;
  final int plantId;

  final String taskType;
  final String title;
  final String? description;

  final int intervalDays;

  final String nextDueDate;
  final String? reminderTime;

  final bool isActive;

  final String plantName;
  final String? plantSpecies;
  final String? plantImage;

  final bool isOverdue;
  final int overdueDays;

  TaskModel({
    required this.id,
    required this.plantId,
    required this.taskType,
    required this.title,
    this.description,
    required this.intervalDays,
    required this.nextDueDate,
    this.reminderTime,
    required this.isActive,
    required this.plantName,
    this.plantSpecies,
    this.plantImage,
    required this.isOverdue,
    required this.overdueDays,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      plantId: int.tryParse(json['plant_id']?.toString() ?? '') ?? 0,

      taskType: json['task_type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),

      intervalDays:
      int.tryParse(json['interval_days']?.toString() ?? '') ?? 0,

      nextDueDate: json['next_due_date']?.toString() ?? '',
      reminderTime: json['reminder_time']?.toString(),

      isActive: json['is_active'] == true,

      plantName: json['plant_name']?.toString() ?? '',
      plantSpecies: json['plant_species']?.toString(),
      plantImage: json['plant_image']?.toString(),

      isOverdue: json['is_overdue'] == true,

      overdueDays:
      int.tryParse(json['overdue_days']?.toString() ?? '') ?? 0,
    );
  }
}