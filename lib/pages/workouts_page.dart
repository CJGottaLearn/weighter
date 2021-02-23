import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/models/workout.dart';
import 'package:weighter/widgets/workout_tile.dart';

class WorkoutsPage extends StatelessWidget {
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('workouts').listenable(),
                builder: (context, workoutsBox, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: workoutsBox.length,
                    itemBuilder: (context, index) {
                      final workout = workoutsBox.getAt(index) as Workout;
                      print(workout.name);
                      // return Container();
                      return WorkoutTile(index: index, workout: workout);
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
