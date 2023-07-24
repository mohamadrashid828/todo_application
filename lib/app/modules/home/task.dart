import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class Taskclass {
  int? id;
  String Title;
  String note;
  int is_completed;
  String Date;
  String StartDay; 
  String EndDay;
  String color; 
  int remind;
  String repeat;
  Taskclass({
     this.id,
    required this.Title,
    required this.note,
    required this.is_completed,
    required this.Date,
    required this.StartDay,
    required this.EndDay,
    required this.color,
    required this.remind,
    required this.repeat,
  });

  Map<String, dynamic> tojason() {
    return <String, dynamic>{
      'id': id,
      'Title': Title,
      'note': note,
      'is_completed': is_completed,
      'Date': Date,
      'StartDay': StartDay,
      'EndDay': EndDay,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory Taskclass.ToTask(Map<String, dynamic> map) {
    return Taskclass(
      id: map['id'] as int,
      Title: map['Title'] as String,
      note: map['note'] as String,
      is_completed: map['is_completed'] as int,
      Date: map['Date'] as String,
      StartDay: map['StartDay'] as String,
      EndDay: map['EndDay'] as String,
      color: map['color'] as String,
      remind: map['remind'] as int,
      repeat: map['repeat'] as String,
    );
  }

  String toJson() => json.encode(tojason());

  factory Taskclass.fromJson(String source) => Taskclass.ToTask(json.decode(source) as Map<String, dynamic>);
}
