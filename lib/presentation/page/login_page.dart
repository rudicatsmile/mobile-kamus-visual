import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eapotek/presentation/profile_page.dart';

import '../../config/app_color.dart';
import '../../data/source/source_user.dart';
import '../controller/c_user.dart';
import '../find_dtks.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();
  final cUser = Get.put(CUser());

  void login() async {
    bool success = await SourceUser.login(
      controllerUser.text,
      controllerPassword.text,
    );
    if (success) {
      //DInfo.dialogSuccess(context, 'Login Success');
      // DInfo.closeDialog(context, actionAfterClose: () {
      //   DMethod.printTitle('Level User', cUser.data.level ?? '');
      //   if (cUser.data.level == 'Employee' &&
      //       controllerPassword.text == '123456') {
      //     //changePassword();
      //     Get.off(() => const DashboardPage());
      //   } else {
      //     Get.off(() => const DashboardPage());
      //   }
      // });
      // Get.off(() => const DashboardPage());
      //DInfo.closeDialog(context,);
      //  Get.off(() => const DashboardPage());
      Get.off(() => ProfilePage());
    } else {
      DInfo.dialogError(context, 'Login failed');
      DInfo.closeDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text(
                        'Visual Dictionary',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      DView.spaceHeight(8),
                      Container(
                        height: 6,
                        width: 160,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      input(controllerUser, Icons.account_box, 'User ID'),
                      DView.spaceHeight(),
                      input(controllerPassword, Icons.vpn_key, 'Password', true),
                      DView.spaceHeight(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => login(),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DView.spaceHeight(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(const FindDtksPage());
                          },
                          child: const Text(
                            'Cek Peserta',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget input(
    TextEditingController controller,
    IconData icon,
    String hint, [
    bool obsecure = false,
  ]) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColor.input,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        prefixIcon: Icon(icon, color: AppColor.primary),
        hintText: hint,
      ),
      obscureText: obsecure,
    );
  }
}
