import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/widgets/exercise_tile.dart';

class LoggerPage extends StatelessWidget {
  const LoggerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 34),
      color: kLightGrey,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('exercises').listenable(),
                builder: (context, exercisesBox, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercisesBox.length,
                    itemBuilder: (context, index) {
                      final exercise = exercisesBox.getAt(index) as Exercise;
                      if (exercise.workoutId == -1) {
                        return ExerciseTile(
                          index: index,
                          exercise: exercise,
                          inWorkout: false,
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
