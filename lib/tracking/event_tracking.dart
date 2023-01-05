import 'dart:developer';

import 'package:finews_module/cores/models/news_detail.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

const SHOW_EVENT_TRACKING_LOG = true;

abstract class EventTracking {
  final String name;
  int? timeStamp;
  Map<String, Object>? params;

  EventTracking({required this.name});

  Map<String, Object> _getParams() {
    final Map<String, Object> p = {
      "current_route": Get.currentRoute,
      "previous_route": Get.previousRoute,
      "time_stamp": timeStamp?.toString() ?? "",
    };
    return p;
  }
}

class EventTrackingReadingNews extends EventTracking {
  EventTrackingReadingNews({required NewsDetailModel model})
      : super(name: 'news_reading_start') {
    setData(model);
  }

  EventTrackingReadingNews setData(NewsDetailModel model) {
    var p = _getParams();
    p.putIfAbsent("articleId", () => model.id);
    p.putIfAbsent("title", () => model.title);
    p.putIfAbsent("source", () => model.source.toString());
    p.putIfAbsent("sourceName", () => model.sourceName!);
    p.putIfAbsent("topic", () => model.topic.toString());
    p.putIfAbsent("topicName", () => model.topicName!);
    params = p;
    return this;
  }
}

class EventTrackingReadingNewsEnd extends EventTracking {
  EventTrackingReadingNewsEnd(
      {required NewsDetailModel model, required int time})
      : super(name: 'news_reading_end') {
    setData(model, time);
  }

  EventTrackingReadingNewsEnd setData(NewsDetailModel model, int time) {
    var p = _getParams();
    p.putIfAbsent("articleId", () => model.id);
    p.putIfAbsent("title", () => model.title);
    p.putIfAbsent("source", () => model.source);
    p.putIfAbsent("sourceName", () => model.sourceName!);
    p.putIfAbsent("topic", () => model.topic);
    p.putIfAbsent("topicName", () => model.topicName!);
    p.putIfAbsent("timeRead", () => time);
    params = p;
    return this;
  }
}

class EventTrackingWidgetAllClickMore extends EventTracking {
  EventTrackingWidgetAllClickMore({required String topicId})
      : super(name: 'news_widget_all_click_more') {
    var p = _getParams();
    p.putIfAbsent("topicId", () => topicId);
    params = p;
  }
}

class EventTrackingHomeClickTab extends EventTracking {
  EventTrackingHomeClickTab({required String topicId})
      : super(name: 'news_home_click_tab') {
    var p = _getParams();
    p.putIfAbsent("topicId", () => topicId);
    params = p;
  }
}

class EventTrackingHomeViewTab extends EventTracking {
  EventTrackingHomeViewTab({required String topicId})
      : super(name: 'news_home_view_tab') {
    var p = _getParams();
    p.putIfAbsent("topicId", () => topicId);
    params = p;
  }
}

class EventTrackingWidgetAllClickTab extends EventTracking {
  EventTrackingWidgetAllClickTab({required String topicId})
      : super(name: 'news_widget_all_click_tab') {
    var p = _getParams();
    p.putIfAbsent("topicId", () => topicId);
    params = p;
  }
}

class EventTrackingOpenModule extends EventTracking {
  EventTrackingOpenModule()
      : super(name: 'news_open_module') {
    var p = _getParams();
    params = p;
  }
}


class EventTrackingCloseModule extends EventTracking {
  EventTrackingCloseModule({required int timeSpent})
      : super(name: 'news_close_module') {
    var p = _getParams();
    p.putIfAbsent("timeSpent", () => timeSpent);
    params = p;
  }
}

class EventTrackingWidgetAllView extends EventTracking {
  EventTrackingWidgetAllView()
      : super(name: 'news_widget_all_view') {
    var p = _getParams();
    params = p;
  }
}

class EventOpenAppTikopForNews extends EventTracking {
  EventOpenAppTikopForNews()
      : super(name: 'news_open_app_tikop') {
    var p = _getParams();
    params = p;
  }
}


class EventManager {
  static FirebaseAnalytics? firebaseAnalytics;
  late DateTime initTime;

  factory EventManager() => _instance ??= EventManager._();
  static EventManager? _instance;

  EventManager._() {
    initTime = DateTime.now();
  }

  Future<void> initEventTracking() async {
    // await Firebase.initializeApp(
    //     name: '[DEFAULT]',
    //     options: const FirebaseOptions(
    //       apiKey: 'AIzaSyBNOe3Lv0Wx4pCwR_QFAAvoWNkPQ_uwtVo',
    //       appId: '1:612267598137:android:1ce913d47ad4cb5d1908e8',
    //       messagingSenderId: '',
    //       projectId: 'r014-fi-news',
    //       storageBucket: 'r014-fi-news.appspot.com',
    //     ));
    // FirebaseApp secondaryApp = Firebase.app('news_module');
    // firebaseAnalytics = FirebaseAnalytics.instanceFor(app: Firebase.app("news_module"));
    try {
      firebaseAnalytics = FirebaseAnalytics.instance;
    } catch (e) {
      print(e);
    }
  }

  void fire(EventTracking event) {
    final now = DateTime.now();
    event.timeStamp = now.millisecondsSinceEpoch;
    if (SHOW_EVENT_TRACKING_LOG) {
      log("name:${event.name} params:${event.params.toString()}",
          name: "Event Tracking");
    }
    firebaseAnalytics?.logEvent(name: event.name, parameters: event.params);
  }
}
