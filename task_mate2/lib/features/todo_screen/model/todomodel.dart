class Todoclass {
  String? title;
  String? dueDate;
  bool? isCompleted;
  String? priority;
  String? category;
  String?taskid;

  Todoclass(
      {this.title,
      this.dueDate,
      this.isCompleted,
      this.priority,
      this.category,
      this.taskid});

  Todoclass.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dueDate = json['dueDate'];
    isCompleted = json['isCompleted'];
    priority = json['priority'];
    category = json['category'];
    taskid =json['taskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dueDate'] = this.dueDate;
    data['isCompleted'] = this.isCompleted;
    data['priority'] = this.priority;
    data['category'] = this.category;
    return data;
  }
}
