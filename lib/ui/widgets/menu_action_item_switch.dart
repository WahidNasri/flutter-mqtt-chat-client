import 'package:flutter/material.dart';

class MenuSwitchItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool active;
  final Widget? leading;
  final Function(bool) onChanged;
  const MenuSwitchItem({Key? key, required this.title, this.subtitle, required this.active, this.leading, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){onChanged(!active);},
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [_trailingTextWidget()],),
        leading: leading,
      ),
    );
  }
  Widget _trailingTextWidget(){
    return Switch(value: active, onChanged: onChanged);
  }
}
