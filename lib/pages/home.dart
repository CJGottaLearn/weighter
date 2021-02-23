import 'package:flutter/material.dart';
import 'package:weighter/constants/custom_icons.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/pages/workouts_page.dart';
import 'package:weighter/pages/logger_page.dart';
import 'package:weighter/widgets/create_dialog.dart';
import 'package:weighter/providers/create_dialog_settings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class Home extends HookWidget {
  final List screens = [
    WorkoutsPage(),
    LoggerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenIndexNotifier = useState(0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Home',
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
      body: screens[screenIndexNotifier.value],
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CreateDialogSettings(),
            child: CreateDialog(
              isWorkout: screenIndexNotifier.value == 0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 54),
              GestureDetector(
                onTap: () => screenIndexNotifier.value = 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      CustomIcons.weight_lifter,
                      color: screenIndexNotifier.value == 0
                          ? kPrimaryColor
                          : kDarkGrey,
                    ),
                    Text(
                      'Workouts',
                      style: screenIndexNotifier.value == 0
                          ? kNavActiveTextStyle
                          : kNavTextStyle,
                    )
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => screenIndexNotifier.value = 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      CustomIcons.clipboard_list,
                      color: screenIndexNotifier.value == 1
                          ? kPrimaryColor
                          : kDarkGrey,
                    ),
                    Text(
                      'Logger',
                      style: screenIndexNotifier.value == 1
                          ? kNavActiveTextStyle
                          : kNavTextStyle,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 54),
            ],
          ),
        ),
      ),
    );
  }
}
