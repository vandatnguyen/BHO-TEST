import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'controller/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('FiNews Module'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'FiNews Module',
            ),
            Text(
              'FiNews Module',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    return GetMaterialApp( //for navigation dont forget to use GetMaterialApp
      title: 'getXpro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageView()
      },
    );


    // return GetMaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: HomePageView(),
    // );
  }

}