import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './search_page.dart';
import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';
import '../widget/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting_restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySettingScreen(),
    );
  }
}

class BodySettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchPage.routeName,
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Setting",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Restaurant app settings",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Material(
                      child: ListTile(
                        title: Text('Restaurant Notification'),
                        subtitle: Text("Enable notification"),
                        trailing: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: provider.isDailyNotificationActive,
                            onChanged: (value) async {
                              if (Platform.isIOS) {
                                customDialog(context);
                              } else {
                                scheduled.scheduledNotification(value);
                                provider.enableDailyNotification(value);
                              }
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
