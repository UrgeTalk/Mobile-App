import 'package:get/get.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/dashboard/services/dashboard_services.dart';
import 'package:urge/features/dashboard/model/master_class_model.dart';

class DashboardController extends GetxController with BaseController {
  final DashboardService _dashboardService = DashboardService();

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var masterClassList = <MasterClassModel>[].obs;
  var newMasterClassList = <MasterClassModel>[].obs;

  void getMasterClass() {
    isListLoading(true);
    _dashboardService.getMasterClass().then((value) {
      print(value['data']);
      try {
        if (value['message'] == "success") {
          var trans = List<MasterClassModel>.from(
              (value['data']).map((x) => MasterClassModel.fromMap(x)));
          masterClassList.value = trans;
          print('Here');
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
}
