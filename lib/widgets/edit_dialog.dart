import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weighter/constants/styles.dart';
import 'package:provider/provider.dart';
import 'package:weighter/models/exercise.dart';
import 'package:weighter/providers/edit_dialog_settings.dart';

class EditDialog extends HookWidget {
  @required
  final int index;
  @required
  final bool isWorkout;
  @required
  final item;

  const EditDialog({
    this.isWorkout,
    Key key,
    this.index,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editDailogSettings = Provider.of<EditDialogSettings>(context);

    final typeNotifier = item is Exercise ? useState(item.type) : useState('');
    final weightTypeNotifier =
        item is Exercise ? useState(item.weightType) : useState('');

    Widget _editWorkout() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Text("Edit Workout Name", style: kTitleTextStyle),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              initialValue: item.name,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                editDailogSettings.workoutInit(name: item.name);
                return editDailogSettings.setWorkoutName(value);
              },
              decoration: InputDecoration(
                hintText: "New Workout Name",
                filled: true,
                fillColor: kLightGrey,
              ),
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
              onPressed: editDailogSettings.isEditWorkoutEnabled
                  ? () =>
                      editDailogSettings.onCreateWorkoutPressed(index, context)
                  : null,
              disabledColor: kLightGrey,
              minWidth: double.infinity,
              height: 56,
              child: Text(
                "Change",
                style: kButtonTextStyle,
              ),
            ),
          )
        ],
      );
    }

    Widget _editExercise() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Text("Edit Exercise", style: kTitleTextStyle),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              initialValue: item.name,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                editDailogSettings.init(
                  name: item.name,
                  iRepeats: item.typeValue,
                  iSets: item.sets,
                  iWeight: item.weightTypeValue,
                );
                return editDailogSettings.setExerciseName(value);
              },
              decoration: InputDecoration(
                hintText: "New Exercise Name",
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
                  initialValue: item.typeValue.toString(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editDailogSettings.init(
                      name: item.name,
                      iRepeats: item.typeValue,
                      iSets: item.sets,
                      iWeight: item.weightTypeValue,
                    );
                    return editDailogSettings.setRepeats(value);
                  },
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
                  initialValue: item.sets.toString(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editDailogSettings.init(
                      name: item.name,
                      iRepeats: item.typeValue,
                      iSets: item.sets,
                      iWeight: item.weightTypeValue,
                    );
                    return editDailogSettings.setSets(value);
                  },
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
                  initialValue: item.weightTypeValue.toString(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editDailogSettings.init(
                      name: item.name,
                      iRepeats: item.typeValue,
                      iSets: item.sets,
                      iWeight: item.weightTypeValue,
                    );
                    return editDailogSettings.setWeight(value);
                  },
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
              onPressed: editDailogSettings.isEditExerciseEnabled
                  ? () => editDailogSettings.onEditExercisePressed(
                      typeNotifier.value,
                      weightTypeNotifier.value,
                      index,
                      context)
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
      child: isWorkout ? _editWorkout() : _editExercise(),
    );
  }
}
