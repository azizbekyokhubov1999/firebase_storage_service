import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_service/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String>itemList = [];
  bool isStorageCame = false;

  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};


  // Future<File> takeFile() async{
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
  //   File file = File(xFile?.path ?? "");
  //   return file;
  // }

  Future<File> takeFile() async{
    final  picker = await FilePicker.platform.pickFiles();
    final PlatformFile  pickedFile = picker!.files.first;
    File file = File(pickedFile.path ?? "");
    return file;
  }

  // Future<void> selectFile() async{
  //  final result = await FilePicker.platform.pickFiles();
  //  if(result == null) return;
  //  setState(() {
  //    pickedFile = result.files.first;
  //  });
  // }

  Future<void> uploadFile() async{
    String link = await StorageService.upload(path: StorageService.parentPath,
        file: await takeFile());
    log(link);
    setState(() {});
  }

  Future<void> getFile() async{
    isStorageCame = false;
    itemList = await StorageService.getFile(StorageService.parentPath);
    isStorageCame = true;
    setState(() {});
  }

  Future<void> deleteFile(String url) async{
    await StorageService.delete(url);
    setState(() {});
  }

  Future<void> downloadFile(int index, Reference ref) async{
  // final dir = await getApplicationDocumentsDirectory();
  // final file = File('${dir.path}/${ref.name}');
  // await ref.writeToFile(file);
    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(
        url,
        path,
      onReceiveProgress: (received, total){
          double progress = received / total;
          setState(() {
            downloadProgress[index] = progress;
          });
      }
    );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Downloaded ${ref.name}")),
  );
  setState(() {});
  }
  @override
  void initState() {
    getFile();
    super.initState();

    futureFiles = FirebaseStorage.instance.ref(StorageService.parentPath).listAll();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ListResult> (
        future: futureFiles,
        builder: (context, snapshot) {
          final files = snapshot.data?.items;
          return isStorageCame ? ListView.builder(
          itemCount:  files?.length,
                          itemBuilder: (_, index){
                   final file = files?[index];
                   double? progress = downloadProgress[index];
                             return Card(
                               child: ListTile(
                                 title: Text('Name: ${file?.name}'),
                                 subtitle: progress != null ?
                                     LinearProgressIndicator(
                                       value: progress,
                                       backgroundColor: Colors.blue,
                                     ): null,
                                 trailing: Row(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     IconButton(
                                         onPressed: () async{
                                           await downloadFile(index, file!).then((value) {
                                             log('Successfully download');
                                           });
                                         },
                                         icon: const Icon(Icons.download)
                                     ),
                                     IconButton(
                                         onPressed: () async{
                                           await deleteFile(itemList[index]);
                                           setState(() {});
                                           },
                                         icon: const Icon(Icons.delete),
                                     ),
                                   ],
                                 ),
                                 onTap: (){
                                   //FirebaseCrashlytics.instance.crash();
                                 },
                               ),
                             );
                          }
                      ): Center(
                        child: CircularProgressIndicator(),
                     );
        },
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Expanded(
      //         flex: 3,
      //         child: isStorageCame ? ListView.builder(
      //              itemCount:  itemList.length,
      //             itemBuilder: (_, index){
      //                return Card(
      //                  child: ListTile(
      //                    title: Text('Type: ${itemList[index]}'),
      //                    trailing: Row(
      //                      mainAxisSize: MainAxisSize.min,
      //                      children: [
      //                        IconButton(
      //                            onPressed: () async{
      //                              await downloadFile(itemList[index]).then((value) {
      //                                log('Successfully download');
      //                              });
      //                            },
      //                            icon: const Icon(Icons.download)
      //                        ),
      //                        IconButton(
      //                            onPressed: () async{
      //                              await deleteFile(itemList[index]);
      //                              setState(() {});
      //                              },
      //                            icon: const Icon(Icons.delete),
      //                        ),
      //                      ],
      //                    ),
      //                  ),
      //                );
      //             }
      //         ) : Center(
      //           child: CircularProgressIndicator(),
      //         )
      //     )
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await uploadFile();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
