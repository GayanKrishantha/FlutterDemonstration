import 'package:json_annotation/json_annotation.dart';
import 'medicines.dart';
part 'schedules.g.dart';

@JsonSerializable()
class Scheduler {
  String date;
  String title;
  int icon;
  List<Medicines> medicines;

  Scheduler(this.date, this.title, this.icon, this.medicines);

  factory Scheduler.fromJson(Map<String, dynamic> json) =>
      _$SchedulerFromJson(json);
  Map<String, dynamic> toJson() => _$SchedulerToJson(this);
}