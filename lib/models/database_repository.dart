import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';
import 'package:weighter/services/hive_database.dart';

class DatabaseRepository {
  final HiveDatabase hiveDatabase = HiveDatabase();

  openBoxs() async => await hiveDatabase.openBoxs();

  // Workout
  createWorkout(Workout workout) => hiveDatabase.addWorkout(workout);

  deleteWorkout(int index) => hiveDatabase.deleteWorkout(index);

  getWorkout(int index) => hiveDatabase.getWorkout(index);

  updateWorkout(Workout workout, int index) =>
      hiveDatabase.updateWorkout(workout, index);

  newExercisesAddedToWorkout(int index) =>
      hiveDatabase.newExercisesAddedToWorkout(index);

  exerciseDeletedFromWorkout(int index) =>
      hiveDatabase.exerciseDeletedFromWorkout(index);
  // Exercise
  createExercise(Exercise exercise) => hiveDatabase.addExercise(exercise);

  deleteExercise(int index) => hiveDatabase.deleteExercise(index);

  updateExercise(Exercise exercise, int index) =>
      hiveDatabase.updateExercise(exercise, index);
}
