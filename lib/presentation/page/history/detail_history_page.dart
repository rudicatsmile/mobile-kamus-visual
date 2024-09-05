import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../config/app_format.dart';
import '../../../data/source/source_history.dart';
import '../../controller/c_detail_history.dart';
import '../../controller/c_user.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({Key? key, required this.idHistory})
      : super(key: key);
  final String idHistory;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());
  final cUser = Get.put(CUser());

  delete() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Delete History', 'You sure to delete history?');
    if (yes == true) {
      bool success = await SourceHistory.deleteWhereId(widget.idHistory);
      if (success) {
        DInfo.dialogSuccess(context, 'Success Delete History');
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError(context, 'Failed Delete History');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  @override
  void initState() {
    cDetailHistory.setData(widget.idHistory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() {
          if (cDetailHistory.data.idHistory == null) return const Text('');
          return Text(
            AppFormat.date(cDetailHistory.data.createdAt!),
          );
        }),
        actions: [
          Obx(() {
            if (cDetailHistory.data.type == null) return const SizedBox();
            return cDetailHistory.data.type == 'IN'
                ? const Icon(Icons.south_west, color: Colors.green)
                : const Icon(Icons.north_east, color: Colors.red);
          }),
          DView.spaceWidth(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          if (cUser.data.admType == '1') {
            delete();
          } else {
            DInfo.toastError('You are have no access');
          }
        },
        child: const Icon(Icons.delete),
      ),
      body: ListView(
        children: [
          GetBuilder<CDetailHistory>(builder: (_) {
            if (cDetailHistory.data.idHistory == null) return DView.empty();
            List listProduct = jsonDecode(cDetailHistory.data.listProduct!);
            if (listProduct.isEmpty) return DView.empty();
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listProduct.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  color: Colors.white60,
                  indent: 16,
                  endIndent: 16,
                );
              },
              itemBuilder: (context, index) {
                Map product = listProduct[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    0,
                    index == 9 ? 16 : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Text('${index + 1}'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DView.spaceHeight(4),
                            Text(
                              product['code'],
                              style: textTheme.subtitle2!.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            DView.spaceHeight(16),
                            Text(
                              'Rp ${AppFormat.currency(product['price'] ?? '0')}',
                              style: textTheme.subtitle1!.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              product['quantity'],
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          DView.spaceHeight(4),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              product['unit'],
                              style: textTheme.subtitle2!.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          DView.spaceHeight(30),
          Center(
            child: Text(
              'Total:',
              style: textTheme.headline5,
            ),
          ),
          Center(
            child: Obx(() {
              return Text(
                'Rp ${AppFormat.currency(cDetailHistory.data.totalPrice ?? '0')}',
                style: textTheme.headline3!.copyWith(
                  color: Colors.green,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
