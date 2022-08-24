import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/pages/home/home_page_controller.dart';
import 'package:get/get.dart';
// import 'package:trading_module/data/repos/home_trading_repo_imp.dart';
// import 'package:trading_module/data/repos/withdraw_repos_impl.dart';
// import 'package:trading_module/data/services/home_trading_service.dart';
// import 'package:trading_module/data/services/local/LocalStorageServices.dart';
// import 'package:trading_module/data/services/withdraw_service.dart';
// import 'package:trading_module/domain/use_cases/home_trading_usecase.dart';
// import 'package:trading_module/domain/use_cases/open_withdraw_usecase.dart';
// import 'package:trading_module/pages/homePage/controller/home_page_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => OpenWithdrawUseCase(WithdrawRepoImpl(WithdrawServiceImpl())));
    // Get.lazyPut(() => HomeTradingUseCase(HomeTradingRepoImpl(HomeTradingServiceImpl(),LocalStorageServiceImpl())));
    Get.put<NewsService>(NewsServiceImpl());
    Get.lazyPut(() => HomePageController(), tag: "0");
    Get.lazyPut(() => HomePageController(), tag: "1");
    Get.lazyPut(() => HomePageController(), tag: "2");
    Get.lazyPut(() => HomePageController(), tag: "3");
  }
}
