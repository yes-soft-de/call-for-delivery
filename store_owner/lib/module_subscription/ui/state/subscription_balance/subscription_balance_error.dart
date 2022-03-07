import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SubscriptionErrorLoadedState extends States {
  final SubscriptionBalanceScreenState screenState;
  final String error;
  SubscriptionErrorLoadedState(this.screenState, {required this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.mySubscription,
          colorIcon: Theme.of(context).colorScheme.error),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Subscription status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                              color: Theme.of(context).backgroundColor,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(-0.2, 0)),
                        ],
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.current.subscriptionStatus,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? null
                                  : Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  boxShadow: [],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[100]),
                            ),
                          ),
                          Text(S.current.active),
                          //
                          Spacer(),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          spreadRadius: 0.1,
                                          blurRadius: 7,
                                          offset: Offset(-0.1, 0))
                                    ],
                                    color: Theme.of(context).colorScheme.error),
                                child: Icon(
                                  Icons.check_rounded,
                                  color:
                                      Theme.of(context).textTheme.button?.color,
                                )),
                          ),
                          Text(S.current.inactive),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            // status hint
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.error,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                      title: Text(
                        error,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.error,
                      shape: StadiumBorder()),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        SubscriptionsRoutes.INIT_SUBSCRIPTIONS_SCREEN);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      S.current.subscribe,
                      style: Theme.of(context).textTheme.button,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
