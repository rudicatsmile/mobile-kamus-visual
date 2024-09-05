import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/user.dart';
import '../../../data/source/source_user.dart';
import '../../controller/c_employee.dart';
import 'add_employee_page.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final cEmployee = Get.put(CEmployee());

  delete(String idUser) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Delete User', 'Yes to confirm');
    if (yes != null) {
      bool success = await SourceUser.delete(idUser);
      if (success) {
        DInfo.dialogSuccess(context, 'Success Delete User');
        DInfo.closeDialog(
          context,
          actionAfterClose: () => cEmployee.setList(),
        );
      } else {
        DInfo.dialogError(context, 'Failed Delete User');
        DInfo.closeDialog(
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Data User'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddEmployeePage())?.then((value) {
                if (value ?? false) {
                  cEmployee.setList();
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetBuilder<CEmployee>(builder: (_) {
        if (cEmployee.loading) return DView.loadingCircle();
        if (cEmployee.list.isEmpty) return DView.empty();
        return ListView.separated(
          itemCount: cEmployee.list.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.white70,
          ),
          itemBuilder: (context, index) {
            User user = cEmployee.list[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 18,
                child: Text('${index + 1}'),
              ),
              title: Text(user.nama ?? ''),
              subtitle: Text(user.userId ?? ''),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    delete(user.idt.toString());
                  }
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
