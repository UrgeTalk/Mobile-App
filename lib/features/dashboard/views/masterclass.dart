import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/dashboard/controller/dashboard_controller.dart';
import 'package:urge/features/dashboard/model/master_class_model.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/features/home/views/home_details.dart';

class MasterClass extends StatefulWidget {
  const MasterClass({super.key});

  @override
  State<MasterClass> createState() => _MasterClassState();
}

class _MasterClassState extends State<MasterClass> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  void initState() {
    _dashboardController.getMasterClass();
    _dashboardController.newMasterClassList.value =
        _dashboardController.masterClassList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Masterclass',
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: appBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (_dashboardController.isListLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_dashboardController.errorMessage.isNotEmpty) {
                    return const Center(child: Text('An Error Occurred'));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            _dashboardController.newMasterClassList.length,
                        itemBuilder: ((context, index) {
                          MasterClassModel _model =
                              _dashboardController.newMasterClassList[index];
                          return classList(_model);
                        }));
                  }
                }),
              ),
            ],
          )),
    );
  }

  Widget classList(MasterClassModel _model) {
    return GestureDetector(
      onTap: () {
       // Get.to(() => HomeDetails(model: _model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(_model.coverImage! ?? ""),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _model.title! ?? "",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _model.speaker!.fullName ?? "",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        getStrDate(DateTime.parse(_model.date!),
                                pattern: "yyyy-MM-dd") ??
                            '',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
