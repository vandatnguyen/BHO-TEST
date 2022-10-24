import 'package:get/get.dart';

import '../controllers/comment_list_controller.dart';

class CommentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentListController>(
      () => CommentListController(),
    );
  }
}
