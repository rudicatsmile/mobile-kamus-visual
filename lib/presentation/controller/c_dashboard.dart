import 'package:get/get.dart';
import '../../data/source/source_inout.dart';
import '../../data/source/source_peserta.dart';
import '../../data/source/source_peserta_dtks.dart';
import '../../data/source/source_product.dart';
import '../../data/source/source_user.dart';

import '../../data/source/source_history.dart';

class CDashboard extends GetxController {
  final RxInt _product = 0.obs;
  int get product => _product.value;
  setProduct() async {
    _product.value = await SourceProduct.count();
  }

  final RxInt _history = 0.obs;
  int get history => _history.value;
  setHistory() async {
    _history.value = await SourceHistory.count();
  }

  final RxInt _in = 0.obs;
  int get ins => _in.value;
  setIn() async {
    _in.value = await SourceInOut.count('IN');
  }

  final RxInt _out = 0.obs;
  int get outs => _out.value;
  setOut() async {
    _out.value = await SourceInOut.count('OUT');
  }

  final RxInt _employee = 0.obs;
  int get employee => _employee.value;
  setEmployee() async {
    _employee.value = await SourceUser.count();
  }

  final RxInt _peserta = 0.obs;
  int get peserta => _peserta.value;
  setPeserta() async {
    _peserta.value = await SourcePeserta.count();
  }

  //Count of Surveyor
  final RxInt _pesertaDtks = 0.obs;
  int get pesertaDtks => _pesertaDtks.value;
  setPesertaDtks() async {
    _pesertaDtks.value = await SourcePesertaDtks.count();
  }

  final RxInt _pesertaDtksValid = 0.obs;
  int get pesertaDtksValid => _pesertaDtks.value;
  setPesertaDtksValid() async {
    _pesertaDtksValid.value = await SourcePesertaDtks.countOfValid();
  }

  //Count of Validator
  @override
  void onInit() {
    setProduct();
    setHistory();
    setIn();
    setOut();
    setEmployee();
    setPeserta();
    setPesertaDtks();
    setPesertaDtksValid();
    super.onInit();
  }
}
