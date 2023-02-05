TODO: This package is to use custom clipper widget made using custom path maker web app (FlutterPathMaker) (https://sdycode.github.io/FlutterPathMaker/#/)
## Features

TODO: It just requires the correct clipper widget data in form of json file which can be created using web app (FlutterPathMaker) link given above

## Getting started
<h1>Custom Path Maker</h1>

TODO: Just import package, create your custom clipped widget using (FlutterPathMaker) and save json file and add in assets 

## Usage

TODO: it contains sample example whose image is given below.

```dart
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
    Size boxSize = Size(sw , sh * 0.4);
    return Scaffold(
        appBar: AppBar(title: Text("Custom Path"),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            CustomClipperWidgetSingle(
              filePath: "assets/five.json",
              size: boxSize,
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
              size: boxSize,
              child:InteractiveViewer(
                child: Container(
                  width: sw * 1,
                  height: sh * 0.4,
                  color: Colors.purple.shade100,
                  child: Image.asset("assets/parrot.jpeg", fit: BoxFit.contain,),
                ),
              ),
            ),
            CustomPathPainterFromAsset(filePath: "assets/star5.json",size:boxSize,),
             CustomPathPainterFromAsset(filePath: "assets/wave.json",size: Size(sw,sh*0.2),),
                 CustomPathPainterFromAsset(filePath: "assets/face2.json",size:boxSize,),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}

```

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/sdycode/path_maker/master/assets/custompath1.jpg" alt = "" width="300"></td>
     <td><img src="https://raw.githubusercontent.com/sdycode/path_maker/master/assets/custompath2.jpg" alt = "" width="300"></td>
  </tr>
  
 
  
 
</table>
## Additional information

TODO: This package contains widgets and functions which which are used to create custom clipper and also developer can also use Custom Painter for the same
