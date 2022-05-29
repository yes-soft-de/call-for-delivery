import 'dart:io';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:soundpool/soundpool.dart';

@injectable
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final FireNotificationService _notificationService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
    this._notificationService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;
  bool actionMade = false;
  List<String> ringtones = [
    'assets/sounds/ringtone1.wav',
    'assets/sounds/ringtone2.wav',
    'assets/sounds/ringtone3.wav'
  ];
  String? ringtone = NotificationsPrefHelper().getNotification();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).settings,
          onTap: Platform.isIOS
              ? () {
                  if (actionMade) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              : null),
      body: FixedContainer(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    ListTileSwitch(
                      value: Theme.of(context).brightness == Brightness.dark,
                      leading: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.nightlight_round_rounded
                            : Icons.wb_sunny,
                      ),
                      onChanged: (mode) {
                        widget._themeDataService.switchDarkMode(mode);
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                        S.of(context).darkMode,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text(
                        S.of(context).language,
                      ),
                      trailing: DropdownButton(
                          value: Localizations.localeOf(context).languageCode,
                          underline: Container(),
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'العربية',
                                style: TextStyle(),
                              ),
                              value: 'ar',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'English',
                                style: TextStyle(),
                              ),
                              value: 'en',
                            ),
                          ],
                          onChanged: (newLang) {
                            actionMade = true;
                            widget._localizationService
                                .setLanguage(newLang.toString());
                          }),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications_active),
                      title: Text(
                        S.of(context).notificationSound,
                      ),
                      subtitle: Text(S.current.ringtone +
                          ' ' +
                          (ringtones.indexOf(NotificationsPrefHelper()
                                      .getNotification()) +
                                  1)
                              .toString()),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return StatefulBuilder(builder: (ctx, refresh) {
                                return AlertDialog(
                                  title: Text(S.current.notificationSound),
                                  scrollable: true,
                                  content: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                            ),
                                            child: RadioListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text(
                                                  S.of(context).ringtone +
                                                      ' 1 '),
                                              value:
                                                  'assets/sounds/ringtone1.wav',
                                              groupValue: ringtone,
                                              onChanged: (String? value) {
                                                NotificationsPrefHelper()
                                                    .setNotificationPath(
                                                        value ?? '');
                                                playSound(value ?? '');
                                                ringtone = value;
                                                refresh(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                            ),
                                            child: RadioListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text(
                                                  S.of(context).ringtone +
                                                      ' 2 '),
                                              value:
                                                  'assets/sounds/ringtone2.wav',
                                              groupValue: ringtone,
                                              onChanged: (String? value) {
                                                NotificationsPrefHelper()
                                                    .setNotificationPath(
                                                        value ?? '');
                                                playSound(value ?? '');
                                                ringtone = value;
                                                refresh(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                            ),
                                            child: RadioListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text(
                                                  S.of(context).ringtone +
                                                      ' 3 '),
                                              value:
                                                  'assets/sounds/ringtone3.wav',
                                              groupValue: ringtone,
                                              onChanged: (String? value) {
                                                NotificationsPrefHelper()
                                                    .setNotificationPath(
                                                        value ?? '');
                                                playSound(value ?? '');
                                                ringtone = value;
                                                refresh(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: Text(S.current.cancel)),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: Text(S.current.confirm)),
                                  ],
                                );
                              });
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_rounded),
                      title: Text(
                        S.of(context).signOut,
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(
                          Icons.logout_rounded,
                        ),
                      ),
                      onTap: () {
                        widget._authService.logout().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              AuthorizationRoutes.LOGIN_SCREEN,
                              (route) => false);
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.error,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          S.current.dangerZone,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          S.current.DeletingYourAccountHint,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return CustomAlertDialog(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          getIt<AuthService>()
                                              .deleteUser()
                                              .then((value) {
                                            if (value.hasError) {
                                              CustomFlushBarHelper.createError(
                                                  title: S.current.warnning,
                                                  message: value.error ??
                                                      S.current.errorHappened);
                                            } else {
                                              widget._authService
                                                  .logout()
                                                  .then((value) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        AuthorizationRoutes
                                                            .LOGIN_SCREEN,
                                                        (route) => false);
                                              });
                                                CustomFlushBarHelper.createError(
                                                  title: S.current.warnning,
                                                  message: S.current.userDeleted);
                                            }
                                          });
                                        },
                                        content: S.current
                                            .areSureAboutDeletingYourAccount);
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                S.current.deleteAccount,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> playSound(String ringtone) async {
    Soundpool pool = Soundpool.fromOptions();
    var sound = await rootBundle.load(ringtone).then((ByteData soundData) {
      return pool.load(soundData);
    });
    pool.play(sound, repeat: ringtone.contains('2') ? 3 : 0);
  }
}
