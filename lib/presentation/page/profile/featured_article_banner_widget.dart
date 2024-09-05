import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/c_caleg.dart';
import '../../controller/c_user.dart';
import '../apotek/list_merchant_page.dart';

class FeaturedArticleBannerWidget extends StatelessWidget {
  FeaturedArticleBannerWidget({
    key,
  }) : super(key: key);

  final cFeatured = Get.put(CFeatured());
  final cUser = Get.put(CUser());

  final controllerApotek = TextEditingController();
  final controllerWarung = TextEditingController();
  final controllerResep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 250,
      decoration: BoxDecoration(
          color: const Color.fromARGB(97, 172, 169, 169),
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image home
          // Container(
          //     padding: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //         color: Colors.teal[800],
          //         borderRadius: BorderRadius.circular(10)),
          //     child: const Icon(
          //       Icons.home,
          //       color: Colors.blue,
          //       size: 36.0,
          //     )),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Column(
              children: [                
                Row(
                  children: [
                     Expanded(
                      child: 
                          TextField(
                            controller: controllerApotek,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Cari Apotek",
                                prefixIcon: Icon(Icons.search)),
                            style: const TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      // onPressed: () => Get.to(() => ListMerchantPage(
                      //                                     kriteria: 'apotek', 
                      //                                     nik: cUser.data.userId, 
                      //                                     kdkecamatan: cUser.data.kdKec,
                      //                                     dataSearch: controllerApotek.text
                      //                                     )),
                       onPressed: () {
                        
                          if(controllerApotek.text.length < 3 ){
                              DInfo.dialogError(context, "Silahkan di isi lebih dari 3 karakter");
                              DInfo.closeDialog(context,durationBeforeClose: const Duration(seconds: 3));
                          }else{
                              Get.to(() => ListMerchantPage(
                                                          kriteria: 'apotek', 
                                                          nik: cUser.data.userId, 
                                                          kdkecamatan: cUser.data.kdKec,
                                                          dataSearch: controllerApotek.text
                                                          ));
                          }

                       },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[200]),
                      child: const Text('Search'),
                    )
                  ],
                ),
                DView.spaceHeight(),
                Row(
                  children: [
                     Expanded(
                      child: 
                         TextField(
                            controller: controllerWarung,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Cari E-Warung",
                                prefixIcon: Icon(Icons.search)),
                            style: const TextStyle(fontSize: 15,color: Colors.black),
                          ),
                      
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                     
                      onPressed: () {                        
                          if(controllerWarung.text.length < 3 ){
                              DInfo.dialogError(context, "Silahkan di isi lebih dari 3 karakter");
                              DInfo.closeDialog(context,durationBeforeClose: const Duration(seconds: 3));
                          }else{
                              Get.to(() => ListMerchantPage(
                                                      kriteria: 'warung', 
                                                      nik: cUser.data.userId, 
                                                      kdkecamatan: cUser.data.kdKec,
                                                      dataSearch: controllerApotek.text
                                                      ));
                          }
                       },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
                      child: const Text('Search'),
                    )
                  ],
                ),
                DView.spaceHeight(),

                Row(
                  children: [
                    Expanded(
                      child: 
                         TextField(
                            controller: controllerResep,
                            decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Cari E-Resep",
                            prefixIcon: Icon(Icons.search)),
                        style: const TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {                        
                          if(controllerResep.text.length < 3 ){
                              DInfo.dialogError(context, "Silahkan di isi lebih dari 3 karakter");
                              DInfo.closeDialog(context,durationBeforeClose: const Duration(seconds: 3));
                          }else{
                              Get.to(() => ListMerchantPage(
                                                      kriteria: 'resesp', 
                                                      nik: cUser.data.userId, 
                                                      kdkecamatan: cUser.data.kdKec,
                                                      dataSearch: controllerApotek.text
                                                      ));
                          }
                       },
                      
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Search'),
                    )
                  ],
                ),
                
              ],
            ),            
          )
        ],
      ),
    );
  }
}
