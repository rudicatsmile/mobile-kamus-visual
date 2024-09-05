import 'package:get/get.dart';

class AppBarController extends GetxController {
  var showListView = false.obs; // Observable untuk visibilitas ListView

  void toggleListView() {
    showListView.value = !showListView.value;
  }
}
