import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ContactsHelper {
  static Future<void> getContactsDialog(
      context, Function(String) onChanged) async {
    return;
    // var status = await Permission.contacts.status;
    // if (status.isPermanentlyDenied) {
    //   return;
    // }
    // if (status.isDenied) {
    //   await Permission.contacts.request();
    // }
    // status = await Permission.contacts.status;
    // if (status.isGranted) {
    //   // Get all contacts without thumbnail (faster)
    //   List<Contact> contacts =
    //       await ContactsService.getContacts(withThumbnails: false);
    //   showDialog(
    //       context: context,
    //       builder: (_) {
    //         return StatefulBuilder(builder: (ctx, setState) {
    //           return AlertDialog(
    //             scrollable: true,
    //             title: Text(S.current.contacts),
    //             content: Column(
    //               children: getContacts(contacts, context, (s) {
    //                 onChanged(s);
    //                 Navigator.of(context).pop();
    //               }, setState),
    //             ),
    //           );
    //         });
    //       });
    // }
    // return;
  }
}

final TextEditingController searchController = TextEditingController();
// List<Widget> getContacts(
//     List<Contact> contacts, context, Function(String) onChanged, setState) {
//   List<Widget> widgets = [];
//   widgets.add(CustomFormField(
//     hintText: S.current.searchInContacts,
//     controller: searchController,
//     onChanged: () {
//       setState(() {});
//     },
//     sufIcon: Padding(
//       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//       child: Icon(Icons.search),
//     ),
//   ));
//   for (var element in contacts) {
//     if (element.displayName == null) {
//       element.displayName = S.current.unknown;
//     }
//     if (element.phones?.isNotEmpty != true) {
//       continue;
//     }
//     if (element.displayName?.contains(searchController.text) == false) {
//       continue;
//     }
//     widgets.add(ListTile(
//       onTap: () {
//         onChanged(element.phones?[0].value ?? '0');
//         searchController.clear();
//       },
//       leading: CircleAvatar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         child: Text(
//           element.displayName?[0] ?? 'X',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       title: Text(element.displayName ?? S.current.unknown),
//       subtitle: Text(
//         element.phones?[0].value ?? S.current.unknown,
//         textDirection: Localizations.localeOf(context).languageCode == 'ar'
//             ? TextDirection.ltr
//             : null,
//         textAlign: Localizations.localeOf(context).languageCode == 'ar'
//             ? TextAlign.right
//             : null,
//       ),
//     ));
//   }
//   return widgets;
// }
