import 'dart:async';
import 'package:store_web/module_auth/presistance/auth_prefs_helper.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/authorization_routes.dart';
import 'package:store_web/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:store_web/module_auth/ui/states/login_states/login_state.dart';
import 'package:store_web/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:store_web/module_splash/splash_routes.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';
import 'package:the_country_number/the_country_number.dart';

@injectable
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  const LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginState _currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;
  bool rememberMe = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void refresh() {
    if (mounted) setState(() {});
  }

  late bool canPop;
  @override
  void initState() {
    canPop = Navigator.of(context).canPop();
    loadingSnapshot = const AsyncSnapshot.nothing();
    _currentStates = LoginStateInit(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    super.initState();
  }

  dynamic args;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 233, 195, 113),
            ),
          ),
          Image.asset(
            ImageAsset.AUTH_BACKGROUND,
            fit: BoxFit.fill,
          ),
          Scaffold(
            floatingActionButton: Visibility(
              visible: AuthPrefsHelper().savedUsersCredential().isNotEmpty,
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xff03816A),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 16),
                                      child: Container(
                                        width: 75,
                                        height: 4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            horizontalTitleGap: 0,
                                            leading: Icon(
                                              Icons.info,
                                              color: Theme.of(context)
                                                  .disabledColor,
                                            ),
                                            title: Text(
                                                S.current.credentialsBagHint),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: getCredential(),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                      indent: 16,
                                      endIndent: 16,
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.current.cancel),
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    },
                    child: Icon(
                      FontAwesomeIcons.key,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            appBar: CustomC4dAppBar.appBar(
              context,
              canGoBack: canPop,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: loadingSnapshot.connectionState != ConnectionState.waiting
                ? _currentStates.getUI(context)
                : Stack(
                    children: [
                      _currentStates.getUI(context),
                      Container(
                        width: double.maxFinite,
                        color: Colors.transparent.withOpacity(0.0),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void loginClient(String email, String password) {
    widget._stateManager.loginClient(email, password, this);
  }

  void resendCode(VerifyCodeRequest request) {
    widget._stateManager.resendCode(request, this);
  }

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AuthPrefsHelper().getAccountStatusPhase(), (route) => false,
        arguments: true);
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess)
        .show(context);
  }

  void verifyFirst(String? userID, String? password) {
    if (userID == null || password == null) {
      getIt<AuthService>().logout();
      Navigator.pushNamedAndRemoveUntil(
          context, SplashRoutes.SPLASH_SCREEN, (route) => false);
      return;
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthorizationRoutes.REGISTER_SCREEN,
        (route) => false,
        arguments: {'username': userID, 'password': password},
      );
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.notVerifiedNumber)
          .show(context);
    }
  }

  void verifyClient(VerifyCodeRequest request) {
    widget._stateManager.verifyClient(request, this);
  }

  void restPass(ResetPassRequest request) {
    widget._stateManager.resetCodeRequest(request, this);
  }

  void moveToForgetPage() {
    Navigator.of(context).pushNamed(AuthorizationRoutes.ForgotPass_SCREEN);
  }

  List<Widget> getCredential() {
    List<Widget> widgets = [];
    AuthPrefsHelper().savedUsersCredential().forEach((element) {
      widgets.add(ListTile(
        title: Center(child: Text(element)),
        onTap: () {
          passwordController.text =
              AuthPrefsHelper().getSavedPasswordCredential(element);
          var number = element;
          if (number.isNotEmpty) {
            final sNumber = TheCountryNumber()
                .parseNumber(internationalNumber: '+' + number);
            countryController.text = sNumber.dialCode.substring(1);
            usernameController.text = sNumber.number;
          }
          setState(() {});
          Navigator.of(context).pop();
        },
      ));
      widgets.add(Divider(
        thickness: 2.5,
        color: Theme.of(context).colorScheme.background,
        indent: 16,
        endIndent: 16,
      ));
    });
    return widgets;
  }
}
