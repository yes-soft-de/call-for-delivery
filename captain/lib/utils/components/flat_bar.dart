import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  /// current index of the selected item
  final int currentIndex;

  /// return the new index of selected item
  final Function(int) onItemSelected;

  /// the item list
  final List<FilterItem> items;

  /// color of the selected item content
  final Color selectedContent;

  /// color of the unselected item content
  final Color unselectedContent;

  /// duration of animation
  final Duration animationDuration;

  /// bar background color
  final Color backgroundColor;

  /// color of the item
  final Color cursorColor;

  /// radius of item card
  final BorderRadius? cursorRadius;

  /// spacing around edges
  final bool floating;

  /// border radius of bar
  final BorderRadius? borderRadius;

  /// padding
  final EdgeInsets? padding;

  /// height
  final double? height;

  FilterBar(
      {required this.currentIndex,
      required this.onItemSelected,
      required this.items,
      this.height,
      required this.selectedContent,
      required this.unselectedContent,
      required this.animationDuration,
      required this.backgroundColor,
      required this.cursorColor,
      this.cursorRadius,
      this.floating = false,
      this.borderRadius,
      this.padding})
      : assert(items.length >= 2) {
    for (int i = 0; i < items.length; i++) {
      items[i].index = i;
    }
  }

  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late Duration animationDuration;
  BorderRadius? cursorRadius;
  late bool floating;
  double? opacity;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  List<GlobalKey> _keys = [];
  Offset? initialOffset;
  late Widget itemBuilder;
  late bool firstUse;
  late double off;
  bool end = true;
  String? myLocalChanges;
  int currentIndex = 0;
  @override
  void initState() {
    firstUse = true;
    _reset();
    super.initState();
  }

  void _reset([bool first = true]) {
    animationDuration = widget.animationDuration;
    cursorRadius = widget.cursorRadius;
    floating = widget.floating;
    borderRadius = widget.borderRadius;
    padding = widget.padding;
    firstUse = first;
    currentIndex = widget.currentIndex;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      try {
        if (firstUse) {
          _keys.forEach((element) {
            itemSize.add(element.currentContext?.size ?? Size(0, 0));
          });
        }
        RenderBox render =
            _keys[currentIndex].currentContext?.findRenderObject() as RenderBox;
        initialOffset = render.localToGlobal(Offset.fromDirection(1, -16));
        if (initialOffset != null) {
          initialOffset = Offset(initialOffset!.dx, initialOffset!.dx);
        }
        setState(() {});
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void didUpdateWidget(FilterBar oldWidget) {
    if (myLocalChanges != Localizations.localeOf(context).languageCode) {
      myLocalChanges = Localizations.localeOf(context).languageCode;
      _reset();
    } else if (curserNotInPlace()) {
      _reset();
    }
    if (widget.currentIndex != currentIndex) {
      _reset(false);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: animationDuration,
      padding: padding ?? const EdgeInsets.only(right: 8, left: 8.0),
      child: AnimatedContainer(
        height: widget.height ?? 75,
        duration: animationDuration,
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(opacity ?? 1),
          borderRadius: borderRadius,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                onEnd: () {
                  end = true;
                  setState(() {});
                },
                left: firstUse ? null : (initialOffset?.dx ?? 0),
                duration: animationDuration,
                curve: Curves.easeInOut,
                child: Container(
                  height: itemSize.isEmpty ? 10 : itemSize[currentIndex].height,
                  width: itemSize.isEmpty ? 10 : itemSize[currentIndex].width,
                  decoration: BoxDecoration(
                    color: widget.cursorColor,
                    gradient: LinearGradient(colors: [
                      widget.cursorColor.withOpacity(0.85),
                      widget.cursorColor.withOpacity(0.85),
                      widget.cursorColor.withOpacity(0.9),
                      widget.cursorColor.withOpacity(0.93),
                      widget.cursorColor.withOpacity(0.95),
                      widget.cursorColor,
                    ]),
                    borderRadius: cursorRadius ??
                        BorderRadius.vertical(top: Radius.circular(18)),
                  ),
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: getItemWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getItemWidget() {
    List<Widget> barItems = [];
    for (var element in widget.items) {
      _keys.add(GlobalKey(debugLabel: element.label));
      barItems.add(
        Expanded(
          child: InkWell(
              splashColor: Colors.transparent,
              key: _keys[element.index],
              onTap: () {
                if (currentIndex != element.index) {
                  if (firstUse == false) {
                    end = false;
                  }
                }
                currentIndex = element.index;
                if (firstUse) {
                  firstUse = false;
                }
                try {
                  RenderBox render = _keys[element.index]
                      .currentContext
                      ?.findRenderObject() as RenderBox;
                  initialOffset =
                      render.localToGlobal(Offset.fromDirection(1, -16));
                  if (initialOffset != null) {
                    initialOffset =
                        Offset(initialOffset!.dx, initialOffset!.dx);
                  }
                } catch (e) {
                  print(e);
                }
                widget.onItemSelected(currentIndex);
                setState(() {});
              },
              child: Center(
                child: Text(
                  element.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: currentIndex == element.index && end
                        ? widget.selectedContent
                        : widget.unselectedContent,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              )),
        ),
      );
    }
    return barItems;
  }

  List<Size> itemSize = [];
  bool curserNotInPlace() {
    RenderBox render =
        _keys[currentIndex].currentContext?.findRenderObject() as RenderBox;
    var correctOffset = render.localToGlobal(Offset.fromDirection(1, -16));
    correctOffset = Offset(correctOffset.dx, correctOffset.dx);
    if (correctOffset == initialOffset) {
      return false;
    }
    return true;
  }
}

class FilterItem {
  final String label;
  late int index;

  FilterItem({required this.label});
}
