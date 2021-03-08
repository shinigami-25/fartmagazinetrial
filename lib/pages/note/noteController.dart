import 'package:fartmagazinetrial1/pages/home/homeController.dart';
import 'package:fartmagazinetrial1/services/firestoreService.dart';
import 'package:fartmagazinetrial1/services/storageService.dart';
import 'package:fartmagazinetrial1/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  Future<FilePickerResult> pickFile() async {
    return await FilePicker.platform
        .pickFiles(allowedExtensions: ['jpg', 'jpeg'], type: FileType.custom);
  }

  Future<void> addNoteCallback(var title, var content, var path) async {
    await FirestoreService()
        .addNote(title, content, path: 'users/${curUser.email}/$title.jpg');
    await StorageService().addPic(title, path);
    Get.find<HomeController>().updateNotes();
    Get.back();
  }
}
