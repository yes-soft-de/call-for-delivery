import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_main/model/statistics_model.dart';
import 'package:c4d/module_main/sceen/new_home_screen.dart';
import 'package:c4d/module_main/widget/animation.dart';
import 'package:c4d/module_main/widget/fade_animation.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/global/screen_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

class NewHomeLoadedState extends States {
  final NewHomeScreenState screenState;
  final String? error;
  final bool empty;
  final StatisticsModel? model;
  final StatisticsModel? statistics;

  NewHomeLoadedState(this.screenState, this.model, this.statistics,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {},
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(empty: S.current.homeDataEmpty, onRefresh: () {});
    }
    var color = Theme.of(context).colorScheme.primary;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              // color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    child: Container(
                  color: Colors.red,
                  // width: 100,
                  height: 100,
                )
                    // PieChart(
                    //   dataMap: <String, double>{
                    //     S.current.captains_active:
                    //         statistics?.captains.active.toDouble() ?? 0,
                    //     S.current.captains_not_active:
                    //         statistics?.captains.nonActive.toDouble() ?? 0,
                    //   },
                    // ),
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              // color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // width: 15,
                            // height: 15,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Icon(
                              FontAwesomeIcons.car,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(S.current.countCaptains),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                              '${statistics!.captains.active + statistics!.captains.nonActive}')
                        ],
                      ),
                    ),
                    Container(
                        height: 120,
                        // width: 150,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: PieChart(
                          dataMap: <String, double>{
                            S.current.captains_active:
                                statistics?.captains.active.toDouble() ?? 0,
                            S.current.captains_not_active:
                                statistics?.captains.nonActive.toDouble() ?? 0,
                          },
                          // colorList: [Colors.green, Colors.red],
                        )),
                    Text(
                      S.current.captain_statistics,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.current.last_three_active_captain,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      statistics?.captains.captains.length,
                                  itemBuilder: (context, index) {
                                    return FadeAnimation(
                                      index.toDouble(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    CaptainsRoutes
                                                        .CAPTAIN_PROFILE,
                                                    arguments: statistics
                                                        ?.captains
                                                        .captains[index]
                                                        .id);
                                              },
                                              trailing: Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                              leading: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: ClipOval(
                                                  // borderRadius: BorderRadius.circular(25),
                                                  child: CustomNetworkImage(
                                                    width: 50,
                                                    height: 50,
                                                    imageSource: statistics
                                                            ?.captains
                                                            .captains[index]
                                                            .images ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    statistics
                                                            ?.captains
                                                            .captains[index]
                                                            .name ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    CaptainsRoutes.CAPTAINS,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      S.current.more,
                                      // style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              // color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // width: 15,
                            // height: 15,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Icon(
                              FontAwesomeIcons.store,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(S.current.countStores),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                              '${statistics!.stores.active + statistics!.stores.nonActive}')
                        ],
                      ),
                    ),
                    Container(
                        height: 120,
                        // width: 150,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: PieChart(dataMap: <String, double>{
                          S.current.storesActive:
                              statistics?.stores.active.toDouble() ?? 0,
                          S.current.storesInActive:
                              statistics?.stores.nonActive.toDouble() ?? 0,
                        })),
                    Text(
                      'Store Statistics',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Top three Store Active',
                                // S.current.last_three_active_captain,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: statistics?.stores.captains.length,
                                  itemBuilder: (context, index) {
                                    return FadeAnimation(
                                      index.toDouble(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: ListTile(
                                              onTap: () {
                                                // Navigator.of(context).pushNamed(
                                                //     CaptainsRoutes
                                                //         .CAPTAIN_PROFILE,
                                                //     arguments: statistics
                                                //         ?.captains
                                                //         .captains[index]
                                                //         .id);
                                              },
                                              trailing: Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                              leading: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: ClipOval(
                                                  // borderRadius: BorderRadius.circular(25),
                                                  child: CustomNetworkImage(
                                                    width: 50,
                                                    height: 50,
                                                    imageSource: statistics
                                                            ?.stores
                                                            .captains[index]
                                                            .images ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    statistics
                                                            ?.stores
                                                            .captains[index]
                                                            .name ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(
                                  //   CaptainsRoutes.CAPTAINS,
                                  // );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      S.current.more,
                                      // style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetTile(BuildContext context, String count, String title) {
    return Container(
      width: !ScreenType.isDesktop(screenState.context)
          ? MediaQuery.of(screenState.context).size.width * 0.5
          : MediaQuery.of(screenState.context).size.width * 0.25,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AnimatedLiquidCircularProgressIndicator(
                ValueKey(title), int.parse(count)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  Theme.of(context).colorScheme.primary.withOpacity(0.95),
                  Theme.of(context).colorScheme.primary,
                ]),
                color: Theme.of(screenState.context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

final colorList = <Color>[
  Colors.greenAccent,
];
