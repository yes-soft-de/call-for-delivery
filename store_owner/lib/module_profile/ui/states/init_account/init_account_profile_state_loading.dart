import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:flutter/material.dart';

class InitAccountStateLoading extends States {
  final String status;
  InitAccountStateLoading(InitAccountScreenState screenState, this.status)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinearProgressIndicator(),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                child: Icon(
                  Icons.upload_rounded,
                  size: 75,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 65,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text('${status}',
                        style: Theme.of(context).textTheme.button),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
