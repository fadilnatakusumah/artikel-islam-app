import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  }) : super(key: key);

  const SkeletonContainer.square({
    Key? key,
    required double height,
    required double width,
  }) : this._(
          width: width,
          height: height,
        );

  const SkeletonContainer.rounded({
    Key? key,
    required double height,
    required double width,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(
          width: width,
          height: height,
          borderRadius: borderRadius,
        );

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
