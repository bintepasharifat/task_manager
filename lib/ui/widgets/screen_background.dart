import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/utils/assets_imagepath.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key,required this.child});
  
  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetsImagepath.backgroundSvg,
            
            fit: BoxFit.contain,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          SafeArea(child: child),
          
        ],
      ),
    );
  }
}