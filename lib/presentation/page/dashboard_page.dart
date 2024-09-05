import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_color.dart';

import '../../config/session.dart';
import '../controller/c_dashboard.dart';
import '../controller/c_user.dart';
import 'employee/employee_page.dart';
import 'history/history_page.dart';
import 'login_page.dart';
import 'peserta/peserta_page.dart';
import 'peserta_dtks/peserta_dtks_page.dart';
import 'product/product_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());
  final cDashboard = Get.put(CDashboard());

  logout() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure to logout?',
    );
    DMethod.printTitle('cedk', yes.toString());

    if (yes == true) {
      Session.clearUser();
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aplikasi A-Apotek"),
          // actions: [
          //   IconButton(onPressed: () => logout(), icon: const Icon(Icons.logout))
          // ]
        ),
        body: ListView(
          children: [
            profileCard(textTheme),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DView.textTitle('Menu'),
            ),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 110,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                //menuProduct(textTheme),
                //menuHistory(textTheme),
                //menuIn(textTheme),
                //menuOut(textTheme),

                //menuUser(textTheme),

                // Obx(() {
                //   if (cUser.data.adminUser == 'Y') {
                //     return menuUser(textTheme);
                //   } else {
                //     return const SizedBox();
                //   }
                // }),
                menuUser(textTheme),

                // Obx(() {
                //   if (cUser.data.adminPeserta == 'Y') {
                //     return menuPeserta(textTheme);
                //   } else {
                //     return const SizedBox();
                //   }
                // }),
                menuPeserta(textTheme),

                //Validator => ta_biodata.status_pengajuan = aktif
                // Obx(() {
                //   if (cUser.data.admType == 'Y') {
                //     return menuPengajuan(textTheme);
                //   } else {
                //     return const SizedBox();
                //   }
                // }),
                menuPengajuan(textTheme),

                //Surveyor => ta_biodata.status_pengajuan = aktif akan dimasukan ke tabel ta_dtks
                // Obx(() {
                //   if (cUser.data.surveyor == 'Y' ) {
                //     return menuSurveyor(textTheme);
                //   } else {
                //     return const SizedBox();
                //   }
                // }),

                menuSurveyor(textTheme),

                // Obx(() {
                //   if (cUser.data.verifikator == 'Y') {
                //     return menuVerifikator(textTheme);
                //   } else {
                //     return const SizedBox();
                //   }
                // }),
                menuVerifikator(textTheme),
              ],
            )
          ],
        ));
  }

  Widget menuProduct(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductPage())
            ?.then((value) => cDashboard.setProduct());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.product.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuHistory(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HistoryPage())
            ?.then((value) => cDashboard.setHistory());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.history.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Act',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget menuIn(TextTheme textTheme) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => const InOutPage(type: 'IN'))?.then((value) {
  //         cDashboard.setIn();
  //         cDashboard.setHistory();
  //       });
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: AppColor.input,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'IN',
  //             style: textTheme.titleLarge,
  //           ),
  //           Row(
  //             children: [
  //               Obx(() {
  //                 return Text(
  //                   cDashboard.ins.toString(),
  //                   style: textTheme.headline4!.copyWith(
  //                     color: Colors.white,
  //                   ),
  //                 );
  //               }),
  //               DView.spaceWidth(8),
  //               const Text(
  //                 'Item',
  //                 style: TextStyle(
  //                   color: Colors.white54,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget menuOut(TextTheme textTheme) {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => const InOutPage(type: 'OUT'))?.then((value) {
  //         cDashboard.setOut();
  //         cDashboard.setHistory();
  //       });
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: AppColor.input,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'OUT',
  //             style: textTheme.titleLarge,
  //           ),
  //           Row(
  //             children: [
  //               Obx(() {
  //                 return Text(
  //                   cDashboard.outs.toString(),
  //                   style: textTheme.headline4!.copyWith(
  //                     color: Colors.white,
  //                   ),
  //                 );
  //               }),
  //               DView.spaceWidth(8),
  //               const Text(
  //                 'Item',
  //                 style: TextStyle(
  //                   color: Colors.white54,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget menuUser(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => const EmployeePage())?.then((value) {
        //   cDashboard.setEmployee();
        // });
        cUser.data.admType == 'Y'
            ? Get.to(() => const EmployeePage())
                ?.then((value) {
                cDashboard.setPesertaDtks();
              })
            : 
            Get.dialog(
                AlertDialog(
                  title: const Text('Perhatian'),
                  content: const Text('Tidak ada Hak akses'),
                  actions: [
                    TextButton(
                      child: const Text("Tutup"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              );
            
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User',              
              style: 
              cUser.data.admType == 'Y'? textTheme.titleLarge : const TextStyle(color: Colors.red, fontSize: 25)                            
            ),
            Obx(() {
              return Text(
                cDashboard.employee.toString(),
                style: textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Container profileCard(TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text(
              cUser.data.nama ?? '',
              style: textTheme.titleMedium,
            );
          }),
          // DView.spaceHeight(4),
          // Obx(() {
          //   return Text(
          //     cUser.data.email ?? '',
          //     style: textTheme.bodyMedium,
          //   );
          // }),
          DView.spaceHeight(8),
          Obx(() {
            return Text(
              '(${cUser.data.admType})',
              style: textTheme.caption,
            );
          }),
        ],
      ),
    );
  }

  Widget menuPeserta(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => PesertaPage(kriteria: ''))?.then((value) {
        //   cDashboard.setPeserta();
        // });

        cUser.data.admType == 'Y'
            ? Get.to(() => const PesertaPage(kriteria: ''))
                ?.then((value) {
                cDashboard.setPesertaDtks();
              })
            : 
            Get.dialog(
                AlertDialog(
                  title: const Text('Perhatian'),
                  content: const Text('Tidak ada Hak akses'),
                  actions: [
                    TextButton(
                      child: const Text("Tutup"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              );
            ;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DTKS',
              style: 
                cUser.data.admType == 'Y'? textTheme.titleMedium : const TextStyle(color: Colors.red, fontSize: 25)  
            ),
            Obx(() {
              return Text(
                cDashboard.peserta.toString(),
                style: textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget menuPengajuan(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => PesertaPage(kriteria: 'pengajuan'))?.then((value) {
        //   cDashboard.setPeserta();
        // });
        cUser.data.admType == 'Y'
            ? Get.to(() => const PesertaPage(kriteria: 'pengajuan'))
                ?.then((value) {
                cDashboard.setPesertaDtks();
              })
            : 
            Get.dialog(
                AlertDialog(
                  title: const Text('Perhatian'),
                  content: const Text('Tidak ada Hak akses'),
                  actions: [
                    TextButton(
                      child: const Text("Tutup"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              );
            ;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengajuan DTKS',
              style: 
                cUser.data.admType == 'Y'? textTheme.titleMedium : const TextStyle(color: Colors.red, fontSize: 15)
            ),
            Obx(() {
              return Text(
                cDashboard.peserta.toString(),
                style: textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget menuDtks(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PesertDtks(kriteria: '', nikSurveyor: cUser.data.userId, kdkelurahan: cUser.data.idApotek,))?.then((value) {
          cDashboard.setPesertaDtks();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DTKS',
              style: textTheme.titleLarge,
            ),
            Obx(() {
              return Text(
                cDashboard.pesertaDtks.toString(),
                style: textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget menuSurveyor(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => PesertDtks(kriteria: 'surveyor'))?.then((value) {
        //   cDashboard.setPesertaDtks();
        // });

        cUser.data.admType == 'Y'
            //1*
            ? Get.to(() => PesertDtks(kriteria: 'surveyor', nikSurveyor: cUser.data.userId, kdkelurahan: cUser.data.idApotek))
                ?.then((value) {
                cDashboard.setPesertaDtks();
              })
            : 
            Get.dialog(
                AlertDialog(
                  title: const Text('Perhatian'),
                  content: const Text('Tidak ada Hak akses'),
                  actions: [
                    TextButton(
                      child: const Text("Tutup"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              );
            ;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SURVEYOR',
              style: 
                cUser.data.admType == 'Y'? textTheme.titleMedium : const TextStyle(color: Colors.red, fontSize: 18)
            ),
            Obx(() {
              return Text(
                cDashboard.pesertaDtks.toString(),
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget menuVerifikator(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        cUser.data == 'Y'
            //1*
            ? Get.to(() => PesertDtks(kriteria: 'verifikator', nikSurveyor: cUser.data.userId, kdkelurahan: cUser.data.idApotek))
                ?.then((value) {
                cDashboard.setPesertaDtks();
              })
            :
            // Get.defaultDialog(title: "Perhatian ",middleText: 'Tidak ada Hak akses',textConfirm: 'OK')
            Get.dialog(
                AlertDialog(
                  title: const Text('Perhatian'),
                  content: const Text('Tidak ada Hak akses'),
                  actions: [
                    TextButton(
                      child: const Text("Tutup"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              );

        ;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PENGESAHAN',
              style: 
              cUser.data.admType == 'Y'? textTheme.titleMedium : const TextStyle(color: Colors.red, fontSize: 18),
            ),
            Obx(() {
              return Text(
                cDashboard.pesertaDtksValid.toString(),
                style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
