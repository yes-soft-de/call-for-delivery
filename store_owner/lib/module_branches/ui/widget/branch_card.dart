import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_branches/ui/widget/custom_icon_button.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback preview;
  final String branchName;
  const BranchCard(
      {Key? key,
      required this.onDelete,
      required this.onEdit,
      required this.preview,
      required this.branchName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).backgroundColor,
                blurRadius: 12,
                spreadRadius: 2.5,
                offset: Offset(-0.5, 0))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    branchName,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // edit
                  CustomIconButton(
                    onTap: onEdit,
                    backgroundColor: isDark
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).colorScheme.primaryContainer,
                    icon: Icons.edit,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  // delete
                  CustomIconButton(
                    onTap: onDelete,
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    icon: Icons.delete,
                    iconColor: Theme.of(context).colorScheme.error,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  // preview
                  CustomIconButton(
                    onTap: preview,
                    backgroundColor: Colors.green[100]!,
                    icon: Icons.location_on_rounded,
                    iconColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BranchCardList extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String branchName;
  const BranchCardList(
      {Key? key,
      required this.onDelete,
      required this.onEdit,
      required this.branchName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).backgroundColor,
                blurRadius: 12,
                spreadRadius: 2.5,
                offset: Offset(-0.5, 0))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              icon: Icons.store_rounded,
              iconColor: Theme.of(context).colorScheme.secondary,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    branchName,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // edit
                  CustomIconButton(
                    onTap: onEdit,
                    backgroundColor: isDark
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).colorScheme.primaryContainer,
                    icon: Icons.edit,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  // delete
                  CustomIconButton(
                    onTap: onDelete,
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    icon: Icons.delete,
                    iconColor: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
