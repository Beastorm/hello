import 'package:Milto/models/follow_model.dart';
import 'package:Milto/repos/follow_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FollowController extends GetxController {
  var isFollow = true.obs;
  var isFollowing = true.obs;
  List<bool> selections = List.generate(1, (_) => false).obs;
  var followStr = 'Follow'.obs;
  var isLoading = true.obs;
  final pref = GetStorage();

  final box = GetStorage();
  var followerList = List<FollowData>().obs;

  @override
  void onInit() async {
    super.onInit();
    //requestForfollwerList();
  }


}
