import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weighter/constants/styles.dart';
import 'package:provider/provider.dart';
import 'package:weighter/providers/create_dialog_settings.dart';

class CreateDialog extends HookWidget {
  @required
  final bool isWorkout;

  const CreateDialog({this.isWorkout, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createDailogSettings = Provider.of<CreateDialogSettings>(context);

    final typeNotifier = useState('repeats');
    final weightTypeNotifier = useState('kg');

    Widget _createWorkout() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Text("Create Workout", style: kTitleTextStyle),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              onChanged: (value) => createDailogSettings.setWorkoutName(value),
              decoration: InputDecoration(
                  hintText: "Workout Name",
                  filled: true,
                  fillColor: kLightGrey,
                  errorText: !createDailogSettings.isWorkoutNameValid
                      ? "Fill the field"
                      : null),
            ),
          ),
          SizedBox(height: 48),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: MaterialButton(
              onPressed: () =>
                  createDailogSettings.onCreateWorkoutPressed(context),
              minWidth: double.infinity,
              height: 56,
              child: Text(
                "Create",
                style: kButtonTextStyle,
              ),
            ),
          )
        ],
      );
    }

    Widget _createExercise() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Text("Create Exercise", style: kTitleTextStyle),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              onChanged: (value) => createDailogSettings.setExerciseName(value),
              decoration: InputDecoration(
                hintText: "Exercise Name",
                filled: true,
                fillColor: kLightGrey,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: typeNotifier.value == 'repeats'
                        ? kPrimaryColor
                        : kLightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                height: 24,
                child: RawMaterialButton(
                  onPressed: () => typeNotifier.value = 'repeats',
                  child: Text(
                    "Repeats",
                    style: typeNotifier.value == 'repeats'
                        ? kSubButtonActiveTextStyle
                        : kSubButtonTextStyle,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: typeNotifier.value == 'repeats'
                        ? kLightGrey
                        : kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                height: 24,
                child: RawMaterialButton(
                  onPressed: () => typeNotifier.value = 'seconds',
                  child: Text(
                    "Seconds",
                    style: typeNotifier.value == 'repeats'
                        ? kSubButtonTextStyle
                        : kSubButtonActiveTextStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 72,
                width: 56,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => createDailogSettings.setRepeats(value),
                  maxLength: 3,
                  decoration: InputDecoration(
                    counter: Text(""),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  Text(typeNotifier.value == 'repeats' ? "Repeats" : "Seconds",
                      style: kHintTextStyle),
                  SizedBox(height: 18)
                ],
              ),
              SizedBox(width: 16),
              Container(
                height: 72,
                width: 56,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => createDailogSettings.setSets(value),
                  maxLength: 2,
                  decoration: InputDecoration(
                    counter: Text(""),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  Text("Sets", style: kHintTextStyle),
                  SizedBox(height: 18)
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: weightTypeNotifier.value == 'kg'
                        ? kPrimaryColor
                        : kLightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                height: 24,
                child: RawMaterialButton(
                  onPressed: () => weightTypeNotifier.value = 'kg',
                  child: Text(
                    "KG",
                    style: weightTypeNotifier.value == 'kg'
                        ? kSubButtonActiveTextStyle
                        : kSubButtonTextStyle,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: weightTypeNotifier.value == 'kg'
                        ? kLightGrey
                        : kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                height: 24,
                child: RawMaterialButton(
                  onPressed: () => weightTypeNotifier.value = 'lbs',
                  child: Text(
                    "LBS",
                    style: weightTypeNotifier.value == 'kg'
                        ? kSubButtonTextStyle
                        : kSubButtonActiveTextStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 72,
                width: 56,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => createDailogSettings.setWeight(value),
                  maxLength: 3,
                  decoration: InputDecoration(
                    counter: Text(""),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  Text(weightTypeNotifier.value == 'kg' ? "KG" : "LBS",
                      style: kHintTextStyle),
                  SizedBox(height: 18)
                ],
              ),
            ],
          ),
          SizedBox(height: 48),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: MaterialButton(
              onPressed: createDailogSettings.isCreateExerciseEnabled
                  ? () => createDailogSettings.onCreateExercisePressed(
                      typeNotifier.value, weightTypeNotifier.value, context)
                  : null,
              disabledColor: kLightGrey,
              minWidth: double.infinity,
              height: 56,
              child: Text(
                "Create",
                style: kButtonTextStyle,
              ),
            ),
          )
        ],
      );
    }

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: isWorkout ? _createWorkout() : _createExercise());
  }
}
