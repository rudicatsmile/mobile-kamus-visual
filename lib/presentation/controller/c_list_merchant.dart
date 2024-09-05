import 'package:d_method/d_method.dart';
import 'package:get/get.dart';
import '../../data/model/dtks_images.dart';
import '../../data/model/list_apotek.dart';
import '../../data/model/list_merchant.dart';
import '../../data/source/source_list_apotek.dart';

class CListMerchant extends GetxController {
  // RxString nikUser = ''.obs;
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<ListApotek> _list = <ListApotek>[].obs;
  List<ListApotek> get list => _list.value;
  setList() async {
    loading = true;
    DMethod.printTitle('Source : ', 'setList aja');

    update();
    _list.value = await SourceListAPotek.gets();
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
    _listImage.value = await SourceListAPotek.getImage(nik,tahun,bulan,mode);
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  search(String query) async {   
    _listByNik.value = await SourceListAPotek.searchMerchant(query);
    update();
  }

  //List DTKS pindah kesini
  //1*
  final RxList<ListMerchant> _listByNik = <ListMerchant>[].obs;
  List<ListMerchant> get listByNik => _listByNik.value;
  setListByNik(kriteria,idUser,kdKecamatan,dataSearch) async {       

    loading = true;
    DMethod.printTitle('Source : ', 'setList aja');
    DMethod.printTitle('kriteria : ', kriteria);
    DMethod.printTitle('idUser : ', idUser);
    DMethod.printTitle('kdKecamatan : ', kdKecamatan);
    DMethod.printTitle('dataSearch : ', dataSearch);
    update();
    _listByNik.value = await SourceListAPotek.getMerchant(kriteria,idUser,kdKecamatan,dataSearch);
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
