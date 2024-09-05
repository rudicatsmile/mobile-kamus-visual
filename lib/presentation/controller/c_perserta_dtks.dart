import 'package:d_method/d_method.dart';
import 'package:get/get.dart';
import '../../data/model/dtks_images.dart';
import '../../data/model/list_kata.dart';
import '../../data/model/peserta _dtks.dart';
import '../../data/source/source_peserta_dtks.dart';

class CPesertaDtks extends GetxController {
  // RxString nikUser = ''.obs;
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<PesertaDtks> _list = <PesertaDtks>[].obs;
  List<PesertaDtks> get list => _list.value;
  setList() async {
    loading = true;
    DMethod.printTitle('Source : ', 'setList aja');

    update();
    _list.value = await SourcePesertaDtks.gets();
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  final RxList<DtksImages> _listImage = <DtksImages>[].obs;
  List<DtksImages> get listImage => _listImage.value;
  setListImage(nik,tahun,bulan,mode) async {
    loading = true;    
    _listImage.value = await SourcePesertaDtks.getImage(nik,tahun,bulan,mode);
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }
  

  search(String query) async {
    // _list.value = await SourcePesertaDtks.search(query);
    //1*
    // _listByNik.value = await SourcePesertaDtks.search(query);
    _listKata.value = await SourcePesertaDtks.search(query);
    update();
  }

  //List DTKS pindah kesini
  //1*
  final RxList<PesertaDtks> _listByNik = <PesertaDtks>[].obs;
  List<PesertaDtks> get listByNik => _listByNik.value;

  setListByNik(nikSurveyor,kdkelurahan) async {   
    loading = true;
    DMethod.printTitle('Source : ', 'setList aja');
    update();
    _listByNik.value = await SourcePesertaDtks.getsDtks(nikSurveyor,kdkelurahan);
    update();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
      update();
    });
  }

  //1*
  final RxList<ListKata> _listKata = <ListKata>[].obs;
  List<ListKata> get listKata => _listKata.value;

  setListKata(nik,kdkelurahan) async {   
    loading = true;
    DMethod.printTitle('Source : ', 'setListKata aja');
    update();
    _listKata.value = await SourcePesertaDtks.getsKata(nik,kdkelurahan);
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
