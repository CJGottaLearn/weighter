import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int exercises;

  Workout(
    this.name,
    this.exercises,
  );

  Workout copyWith({
    String name,
    int exercises,
  }) {
    return Workout(
      name ?? this.name,
      exercises ?? this.exercises,
    );
  }
}
