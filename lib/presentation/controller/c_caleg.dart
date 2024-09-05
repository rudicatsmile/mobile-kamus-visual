import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../../data/model/caleg.dart';
import '../../data/model/data_dashboard.dart';

import 'package:http/http.dart' as http;

import '../../data/model/data_tim.dart';
import '../../data/source/source_caleg.dart';


// class CCaleg extends GetxController {
class CFeatured extends GetxController {
  // final String kodeTpsA;
  // CCaleg(this.kodeTpsA) ;

  String level = '';
  String userName = '';
  String kodeTps = '';
  int dataPantau2 = 0;
  late DataDashboard aa;

  DataDashboard? dashboardShow;  
  DataDashboard? dashboardDetail;

  
  RxString namaAplikasi = "".obs;
  RxString judulUtama = "".obs;
  RxString judulProfil = "".obs;
  RxString motoProfil = "".obs;
  RxString namaCaleg = "".obs;
  RxString namaPartai = "".obs;
  RxString targetSuara = "".obs;
  RxString rating = "".obs;
  RxString fileImageName = "".obs;
  RxString imgNetwork = "".obs;
  RxString appStr = "".obs;
  
  final RxString _kodeTps2 = ''.obs;
  String get kodeTps2 => _kodeTps2.value;
  set kodeTps2(String newData){
    _kodeTps2.value = newData;
  }

  // String get namaCaleg => _namaCaleg.value;
  // set namaCaleg(String newData){
  //   _namaCaleg.value = newData;
  // }

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxInt _countTim = 0.obs;
  final RxString _nmCaleg = ''.obs;
  final RxList<Caleg> _list = <Caleg>[].obs;
  final RxList<Caleg> _listAll = <Caleg>[].obs;
  final RxList<DataTim> _listTim = <DataTim>[].obs;
  final RxList<DataDashboard> _dataDashboard = <DataDashboard>[].obs;

  List<Caleg> get list => _list.value;
  List<Caleg> get listAll => _listAll.value;
  List<DataTim> get listTim=> _listTim.value;
  List<DataDashboard> get dataDashboard=> _dataDashboard.value;
  int get countTims => _countTim.value;
  String get nmCaleg => _nmCaleg.value;

  setCountTim() async {
    _countTim.value = await SourceCaleg.getCountOfTim();
  }

  setDataDashboard() async {
    _dataDashboard.value = await SourceCaleg.getDataDashboard();
    Future.delayed(const Duration(seconds: 1), () {
    });
  }

  setList() async {
    loading = true;
    _list.value = await SourceCaleg.gets();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  setListAll(abc) async {
    loading = true;    
    // _listAll.value = await SourceCaleg.getsAll("05",'11050306010005');
    _listAll.value = await SourceCaleg.getCaleg("05",abc);
    // _listAll.value = await SourceCaleg.getsAll();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  setListTim(kelompok) async {
    loading = true;
    _listTim.value = await SourceCaleg.getDataTim(kelompok);
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  Future<bool> getDataDashboard() async {

    String url = '${Api.dashboard}/getDataDashboard.php';
    String? responseBody = await AppRequest.gets2(url, {});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {

        Map<String, dynamic> dashboardMap = result['data'];
        DataDashboard calegDashboard = DataDashboard.fromJson(dashboardMap);
       
        namaAplikasi.value = calegDashboard.namaAplikasi.toString();
        judulUtama.value = calegDashboard.judulUtama.toString();
        judulProfil.value = calegDashboard.judulProfil.toString();
        motoProfil.value = calegDashboard.motoProfil.toString();
        namaCaleg.value = calegDashboard.namaCaleg.toString();
        namaPartai.value = calegDashboard.namaPartai.toString();
        targetSuara.value = calegDashboard.targetSuara.toString();
        rating.value = calegDashboard.rating.toString();
        appStr.value = calegDashboard.app.toString();
          
        if (calegDashboard.image.toString().isNotEmpty) {
              fileImageName.value = calegDashboard.image.toString();
              imgNetwork.value = '${Api.rootImagesUrl}/${fileImageName.value}';  
        } else{
              imgNetwork.value = 'BASE_URL_IMAGES_ROOT/tim/default.png'; 
        }

        DMethod.printTitle('Show Dashboard', 'Dashboard Ok');

      } else {
        DMethod.printTitle('Show Dashboard', 'Dashboard failed');
      }
      return result['success'];
    }

    return false;
  }
  
    
 
  void getStringSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    level = prefs.get('level').toString();
    userName = prefs.get('userName').toString();
  }

  @override
  void onInit() {
    //setList();
    //setListAll();
    getDataDashboard();
    setCountTim();
    setDataDashboard();
    getStringSF();
    super.onInit();
  }
}
