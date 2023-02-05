import 'package:flutter/material.dart';
import 'package:path_maker/path_maker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Path Maker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

double sw = 200;
double sh = 300;

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    sw = MediaQuery.of(context).size.width;
    sh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: Text("Custom Path"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       
          CustomClipperWidgetSingle(
            filePath: "assets/five.json",
            size: Size(sw * 1, sh * 0.4),
            child: InteractiveViewer(
              child: Container(
                width: sw * 1,
                height: sh * 0.4,
                color: Colors.red.shade400,
                child: Image.asset("assets/nature.jpg", fit: BoxFit.contain,),
              ),
            ),
          ),
          CustomClipperWidgetSingle(
            filePath: "assets/tri.json",
            size: Size(sw * 1, sh * 0.4),
            child:InteractiveViewer(
              child: Container(
                width: sw * 1,
                height: sh * 0.4,
                color: Colors.purple.shade100,
                child: Image.asset("assets/parrot.jpeg", fit: BoxFit.contain,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
