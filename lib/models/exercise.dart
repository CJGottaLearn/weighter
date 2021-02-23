import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final int typeValue;
  @HiveField(3)
  final int sets;
  @HiveField(4)
  final String weightType;
  @HiveField(5)
  final int weightTypeValue;
  @HiveField(6)
  final int workoutId;

  Exercise(this.name, this.type, this.typeValue, this.weightType,
      this.weightTypeValue, this.workoutId, this.sets);
}
