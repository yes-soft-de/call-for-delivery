import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class TopStoreActivityWidget extends StatelessWidget {
  final TopActiveStoreModel topActiveStoreModel;
  const TopStoreActivityWidget(this.topActiveStoreModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor,
        ),
        child: ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipOval(
              // borderRadius: BorderRadius.circular(25),
              child: CustomNetworkImage(
                width: 50,
                height: 50,
                imageSource: topActiveStoreModel.imageUrl!,
              ),
            ),
          ),
          title: Text(
            topActiveStoreModel.storeOwnerName!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: topActiveStoreModel.todayOrdersCount != null ||
                  topActiveStoreModel.lastTwentyFourOrdersCount != null
              ? SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topActiveStoreModel.storeBranchName!,
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.current.countTodayOrder + ' :',
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              topActiveStoreModel.todayOrdersCount.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       S.current.last24CountOrder + ':',
                      //       softWrap: false,
                      //       style: TextStyle(
                      //           color: Colors.grey.shade400,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //     // SizedBox(
                      //     //   width: 5,
                      //     // ),
                      //     // Expanded(
                      //     //   child: Text(
                      //     //     topActiveStoreModel.lastTwentyFourOrdersCount
                      //     //         .toString(),
                      //     //     style: TextStyle(
                      //     //         color: Colors.white,
                      //     //         fontWeight: FontWeight.w500),
                      //     //   ),
                      //     // )
                      //   ],
                      // ),
                    
                    ],
                  ),
                )
              : Text(
                  topActiveStoreModel.storeBranchName!,
                  style: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.w500),
                ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).backgroundColor.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      topActiveStoreModel.ordersCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
