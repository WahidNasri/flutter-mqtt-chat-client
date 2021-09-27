import 'package:flutter/material.dart';

class AvatarWithBadge extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final ImageProvider<Object>? foregroundImage;
  final double? radius;
  final bool showBadge;
  final Widget? badgeWidget;
  final double? badgeRadius;
  const AvatarWithBadge(
      {Key? key, this.title, this.onTap, this.foregroundImage, this.radius, this.showBadge = true, this.badgeWidget, this.badgeRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Stack(
              children: [
                CircleAvatar(
                  foregroundImage: foregroundImage,
                  radius: radius ?? 30,
                ),
                _buildBadge()
              ],
            ),
          ),
          title != null ? Text(title!) : SizedBox()
        ],
      ),
    );
  }
  Widget _buildBadge(){
    if(showBadge){
      if(badgeWidget != null){
        return badgeWidget!;
      }
      return Positioned(
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: badgeRadius ?? 11,
          child: Icon(
            Icons.clear,
            color: Colors.white,
            size: 13,
          ),
        ),
        bottom: 0,
        right: 0,
      );
    }
    return SizedBox();
  }
}
