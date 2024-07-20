import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData? icon;
  final Color bgColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon({
    super.key,
     this.icon,
    this.bgColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2), color: bgColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }}
class AppImageIcon extends StatelessWidget {
 final String  imageUrl;final Color? iconColor;final double? iconSize;final double? size; final Color? bgColor;
 final double? edginsets;
  const AppImageIcon({Key? key,
    required this.imageUrl,   this.bgColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.edginsets,
    this.size = 40,
    this.iconSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size! / 2), color: bgColor),
      child: Padding(
        padding:  EdgeInsets.all(edginsets!),
        child: ImageIcon(
          AssetImage(imageUrl.toString()),
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
