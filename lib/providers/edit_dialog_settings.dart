import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weighter/models/database_repository.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';

class EditDialogSettings extends ChangeNotifier {
  // Workout
  String workoutName;
  bool isWorkoutNameValid = true;
  bool createWorkoutPressed = false;
  bool isEditWorkoutEnabled = false;
  bool workoutFirstInit = false;

  // Exercise
  String exerciseName;
  int repeats;
  int sets;
  int weight;
  bool isExerciseNameValid = false;
  bool isRepeatsValid = false;
  bool isSetsValid = false;
  bool isWeightValid = false;
  bool isEditExerciseEnabled = false;
  bool firstInit = false;

  final DatabaseRepository repository = DatabaseRepository();

  EditDialogSettings();

  // Workout
  workoutInit({@required name}) {
    if (workoutFirstInit) {
      workoutFirstInit = true;
      workoutName = name;
      isEditExerciseEnabled = true;
    }
    notifyListeners();
  }

  setWorkoutName(String newWorkoutName) {
    // workoutName = newWorkoutName;
    // if (createWorkoutPressed) {
    //   isWorkoutNameValid =
    //       workoutName == null ? false : workoutName.trim().isNotEmpty;
    // }
    // notifyListeners();
    if (newWorkoutName == null || newWorkoutName.trim().isEmpty) {
      isWorkoutNameValid = false;
    } else {
      isWorkoutNameValid = true;
    }
    workoutName = newWorkoutName;
    checkWorkoutValidation();
    notifyListeners();
  }

  checkWorkoutValidation() {
    if (isWorkoutNameValid) {
      isEditWorkoutEnabled = true;
    } else {
      isEditWorkoutEnabled = false;
    }
  }

  onCreateWorkoutPressed(int index, BuildContext context) async {
    // createWorkoutPressed = true;
    // if (isWorkoutNameValid) {
    //   final Workout tempWorkout = await repository.getWorkout(index) as Workout;
    //   final workout = Workout(workoutName, tempWorkout.exercises);
    //   repository.updateWorkout(workout, index);
    //   Navigator.pop(context);
    // }
    // notifyListeners();
    final Workout tempWorkout = await repository.getWorkout(index) as Workout;
    final workout = Workout(workoutName, tempWorkout.exercises);
    repository.updateWorkout(workout, index);
    Navigator.pop(context);
  }

  // Exercise
  init({
    @required name,
    @required iSets,
    @required iRepeats,
    @required iWeight,
  }) {
    if (!firstInit) {
      firstInit = true;
      exerciseName = name;
      repeats = iRepeats;
      sets = iSets;
      weight = iWeight;
      isExerciseNameValid = true;
      isRepeatsValid = true;
      isSetsValid = true;
      isWeightValid = true;
      isEditExerciseEnabled = true;
    }
    notifyListeners();
  }

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
      print('here');
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
      isEditExerciseEnabled = true;
    } else {
      isEditExerciseEnabled = false;
    }
  }

  onEditExercisePressed(
      String type, String weightType, int index, BuildContext context) {
    final exercise =
        Exercise(exerciseName, type, repeats, weightType, weight, -1, sets);
    repository.updateExercise(exercise, index);
    Navigator.pop(context);
  }
}
