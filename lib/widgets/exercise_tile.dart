import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/constants/extensions.dart';
import 'package:weighter/providers/edit_dialog_settings.dart';
import 'package:weighter/models/database_repository.dart';
import 'package:weighter/providers/workout_exercise_settings.dart';
import 'package:weighter/widgets/workout_exercise_dialog.dart';
import 'package:weighter/widgets/edit_dialog.dart';

class ExerciseTile extends StatelessWidget {
  final int index;
  final Exercise exercise;
  final bool inWorkout;
  final int workoutID;

  const ExerciseTile(
      {Key key, this.index, this.exercise, this.inWorkout, this.workoutID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('taped on : ${exercise.name}');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: kLightGrey,
                  radius: 15,
                ),
                CircleAvatar(
                  backgroundColor: kGrey,
                  radius: 12,
                ),
                Text(
                  (index + 1).toString(),
                  style: kTileIndexTextStyle,
                ),
              ],
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  exercise.name.capitalize(),
                  style: kTileTitleTextStyle,
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      '${exercise.typeValue} ${exercise.type.capitalize()} | ',
                      style: kTileSubTitleTextStyle,
                    ),
                    Text(
                      '${exercise.sets} Sets ',
                      style: kTileSubTitleTextStyle,
                    ),
                    Text(
                      exercise.weightTypeValue == 0
                          ? ''
                          : '| ${exercise.weightTypeValue} ${exercise.weightType.capitalize()}',
                      style: kTileSubTitleTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => inWorkout
                      ? ChangeNotifierProvider(
                          create: (context) => WorkoutExerciseSettings(),
                          child: WorkoutExerciseDialog(
                            isEdit: true,
                            index: index,
                            item: exercise,
                            workoutId: workoutID,
                          ),
                        )
                      : ChangeNotifierProvider(
                          create: (context) => EditDialogSettings(),
                          child: EditDialog(
                            index: index,
                            isWorkout: false,
                            item: exercise,
                          ),
                        )),
              child: Icon(
                Icons.edit,
                color: kGrey,
              ),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                if (inWorkout) {
                  DatabaseRepository().deleteExercise(index);
                  print('Pressed');
                  DatabaseRepository().exerciseDeletedFromWorkout(workoutID);
                }
              },
              child: Icon(
                Icons.delete,
                color: kGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
