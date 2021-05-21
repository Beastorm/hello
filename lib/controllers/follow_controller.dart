

import 'package:Milto/repos/follow_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FollowController extends GetxController{
  var isFollow = true.obs;
  var isFollowing = true.obs;
  List<bool> selections = List.generate(1, (_) => false).obs;
  var followStr = 'Follow'.obs;

  final box = GetStorage();

  followUser(String userId, String followerId){
    var response = follow(userId, followerId);

    // ignore: unrelated_type_equality_checks
    if(response == true){
      print('response follow user $response');
    }
  }
}