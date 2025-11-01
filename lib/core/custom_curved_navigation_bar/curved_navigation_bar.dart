import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_custom_clipper.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_item.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_item_widget.dart';
import 'src/nav_button.dart';
import 'src/nav_custom_painter.dart';

typedef _LetIndexPage = bool Function(int value);

class CurvedNavigationBar extends StatefulWidget {
  final List<NavItem> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? maxWidth;

  CurvedNavigationBar({
    super.key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
    this.maxWidth,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        assert(maxWidth == null || 0 <= maxWidth);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  late int _endingIndex;
  late double _pos;
  double _buttonHide = 0;

  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    // _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _endingIndex = widget.index;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          // _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
    if (!_animationController.isAnimating) {
      // _icon = widget.items[_endingIndex];
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return Container(
      color:ConsColors.blueLight, // رنگ پس‌زمینه کل بخش، شامل مارجین
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: widget.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = min(
                constraints.maxWidth, widget.maxWidth ?? constraints.maxWidth);
            return Align(
              alignment: textDirection == TextDirection.ltr
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: Container(
                color: widget.backgroundColor,

                width: maxWidth,
                child: ClipRect(
                  clipper: NavCustomClipper(
                    deviceHeight: MediaQuery.sizeOf(context).height,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: -10 - (75.0 - widget.height),
                        left: textDirection == TextDirection.rtl
                            ? null
                            : _pos * maxWidth,
                        right: textDirection == TextDirection.rtl
                            ? _pos * maxWidth
                            : null,
                        width: maxWidth / _length,
                        child: Center(
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              -(1 - _buttonHide) * 80,
                            ),
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [ConsColors.orange, ConsColors.orange2],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn,
                              child: Material(
                                color:Colors.orange,
                                type: MaterialType.circle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 1,
                                    height: 1,
                                    // color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0 - (75.0 - widget.height),
                        child: CustomPaint(

                          painter: NavCustomPainter(
                              _pos, _length, widget.color, textDirection),
                          child: Container(
                            height: 75.0,

                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0 - (95.0 - widget.height),
                        child: SizedBox(
                            height: 100.0,
                            child: Row(

                                children: widget.items.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  NavItem item = entry.value;
                                  bool isSelected = index == _endingIndex;

                                  return NavButton(
                                onTap: _buttonTap,
                                position: _pos,
                                length: _length,
                                index: widget.items.indexOf(item),
                                child:   NavItemWidget(
                                item: item,
                                isSelected: isSelected,
                              ),
                              );
                            }).toList())),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index) || _animationController.isAnimating) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
