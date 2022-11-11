import 'dart:core';

class Medication {
  int? id;
  String? title;
  String? note;
  int? isComplete;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Medication(
      {this.color,
      this.date,
      this.endTime,
      this.id,
      this.isComplete,
      this.note,
      this.remind,
      this.repeat,
      this.startTime,
      this.title});

  Medication.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isComplete = json['isComplete'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['color'] = color;
    data['date'] = date;
    data['endTime'] = endTime;
    data['isComplete'] = isComplete;
    data['note'] = note;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['startTime'] = startTime;
    return data;
  }
}
