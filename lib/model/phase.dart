import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phase.g.dart';

@JsonSerializable()
class Phase extends Equatable {
  final String id;
  final String name;
  final int number;

  final bool selectable;

  Phase({this.id, this.name, this.number, this.selectable});

  factory Phase.fromJson(Map<String, dynamic> json) => _$PhaseFromJson(json);

  Map<String, dynamic> toJson() => _$PhaseToJson(this);

  @override
  List<Object> get props => [id];
}
