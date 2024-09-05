import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/api.dart';
import '../../../data/model/caleg.dart';
import '../../controller/c_caleg.dart';


class DiscoverListItemWidget extends StatefulWidget {
  final int index;
  DiscoverListItemWidget(this.index) ;

  @override
  State<DiscoverListItemWidget> createState() => _DiscoverListItemWidgetState();
}

class _DiscoverListItemWidgetState extends State<DiscoverListItemWidget> {
  final cFeatured = Get.put(CFeatured());

  List<String> kecamatanImg = ["pahandut", "bukit-batu", "jekan-raya", "jekan-raya", "rakumpit",""];

  List<String> kecamatanStr = ["Kecamatan Pahandut", "Kecamatan Bukit Batu",  "Kecamatan Jekan Raya", "Kecamatan Sabangau", "Kecamatan Rakumpit",""];

  List<String> kecamatanKdTps = ["62.71.01", "62.71.02", "62.71.03", "62.71.04", "62.71.05",""];

  openPopup(String kdTps, String namakecamatan){
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
                     Text(
                      "Data  $namakecamatan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),                      
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    //  list(),
                    //==================
                    Obx(() {
                        cFeatured.setListAll(kdTps);
                        // if (cFeatured.loading) return DView.loadingCircle();
                        if (cFeatured.listAll.isEmpty) return DView.empty("Belum ada data");

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
                                // leading:  Text((index+1).toString()),
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
                                  "Jumlah peserta : ${caleg.suaraSah}"  ,
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
                              backgroundColor:const Color.fromARGB(184, 4, 16, 80) ,
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

  List<String> imagesString = [];

  Future<void> fetchImages() async {
    String url = '${Api.imageAds}/getImageAds.php';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {    
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        //sampleImages = data.map((item) => ImageModel.fromJson(item)).toList();
        imagesString = data.map((item) => item['imageUrl'] as String).toList();
        DMethod.printTitle('CEK URL10:  ', imagesString.toString());
      });
    } else {
      // Tangani error jika ada
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 20),
        width: 200,
        child: GestureDetector(
          onTap: () {
              // openPopup(kecamatanKdTps[widget.index], kecamatanStr[widget.index]) ;            
          },
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                              fit: BoxFit.cover,
                              //image : AssetImage('assets/images/${kecamatanImg[widget.index]}.jpg')
                              image : NetworkImage(imagesString[widget.index])
                              // image: NetworkImage("https://picsum.photos/id/237/200/300")
                            )
                            ),
                  )),
              const SizedBox(
                height: 10,
              ),             
            ],
          ),
        ));
  }
}
