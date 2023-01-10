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
          subtitle: Text(
            topActiveStoreModel.storeBranchName!,
            style: TextStyle(
                color: Colors.grey.shade400, fontWeight: FontWeight.w500),
          ),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
        ),
      ),
    );
  }
}
