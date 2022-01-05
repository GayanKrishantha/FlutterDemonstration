// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scheduler _$SchedulerFromJson(Map<String, dynamic> json) => Scheduler(
      json['date'] as String,
      json['title'] as String,
      json['icon'] as int,
      (json['medicines'] as List<dynamic>)
          .map((e) => Medicines.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchedulerToJson(Scheduler instance) => <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'icon': instance.icon,
      'medicines': instance.medicines,
    };
