import 'package:get/get.dart';

class Api {
  //static const _baseUrl = 'https://e-apotek.halibar.co.id/api';
  static const _baseImages = 'https://e-apotek.halibar.co.id/images';

  static const _baseUrlApotek = 'https://e-apotek.halibar.co.id/api';
  static const _baseImagesApotek = 'https://e-apotek.halibar.co.id/images';

  static const _baseUrlWarung = 'https://e-warung.halibar.co.id/api';
  static const _baseImagesEwarung = 'https://e-warung.halibar.co.id/images';

  /*  ---- Develop ---------------------
  */
  //static const _baseUrl = 'http://192.168.1.6:81';
  // static const _baseUrl = 'https://e-apotek.halibar.co.id/api';
  static const _baseUrl = 'http://141.11.25.62/api'; //Digitalocean server

  // static const _baseUrl       = 'http://192.168.43.17:81/e_warung/api';
  // static const _baseImages    = 'http://192.168.43.17:81/e_warung/images';
  // static const _baseUrlApotek = 'http://192.168.43.17:81/e_warung/api/';
  // static const _baseUrlWarung = 'http://192.168.43.17:81/e_warung/api/';

  static const user = '$_baseUrl/user';
  static const product = '$_baseUrl/product';
  static const history = '$_baseUrl/history';
  static const inout = '$_baseUrl/inout';
  static const peserta = '$_baseUrl/peserta';
  static const pengajuan = '$_baseUrl/pengajuan';
  static const location = '$_baseUrl/location';
  static const pesertaDtks = '$_baseUrl/pesertaDtks';
  static const imagesDtks = '$_baseImages/dtks';
  static const dashboard = '$_baseUrl/dashboard';
  static const imageAds = '$_baseUrl/dashboard';
  static const rootUrl = _baseUrl;
  static const rootImagesUrl = _baseImages;

  static const caleg = '$_baseUrl/caleg';
  static const tampil = 'tampil.php';
  static const retrieveTps = 'retrieveTps.php';
  static const getdatadashboard = 'getDataDashboard.php';
  static const getcountKelurahan = 'get_count_kelurahan.php';
  static const countOfTim = 'count_of_tim.php';
  static const getdatatim = 'getDataTim.php';
  static const getsAll = 'getAll.php';

  //Apotek
  // static const pesertaDtks = '$_baseUrl/pesertaDtks';
  static const getApotekLocation = '$_baseUrlApotek/general';
  static const rootImagesUrlApotik = _baseImagesApotek;

  //Warung
  static const getWarungLocation = '$_baseUrlWarung/general';
  static const rootImagesUrlWarung = _baseImagesEwarung;

  //Kamus
  static final apiName = "apiName".tr;

  // static const kamus = '$_baseUrl/kamus';
  // static const imagesKamus = '$_baseUrl/kamus/images';

  static final kamus = '$_baseUrl/$apiName';
  static final imagesKamus = '$_baseUrl/$apiName/images';

  static const add = 'add.php';
  static const update = 'update.php';
  static const delete = 'delete.php';
  static const gets = 'get.php';
  static const search = 'search.php';
  static const count = 'count.php';
  static const register = 'register.php';
  static const getsWithPage = 'getWithPage.php';
}
