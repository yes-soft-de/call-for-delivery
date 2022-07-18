import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/utils/components/progresive_image.dart';

class CaptainCard extends StatelessWidget {
  final int captainId;
  final String image;
  final String captainName;
  final bool verificationStatus;
  CaptainCard(
      {Key? key,
      required this.captainId,
      required this.image,
      required this.captainName,
      this.onTap,
      required this.verificationStatus});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Navigator.of(context)
              .pushNamed(CaptainsRoutes.CAPTAIN_PROFILE, arguments: captainId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.primary,
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
                  captainName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: verificationStatus ? Colors.green : Colors.orange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      verificationStatus
                          ? S.current.accountVerified
                          : S.current.accountUnVerified,
                      style: TextStyle(color: Colors.white,fontSize: 10),
                    ),
                  ),
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
