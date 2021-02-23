import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weighter/models/database_repository.dart';
import 'package:weighter/models/exercise.dart';

class WorkoutExerciseSettings extends ChangeNotifier {
  String exerciseName;
  int repeats;
  int sets;
  int weight;
  bool isExerciseNameValid = false;
  bool isRepeatsValid = false;
  bool isSetsValid = false;
  bool isWeightValid = false;
  bool isCreateExerciseEnabled = false;
  bool isEditExerciseEnabled = false;
  bool firstInit = false;

  final DatabaseRepository repository = DatabaseRepository();

  WorkoutExerciseSettings();

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

  onCreateExercisePressed(String type, String weightType, BuildContext context,
      int index, int workoutId) {
    final exercise =
        Exercise(exerciseName, type, repeats, weightType, weight, index, sets);
    repository.createExercise(exercise);
    print("ID : $workoutId");
    repository.newExercisesAddedToWorkout(workoutId);
    Navigator.pop(context);
  }

  setEditExerciseName(String newExerciseName) {
    if (newExerciseName == null || newExerciseName.trim().isEmpty) {
      isExerciseNameValid = false;
    } else {
      isExerciseNameValid = true;
    }
    exerciseName = newExerciseName;
    checkEditValidation();
    notifyListeners();
  }

  setEditRepeats(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) <= 0) {
      repeats = 0;
      isRepeatsValid = false;
    } else {
      repeats = int.parse(value);
      isRepeatsValid = true;
    }
    checkEditValidation();
    notifyListeners();
  }

  setEditSets(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) <= 0) {
      print('here');
      sets = 0;
      isSetsValid = false;
    } else {
      sets = int.parse(value);
      isSetsValid = true;
    }
    checkEditValidation();
    notifyListeners();
  }

  setEditWeight(String value) {
    if (value == null || value.trim().isEmpty || int.parse(value) < 0) {
      weight = -1;
      isWeightValid = false;
    } else {
      weight = int.parse(value);
      isWeightValid = true;
    }
    checkEditValidation();
    notifyListeners();
  }

  checkEditValidation() {
    if (isExerciseNameValid && isRepeatsValid && isSetsValid && isWeightValid) {
      isEditExerciseEnabled = true;
    } else {
      isEditExerciseEnabled = false;
    }
  }

  onEditExercisePressed(String type, String weightType, int index,
      BuildContext context, int workoutId) {
    final exercise = Exercise(
        exerciseName, type, repeats, weightType, weight, workoutId, sets);
    repository.updateExercise(exercise, index);
    Navigator.pop(context);
    print('edit');
  }
}
