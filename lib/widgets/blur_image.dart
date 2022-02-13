import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurImage extends StatelessWidget {
  final String img;
  final double? height;

  const BlurImage({required this.img, this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Image.network(
          img,
          width: double.infinity,
          height: height ?? 250.w,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Container(
          width: double.infinity,
          height: 80.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white.withOpacity(0.0), Colors.white],
            ),
          ),
        ),
      ],
    );
  }
}
