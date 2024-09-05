import 'dart:convert';
import 'package:get/get.dart';

import '../../data/source/source_inout.dart';

class CAddInOut extends GetxController {
  final RxDouble _totalPrice = 0.0.obs;
  double get totalPrice => _totalPrice.value;

  final RxList<Map> _list = <Map>[].obs;
  List<Map> get list => _list.value;
  add(newData) async {
    _list.value.add(newData);
    double quantity = double.parse(newData['quantity'].toString());
    double price = double.parse(newData['price'].toString());
    _totalPrice.value += quantity * price;
    update();
  }

  delete(Map data) {
    _list.value.remove(data);
    double quantity = double.parse(data['quantity'].toString());
    double price = double.parse(data['price'].toString());
    _totalPrice.value -= quantity * price;
    update();
  }

  addInOut(String type) async {
    List<Map<String, dynamic>> listCast = List.castFrom(list);
    bool success = await SourceInOut.add(
      listProduct: jsonEncode(listCast),
      type: type,
      totalPrice: totalPrice.toStringAsFixed(2),
    );
    // if (success) {
    //   DMethod.printTitle('addinout', 'success');
    //   DInfo.dialogSuccess('Success Add $type');
    //   DInfo.closeDialog(actionAfterClose: () {
    //     DMethod.printTitle('addinout', 'close dialog');
    //     Get.back(result: true);
    //   });
    // } else {
    //   DInfo.dialogError('Failed Add $type');
    //   DInfo.closeDialog();
    // }
  }
}
