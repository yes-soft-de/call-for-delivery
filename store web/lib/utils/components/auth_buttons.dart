import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final String firstButtonTitle;
  final String secondButtonTitle;
  final VoidCallback? firstButtonTab;
  final VoidCallback secondButtonTab;
  final bool? loading;
  const AuthButtons(
      {super.key,
      required this.firstButtonTitle,
      required this.secondButtonTitle,
      this.firstButtonTab,
      required this.secondButtonTab,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 8.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                  onPressed: firstButtonTab,
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: loading!
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).textTheme.labelLarge?.color ??
                                    Colors.white),
                          )
                        : Text(
                            firstButtonTitle,
                          ),
                  )),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       right: 16.0, left: 16, bottom: 8.0, top: 8.0),
          //   child: SizedBox(
          //     width: double.maxFinite,
          //     height: 50,
          //     child: OutlinedButton(
          //         onPressed: secondButtonTab,
          //         style: ButtonStyle(
          //           backgroundColor: MaterialStateColor.resolveWith(
          //               (states) => const Color.fromARGB(111, 255, 255, 255)),
          //           shape: MaterialStateProperty.all(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(40),
          //             ),
          //           ),
          //           side: MaterialStateProperty.all(
          //             const BorderSide(
          //                 color: Color(0xff03816A),
          //                 width: 3,
          //                 style: BorderStyle.solid),
          //           ),
          //         ),
          //         child: Center(
          //           child: Text(
          //             secondButtonTitle,
          //             style: Theme.of(context).textTheme.labelLarge?.copyWith(
          //                   color: const Color(0xff03816A),
          //                 ),
          //           ),
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
