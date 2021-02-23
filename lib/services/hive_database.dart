import 'package:hive/hive.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';

class HiveDatabase {
  var workoutsBox;
  var exercisesBox;

  HiveDatabase();

  // Workouts
  addWorkout(Workout workout) async {
    workoutsBox = await Hive.openBox('workouts');
    workoutsBox.add(workout);
  }

  getWorkout(int index) async {
    workoutsBox = await Hive.openBox('workouts');
    return workoutsBox.getAt(index) as Workout;
  }

  updateWorkout(Workout workout, int index) async {
    workoutsBox = await Hive.openBox('workouts');
    print(workout.name);
    workoutsBox.putAt(index, workout);
  }

  deleteWorkout(int index) async {
    workoutsBox = await Hive.openBox('workouts');
    workoutsBox.deleteAt(index);
  }

  newExercisesAddedToWorkout(int index) async {
    workoutsBox = await Hive.openBox('workouts');
    var workout = workoutsBox.getAt(index) as Workout;
    workoutsBox.putAt(
        index, workout.copyWith(exercises: workout.exercises + 1));
  }

  exerciseDeletedFromWorkout(int index) async {
    workoutsBox = await Hive.openBox('workouts');
    var workout = workoutsBox.getAt(index) as Workout;
    workoutsBox.putAt(
        index, workout.copyWith(exercises: workout.exercises - 1));
  }

  // Exercises
  addExercise(Exercise exercise) async {
    exercisesBox = await Hive.openBox('exercises');
    exercisesBox.add(exercise);
  }

  deleteExercise(int index) async {
    exercisesBox = await Hive.openBox('exercises');
    exercisesBox.deleteAt(index);
    print('exercise deleted');
  }

  updateExercise(Exercise exercise, int index) async {
    exercisesBox = await Hive.openBox('exercises');
    exercisesBox.putAt(index, exercise);
  }

  openBoxs() async {
    await Hive.openBox('workouts');
    await Hive.openBox('exercises');
  }

  closeHive() {
    workoutsBox.compact();
    exercisesBox.compact();
    workoutsBox.close();
    exercisesBox.close();
  }
}
