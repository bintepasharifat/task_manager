
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/network_caller.dart';
import '../data/urls.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final response = await NetworkCaller().postRequest(Urls.loginUrl, {
      "email": email,
      "password": password,
    });
    isLoading.value = false;
    if (response['status'] == 'success') {
      user.value = UserModel.fromJson(response['data']);
      Get.offAllNamed('/taskList');
    } else {
      Get.snackbar('Login Failed', 'Invalid credentials');
    }
  }
}
