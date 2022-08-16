import 'package:finews_module/pages/home/main_provider.dart';
import 'package:get/get.dart';

import '../../configs/constants.dart';
import '../../configs/service_api_config.dart';
import '../networking/api.dart';
import '../networking/result.dart';
 

class ApiServices {
  String get backendUrl => "";

  // final String tokenTest ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJleHAiOjE2NDY4MTg1NDYsInVzZXJJZCI6NDAxLCJ1dWlkIjoiYTgxNzcxNTItNjc0NS00YjAxLWFjZTgtODhmZGQ2MWNiZWM0IiwidXNlcm5hbWUiOiIwOTczNTkxNzI4In0.klOVLqsTWTLqtY0-eG_bw1coVu1Te3tpkTHHtHZDeDSk8B9yjluBUKBVIGMS4P-K9tGJWjhio-eXlSVZ_l_tut1LwMtZ36wVenAWAe0UPWz969Ge2psit7EtOtz-oa5cIf-KC_UY5OTrfKHSLKSJhC_HLnfSpBTa-xbpHS-iqRw78tJrQwHotpva5NLx0nz1cJjjkvq-e16rYGa-54INojtQfu7xzPMdlPdh6Gaoz3k6E33uGJFRrp0VUHjsgPW1NF9ux1Q8rLL4rij3D2-XAoQY1hK-pXjG6yNt-mx_lzZdJDxBz_jdlSSMBwKvMnp0foQnMLK4VzS0NIBoJJFObVYRlvyx85HVnghB3PgpRQAgGPL7Vlo9uOFcNYbTJ32X9-HtHOiLyD8yxIypzoiDtoxXaTfhylLS6Xjv9Z7HmExAdkEDO8fKa0A4NEk3UHRcO8hgl5Fz-nIoZiLiuSw3g514sgbxIXZXko8v9RRfQLdZ8Zp6-Y79tiCidrFCP8cqev2kAoquriOShNAVSFpepC_zULwfcWpZ0NEFXrDKFz_PJbUG_c13Razgrlu8kaY5ycqgVh8AkzpYmsbce39fGjUjKpjZFWpNgqxLRraVtfx-uFh-7U4yFuFAxo3697il0I6OUD5DLQ72HrOVIOwsL-a0d8dQiwQ_SFxwQy9S9hw";

  ApiServices({String? external = null}) {
    if (external == null) {
      final MainFiNewsProvider mainProvider = Get.find<MainFiNewsProvider>();
      api = Api(
          backendUrl: Environment().backendUrl,
          fullToken: mainProvider.accessToken ?? "",
          userId: mainProvider.userId?.toString() ?? "");
      api.onInit();
    } else {
      api = Api(
          backendUrl: external,
          fullToken:  "",
          userId:"");
    }

    //api = Api(backendUrl: Environment().backendUrl, fullToken: tokenTest);
  }



  late Api api;

  Future<Result> getData({
    required String endPoint,
    Map<String, dynamic>? params,
    Duration timeOut = AppConstants.TIME_OUT,
  }) async {
    return api.getData(endPoint: endPoint, params: params, timeOut: timeOut);
  }

  Future<Result> postData({
    required String endPoint,
    dynamic params,
    Duration timeOut = AppConstants.TIME_OUT,
  }) async {
    return api.postData(endPoint: endPoint, params: params, timeOut: timeOut);
  }

  Future<Result> deleteData({
    required String endPoint,
    Map<String, dynamic>? params,
    Duration timeOut = AppConstants.TIME_OUT,
  }) async {
    return api.deleteData(endPoint: endPoint, params: params, timeOut: timeOut);
  }
}
