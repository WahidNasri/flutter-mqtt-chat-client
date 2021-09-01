import 'dart:io';

import 'package:flutter_mqtt/abstraction/FileUploader.dart';

class FakeUploader extends FileUploader {
  @override
  Future<String?> uploadFile(String uploadUrl, String fileLocalPath) async {
    await Future.delayed(Duration(seconds: 5));
    return "https://img.freepik.com/free-vector/nature-scene-with-river-hills-forest-mountain-landscape-flat-cartoon-style-illustration_1150-37326.jpg?size=626&ext=jpg&ga=GA1.2.1933447203.1629590400";
  }
}
