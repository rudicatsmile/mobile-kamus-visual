import 'package:get/get.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../data/model/caleg.dart';
import '../../../data/model/data_tim.dart';
import '../../controller/c_caleg.dart';
import '../../find_dtks.dart';


class CardProfileInformationWidget extends StatelessWidget {
  CardProfileInformationWidget({
    key,
  }) : super(key: key);

  final cFeatured = Get.put(CFeatured());

  openRekapitulasi(kdTps) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        "Data Peserta Seluruh Daerah",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      //  list(),
                      //==================
                      Obx(() {
                        cFeatured.setListAll(kdTps);
                        // if (cFeatured.loading) return DView.loadingCircle();
                        if (cFeatured.listAll.isEmpty)
                          return DView.empty("Belum ada data");

                        return Container(
                          height: 500.0, // Change as per your requirement
                          width: 300.0, //
                          child: ListView.separated(
                            itemCount: cFeatured.listAll.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              Caleg caleg = cFeatured.listAll[index];
                              return ListTile(
                                // leading: Text((index + 1).toString()),
                                leading: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 0, // space between two icons
                                  children: <Widget>[
                                    Text((index + 1).toString()), 
                                    // CircleAvatar(
                                    //   radius: 40,
                                    //   backgroundColor: Colors.transparent,
                                    //   child: InstaImageViewer(
                                    //     child: Image(
                                    //         width: 50,
                                    //         height: 60,
                                    //         fit: BoxFit.fill,
                                    //         image: caleg.photo == ''
                                    //             ? Image.network(
                                    //                     'BASE_URL_IMAGES_ROOT/tim/caleg/default.png')
                                    //                 .image
                                    //             : Image.network(
                                    //                     'BASE_URL_IMAGES_ROOT/tim/caleg/${caleg.photo}')
                                    //                 .image),
                                    //   ),
                                    // ),
                                  ],
                                ),

                                title: Text(caleg.nama ?? ' - '),
                                subtitle: Text(
                                  "Jumlah Peserta : ${caleg.suaraSah}\n",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      //==================
                      const SizedBox(height: 10),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                'Tutup',
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                backgroundColor:
                                    const Color.fromARGB(184, 4, 16, 80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.pop(context);
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getDataTim() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        "Data Tim Pemenangan",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      //  list(),
                      //==================
                      Obx(() {
                        cFeatured.setListTim('all');
                        // if (cFeatured.loading) return DView.loadingCircle();
                        if (cFeatured.listTim.isEmpty)
                          return DView.empty("Belum ada data");

                        return Container(
                          height: 500.0, // Change as per your requirement
                          width: 300.0, //
                          child: ListView.separated(
                            itemCount: cFeatured.listTim.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              DataTim tim = cFeatured.listTim[index];
                              return ListTile(
                                leading: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 0, // space between two icons
                                  children: <Widget>[
                                    Text((index + 1).toString()), // icon-1
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      child: InstaImageViewer(
                                        child: Image(
                                            width: 50,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            image: tim.fileName == ''
                                                ? Image.network(
                                                        'BASE_URL_IMAGES_ROOT/tim/default.png')
                                                    .image
                                                : Image.network(
                                                        'BASE_URL_IMAGES_ROOT/tim/${tim.fileName}')
                                                    .image),
                                      ),
                                    ),
                                  ],
                                ),

                                // Text((index+1).toString()),
                                title: Text(tim.nama ?? ' - '),
                                // subtitle: Text("${tim.kelompok}"  ,
                                //   style: const TextStyle(color: Colors.blue),
                                // ),
                                subtitle: Text(
                                  "${tim.kelompok}\n${tim.jabatan}",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      //==================
                      const SizedBox(height: 10),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                backgroundColor:
                                    const Color.fromARGB(184, 4, 16, 80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.pop(context);
                                Get.back();
                              },
                              child: const Text('Tutup'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      height: 250,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset.fromDirection(45))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            child: Row(
              children: [
                Obx(() {
                  return Container(
                    width: 135,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(cFeatured.imgNetwork.value)
                        ),
                        borderRadius: BorderRadius.circular(15)),
                  );
                }),
                Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return Text(cFeatured.namaCaleg.value,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ));
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() {
                                  return Text(
                                    cFeatured.judulProfil.value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8)),
                              height: 60,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Obx(() {
                                    return InformationRating(
                                      subTitle: "Peserta",
                                      value: cFeatured.countTims.toString(),
                                      onTap2: () {
                                        getDataTim();
                                      },
                                    );
                                  }),
                                  Obx(() {
                                    return InformationRating(
                                      subTitle: "Target",
                                      value: cFeatured.targetSuara.value,
                                      onTap2: () {},
                                    );
                                  }),
                                  // Obx(() {
                                  //   return InformationRating(
                                  //     subTitle: "Rating",
                                  //     value: cFeatured.rating.value,
                                  //     onTap2: () {},
                                  //   );
                                  // }),
                                ],
                              ),
                            )
                          ],
                        )))
              ],
            ),
          ),
          Expanded(
            child: Container(
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 22, 20, 102)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.grey)))),
                        onPressed: () {
                          openRekapitulasi('all');
                        },
                        child: const Text(
                          "Rekapitulasi",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const FindDtksPage());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.red)))),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Cek Peserta",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class InformationRating extends StatelessWidget {
  const InformationRating({
    key,
    required this.subTitle,
    required this.value,
    required this.onTap2,
  }) : super(key: key);

  final String subTitle;
  final String value;
  final Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap2,
          child: Text(
            subTitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 12),
          ),
        ),
        GestureDetector(
          onTap: onTap2,
          child: Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
