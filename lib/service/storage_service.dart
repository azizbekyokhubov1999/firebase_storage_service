import 'dart:developer';
import 'dart:io';
// import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class StorageService{

  static const String parentPath = "fl22";

  static final ref = FirebaseStorage.instance.ref();

  static Future<String> upload({required String path, required File file}) async{
    final Reference reference = ref.child(path).child("file_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    UploadTask uploadTask = reference.putFile(file);
    log("\n\nmessage1111\n\n");
    await uploadTask.whenComplete(() {});
    log("\n\nmessage22222\n\n");
    return reference.getDownloadURL();
  }

  // static Future<String> upload({required String path, required File file}) async {
  //   final fileName = path.(file.path);
  //   final Reference reference = ref.child(path).child(fileName);
  //   UploadTask uploadTask = reference.putFile(file);
  //   await uploadTask;
  //   return reference.getDownloadURL();
  // }

  static Future<List<String>> getFile(String path) async{
    List<String> itemList = [];
    final Reference reference = ref.child(path);
    ListResult listResult = await reference.listAll();
    for(Reference e in listResult.items){
      itemList.add(await e.getDownloadURL());
    }
    return itemList;
  }

  static Future<void> delete(String url) async{
    final Reference reference = FirebaseStorage.instance.refFromURL(url);
    await reference.delete();
  }

  static Future<File> downloadFile(String url) async {
    final String fileName = url.split('/').last;
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/$fileName');
    if (tempFile.existsSync()) {
      return tempFile;
    }
    await ref.child(parentPath).child(fileName).writeToFile(tempFile);
    return tempFile;
  }

}