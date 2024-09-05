import 'package:get/get.dart';

import '../../data/model/peserta.dart';
import '../../data/source/source_peserta.dart';

class CPeserta extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<Peserta> _list = <Peserta>[].obs;
  List<Peserta> get list => _list.value;
  setList() async {
    loading = true;
    update();
    _list.value = await SourcePeserta.gets();
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  @override
  void onInit() {
    setList();
    super.onInit();
  }
}
