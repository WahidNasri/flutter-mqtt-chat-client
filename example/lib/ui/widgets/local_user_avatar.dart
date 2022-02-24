import 'package:example/database/chat_db.dart';
import 'package:example/database/models/user.dart';
import 'package:example/proviers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalUserAvatar extends ConsumerStatefulWidget {
  final double? radius;
  const LocalUserAvatar({Key? key, this.radius}) : super(key: key);

  @override
  ConsumerState<LocalUserAvatar> createState() => _LocalUserAvatarState();
}

class _LocalUserAvatarState extends ConsumerState<LocalUserAvatar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user;
    if(user != null){
      return CircleAvatar(
          radius: widget.radius ?? 8,
          foregroundImage: NetworkImage(user.avatar ?? ""));
    }
    else {
      return CircleAvatar(
          radius: widget.radius ?? 8,
          child: const Icon(Icons.person));
    }
  }
}
