import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/constants/extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weighter/providers/workout_exercise_settings.dart';
import 'package:weighter/widgets/exercise_tile.dart';
import 'package:weighter/widgets/workout_exercise_dialog.dart';

class WorkoutOverview extends StatelessWidget {
  final Workout workout;
  final int workoutIndex;

  const WorkoutOverview({Key key, this.workout, this.workoutIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: kAccentColor,
            ),
          ),
          title: Text(
            workout.name.capitalize(),
            style: kTitleTextStyle,
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info,
                color: kAccentColor,
              ),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24, 24, 24, 34),
          color: kLightGrey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box('exercises').listenable(),
                    builder: (context, exercisesBox, _) {
                      // exercisesBox = exercisesBox.values
                      //     .where((item) => item.workoutId == index);
                      return exercisesBox.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: exercisesBox.length,
                              itemBuilder: (context, index) {
                                var listCounter = -1;
                                final exercise =
                                    exercisesBox.getAt(index) as Exercise;
                                if (exercise.workoutId == workoutIndex) {
                                  listCounter++;
                                  return ExerciseTile(
                                    index: listCounter,
                                    exercise: exercise,
                                    inWorkout: true,
                                    workoutID: workoutIndex,
                                  );
                                }
                                return Container();
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.refresh,
                                    size: 50,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'No Data',
                                    style: kTileTitleTextStyle,
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            );
                    },
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => ChangeNotifierProvider(
                              create: (context) => WorkoutExerciseSettings(),
                              child: WorkoutExerciseDialog(
                                isEdit: false,
                                index: workoutIndex,
                                workoutId: workoutIndex,
                              ),
                            )),
                    disabledColor: kLightGrey,
                    minWidth: double.infinity,
                    height: 56,
                    child: Text(
                      "Add Exercise",
                      style: kButtonTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
