import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';

// TODO maybe add own fileds insted of inharit
class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.advice, required super.id});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(advice: json['advice'], id: json['advice_id']);
  }
}
