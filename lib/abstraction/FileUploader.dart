import 'dart:io';

abstract class FileUploader {
  Future<String?> uploadFile(
      String uploadUrl, String localPath); //should return download url
}
