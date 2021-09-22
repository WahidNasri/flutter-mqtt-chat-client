import 'package:flutter/material.dart';

class MenuActionItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailingText;
  final Widget? leading;
  final Function()? onTap;
  const MenuActionItem({Key? key, required this.title, this.subtitle, this.trailingText, this.leading, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [_trailingTextWidget(), _arrowTapWidget()],),
        leading: leading,
      ),
    );
  }
  Widget _trailingTextWidget(){
    return trailingText != null ? Chip(label: Text(trailingText!)) : SizedBox();
  }
  Widget _arrowTapWidget(){
    return onTap != null ? Icon(Icons.keyboard_arrow_right) : SizedBox();
  }
}
