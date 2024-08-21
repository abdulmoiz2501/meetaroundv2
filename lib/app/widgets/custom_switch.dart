import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double scale;
  final Color valueTrue;
  final Color valueFalse;

  const CustomSwitch(
      {super.key,
      required this.value,
      required this.onChanged,
      this.scale = 0.7,
      required this.valueTrue,
      required this.valueFalse});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  bool get value => widget.value;
  double get scale => widget.scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!value);
      },
      child: Transform.scale(
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36.w,
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: value ? widget.valueTrue : widget.valueFalse,
          ),
          child: Align(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Container(
                width: 13.w,
                height: 13.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoidColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
