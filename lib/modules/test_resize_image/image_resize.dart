import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as IMG;



class TestImage extends StatefulWidget {

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  Uint8List? resizedImg;

  Uint8List? bytes;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      String imgurl = "https://www.fluttercampus.com/img/banner.png";
      bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl)).buffer.asUint8List();

      IMG.Image? img = IMG.decodeImage(bytes!);
      IMG.Image resized = IMG.copyResize(img!, width: 250, height: 200);
      resizedImg = Uint8List.fromList(IMG.encodePng(resized));

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Resize Image"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
              children:[
                Text("Original Size"),
                bytes != null?Image.memory(bytes!):Container(),

                Text("Resize Size"),
                resizedImg != null?Image.memory(resizedImg!):Container(),

              ]
          )
      ),

    );
  }
}