import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighter/models/workout.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/constants/extensions.dart';
import 'package:weighter/providers/edit_dialog_settings.dart';
import 'package:weighter/services/hive_database.dart';
import 'package:weighter/widgets/edit_dialog.dart';
import 'package:weighter/pages/workout_overview.dart';

class WorkoutTile extends StatelessWidget {
  final int index;
  final Workout workout;

  const WorkoutTile({Key key, this.index, this.workout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('taped on : ${workout.name}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WorkoutOverview(workout: workout, workoutIndex: index),
          ),
        );
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
                  workout.name.capitalize(),
                  style: kTileTitleTextStyle,
                ),
                SizedBox(height: 4),
                Text(
                  workout.exercises != 0
                      ? '${workout.exercises} ${workout.exercises > 1 ? 'exercises' : 'exercise'}'
                      : 'None exercies',
                  style: kTileSubTitleTextStyle,
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => EditDialogSettings(),
                        child: EditDialog(
                          index: index,
                          isWorkout: true,
                          item: workout,
                        ),
                      )),
              child: Icon(
                Icons.edit,
                color: kGrey,
              ),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => HiveDatabase().deleteWorkout(index),
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
