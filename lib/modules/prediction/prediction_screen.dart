import 'dart:core';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as Img;

  class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);
  @override
  _PredictionScreenState createState() => _PredictionScreenState();

  }
  class _PredictionScreenState extends State<PredictionScreen> {


    late File _image;
    late File inputImage;
    late List results;
    bool imageSelect=false;
    late String tempPath;
  // @override
  //  void initState() {
  // super.initState();
  //     loadModel();
  // }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Image Classification"),
        ),
        body: ListView(
          children: [
            (imageSelect)?Container(
              margin: const EdgeInsets.all(10),
              child: Image.file(inputImage),
            ):Container(
              margin: const EdgeInsets.all(10),
              child: const Opacity(
                opacity: 0.8,
                child: Center(
                  child: Text("No image selected"),
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
              children: [
                (imageSelect)?Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(File(tempPath)),
                ):Container(),
              ],
                // children: (imageSelect)?_results.map((result) {
                //   return Card(
                //     child: Container(
                //       margin: EdgeInsets.all(10),
                //       child: Text(
                //         "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                //         style: const TextStyle(color: Colors.red,
                //             fontSize: 20),
                //       ),
                //     ),
                //   );
                // }).toList():[],

              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: pickAndResizeImage,
          tooltip: "Pick Image",
          child: const Icon(Icons.image),
        ),
      );
    }
    Future<void> pickAndResizeImage() async {
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
      );
      if (pickedFile == null) return; // No image selected

      inputImage  = File(pickedFile.path);
      // Read the image file
      final Img.Image? image = Img.decodeImage(inputImage.readAsBytesSync());
      if (image == null) return; // Error decoding the image

      // Resize the image
      final Img.Image resizedImage = Img.copyResize(image, width: 250, height: 200);

      // Save the resized image to a temporary file
      final tempDir = await getTemporaryDirectory();
      tempPath = '${tempDir.path}/resized_image.png';
      File(tempPath).writeAsBytesSync(Img.encodePng(resizedImage));

      print(tempPath);
      print("the original image dim is ${image.width} ${image.height}");
      print("the resized image dim is ${resizedImage.width} ${resizedImage.height}");
      setState(() {
         _image  =File(tempPath);
         imageSelect=true;
      });
      // imageClassification(File(tempPath));

  }

    // Future loadModel() async {
    //   Tflite.close();
    //   String res;
    //   res=(
    //       await Tflite.loadModel(
    //         model: "assets/model.tflite" ,
    //       ))!;
    //   print("Model loading status: $res");
    //
    // }//load model





    Future imageClassification(File tempPath) async {

      //
      // await Tflite.runModelOnImage(
      //     path:tempPath.path ,
      //  ).then((result){
      //        print('elaraby model classification successful');
      //       // setState(() {
      //       //   _image  =tempPath ;
      //       //   _results=result!;
      //       //   imageSelect=true;
      //       // });
      // }).catchError((error){
      //        print('elaraby model classification error');
      //       // setState(() {
      //       //   _image  =tempPath ;
      //       //   _results=null;
      //       //   imageSelect=true;
      //       // });
      // });
    }//imageClassification





  }
