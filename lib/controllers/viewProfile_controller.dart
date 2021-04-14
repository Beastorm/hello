import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hello/models/ViewProfileModel.dart';
import 'package:hello/repos/viewProfile_repo.dart';

class ChapterController extends GetxController {
  var isLoading = true.obs;
  // var profileList = List<DataProfile>();

  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void fetchProfile(String userId) async {
    try {
      isLoading(true);
      var response = await viewProfile(userId);
      print('profilecontroller userid $userId');
      // if(response ){
      //   // profileList.assignAll(profile);
      // }

    } finally {
      isLoading(false);
    }
  }
}