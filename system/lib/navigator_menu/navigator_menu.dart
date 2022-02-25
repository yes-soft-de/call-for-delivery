import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/customIcon/mandob_icons_icons.dart';
import 'package:flutter/material.dart';

// current last index is 19
class NavigatorMenu extends StatefulWidget {
  final Function(StatefulWidget) onTap;
  final StatefulWidget currentPage;
  final double? width;
  NavigatorMenu({this.width, required this.onTap, required this.currentPage});

  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  MandobIcons.logo,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'dash',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
    return Container(
        width: widget.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                ? BorderRadius.horizontal(left: Radius.circular(25))
                : BorderRadius.horizontal(right: Radius.circular(25))),
        child: CustomListView.custom(children: [
          drawerHeader,
        ]));
  }

  Widget customListTile(StatefulWidget page, String title, IconData icon,
      [bool subtitle = false]) {
    bool selected = page.runtimeType.toString() ==
        widget.currentPage.runtimeType.toString();
    double? size =
        icon.fontPackage == 'font_awesome_flutter' ? (subtitle ? 18 : 22) : 26;
    if (size == 26 && subtitle) {
      size = 20;
    }

    return Padding(
      key: ValueKey(page.runtimeType),
      padding: EdgeInsets.only(
          left: subtitle ? 16.0 : 8.0, right: subtitle ? 16 : 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(25)),
        child: ListTile(
          minLeadingWidth: subtitle ? 4 : null,
          visualDensity: VisualDensity(vertical: -2),
          onTap: () {
            widget.onTap(page);
            GlobalVariable.mainScreenScaffold.currentState?.openEndDrawer();
            setState(() {});
          },
          leading:
              Icon(icon, color: selected ? Colors.white : null, size: size),
          title: Text(
            title,
            style: TextStyle(
                color: selected ? Colors.white : null,
                fontSize: subtitle ? 14 : null),
          ),
        ),
      ),
    );
  }

  Widget customExpansionTile(
      {required StatefulWidget page,
      required String title,
      required IconData icon,
      required List<Widget> children}) {
    bool extended = false;
    for (var i in children) {
      if (i.key.toString() == '[<${page.runtimeType}>]') {
        extended = true;
        break;
      }
    }
    double? size = icon.fontPackage == 'font_awesome_flutter' ? 22 : 26;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: extended,
          title: Text(title),
          leading: Icon(
            icon,
            size: size,
          ),
          children: children,
        ),
      ),
    );
  }
}
