import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/request/captain_activities_filter_request.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/progresive_image.dart';

import '../../captains_routes.dart';

class CaptainActivityCard extends StatelessWidget {
  final int id;
  final String image;
  final String captainName;
  final String orderCount;
  final String? last24CountOrder;
  final String? todayCountOrder;
  final CaptainActivityFilterRequest filter;

  CaptainActivityCard({
    Key? key,
    required this.id,
    required this.image,
    required this.captainName,
    this.onTap,
    required this.orderCount,
    required this.last24CountOrder,
    required this.todayCountOrder,
    required this.filter,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding:
          const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed(CaptainsRoutes.CAPTAIN_PROFILE, arguments: id);
          if (filter.fromDate == null && filter.toDate == null) {
            Navigator.of(context).pushNamed(
                CaptainsRoutes.CAPTAIN_ACTIVITY_DETAILS,
                arguments: [id, captainName, null]);
          } else {
            Navigator.of(context).pushNamed(
              CaptainsRoutes.CAPTAIN_ACTIVITY_DETAILS,
              arguments: [id, captainName, filter]);
          }
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 8, top: 8),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipOval(
                          // borderRadius: BorderRadius.circular(25),
                          child: CustomNetworkImage(
                            width: 50,
                            height: 50,
                            imageSource: image,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        captainName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              orderCount + ' ' + S.current.sOrder,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // last 24 hours && today orders
                Visibility(
                    visible: todayCountOrder != null,
                    child: Column(children: [
                      Divider(
                        indent: 16,
                        endIndent: 16,
                        thickness: 1.5,
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                S.current.last24CountOrder,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                (last24CountOrder ?? '0') +
                                    ' ' +
                                    S.current.sOrder,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 1.5,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: ListTile(
                              title: Text(
                                S.current.countTodayOrder,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                (todayCountOrder ?? '0') +
                                    ' ' +
                                    S.current.sOrder,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])),
              ],
            )),
      ),
    );
  }
}
