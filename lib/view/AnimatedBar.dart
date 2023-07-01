import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AnimatedBar extends StatefulWidget {
  final int position;
  final int currentIndex;
  final AnimationController animationController;

  const AnimatedBar({
    Key? key,
    required this.position,
    required this.currentIndex,
    required this.animationController,
  }) : super(key: key);

  @override
  _AnimatedBarState createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  late final Animation<double> _curvedAnimation;
  late VoidCallback _animationListener;

  @override
  void initState() {
    super.initState();
    _curvedAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.linear,
    );
    _animationListener = () {
      if (mounted) {
        setState(() {});
      }
    };
    widget.animationController.addListener(_animationListener);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6.sp),
            height: 7.sp,
            child: widget.currentIndex == widget.position
                ? LinearProgressIndicator(
                    value: _curvedAnimation.value,
                    backgroundColor: Colors.white38,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Container(
                    color: widget.position < widget.currentIndex
                        ? Colors.white
                        : Colors.white38,
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.animationController.removeListener(_animationListener);
    super.dispose();
  }
}
