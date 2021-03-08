
import 'package:fartmagazinetrial1/pages/home/homeController.dart';
import 'package:fartmagazinetrial1/services/firestoreService.dart';
import 'package:fartmagazinetrial1/services/storageService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../shared.dart';

class EditNoteController extends GetxController {
  EditNoteController(this.title);
  final title;
  String link = '';

  void onInit() async {
    super.onInit();
    await getPic();
  }

  Future<FilePickerResult> pickFile() async {
    return await FilePicker.platform
        .pickFiles(allowedExtensions: ['jpg', 'jpeg'], type: FileType.custom);
  }

  Future<void> getPic() async {
    link = await StorageService().picFuture(title);
    update();
  }

  Future<void> editNoteCallback(var title, var content, var path) async {
    await FirestoreService()
        .editNote(title, content, path: 'users/${curUser.email}/$title.jpg');
    await StorageService().addPic(title, path);
    Get.find<HomeController>().updateNotes();
    Get.back();
  }
}
