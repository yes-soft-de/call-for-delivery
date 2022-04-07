import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  final String Id;
  final String image;
  final String name;

  StoreCard(
      {Key? key,
      required this.Id,
      required this.image,
      required this.name,
      this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap ??
            () {
//              Navigator.of(context).pushNamed(CaptainsRoutes.CAPTAIN_PROFILE,
//                  arguments: int.parse(clientId));
            },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
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
                  name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).backgroundColor.withOpacity(0.2),
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
        ),
      ),
    );
  }
}
