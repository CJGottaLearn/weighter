import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weighter/models/database_repository.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';

class CreateDialogSettings extends ChangeNotifier {
  // Workout values
  String workoutName;
  bool isWorkoutNameValid = true;
  bool createWorkoutPressed = false;

  // Exercise values
  String exerciseName;
  int repeats;
  int sets;
  int weight;
  bool isExerciseNameValid = false;
  bool isRepeatsValid = false;
  bool isSetsValid = false;
  bool isWeightValid = false;
  bool isCreateExerciseEnabled = false;

  final DatabaseRepository repository = DatabaseRepository();

  CreateDialogSettings();

  // Workout functions
  setWorkoutName(String newWorkoutName) {
    workoutName = newWorkoutName;
    if (createWorkoutPressed) {
      isWorkoutNameValid =
          workoutName == null ? false : workoutName.trim().isNotEmpty;
    }
    notifyListeners();
  }

  onCreateWorkoutPressed(BuildContext context) {
    createWorkoutPressed = true;
    if (isWorkoutNameValid) {
      final workout = Workout(workoutName, 0);
      repository.createWorkout(workout);
      Navigator.pop(context);
    }
    notifyListeners();
  }

  // Exerxise functions
  setExerciseName(String newExerciseName) {
    if (newExerciseName == null || newExerciseName.trim().isEmpty) {
      isExerciseNameValid = false;
    } else {
      isExerciseNameValid = true;
    }
    exerciseName = newExerciseName;
    checkValidation();
    notifyListeners();
  }

  setRepeats(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) <= 0) {
      repeats = 0;
      isRepeatsValid = false;
    } else {
      repeats = int.parse(value);
      isRepeatsValid = true;
    }
    checkValidation();
    notifyListeners();
  }

  setSets(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) <= 0) {
      sets = 0;
      isSetsValid = false;
    } else {
      sets = int.parse(value);
      isSetsValid = true;
    }
    checkValidation();
    notifyListeners();
  }

  setWeight(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) < 0) {
      weight = -1;
      isWeightValid = false;
    } else {
      weight = int.parse(value);
      isWeightValid = true;
    }
    checkValidation();
    notifyListeners();
  }

  checkValidation() {
    if (isExerciseNameValid && isRepeatsValid && isSetsValid && isWeightValid) {
      isCreateExerciseEnabled = true;
    } else {
      isCreateExerciseEnabled = false;
    }
  }

  onCreateExercisePressed(
      String type, String weightType, BuildContext context) {
    final exercise =
        Exercise(exerciseName, type, repeats, weightType, weight, -1, sets);
    repository.createExercise(exercise);
    Navigator.pop(context);
  }
}
