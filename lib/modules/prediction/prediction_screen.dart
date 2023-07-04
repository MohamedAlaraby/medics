import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/models/oxy_flow_model.dart';
import 'package:medics/models/x_ray_model.dart';
import 'package:medics/modules/prediction/RangeScreen.dart';
import 'package:medics/shared/constants.dart';
import 'package:http/http.dart' as http;
import '../../shared/components.dart';
import '../../shared/custom_outlined.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  int? oxy_flow;
  OxyFlowModel ?model;
  XRayModel? xRayModel;
  int? probability;


  @override
  Widget build(BuildContext context) {
    var cubit=DashboardCubit.get(context);

    String? age=cubit.userModel?.user?.age;
    String? gender=cubit.userModel?.user?.gender;
    String? hr=cubit.getReadingsModel?.data?.heartRate;
    String? spo2=cubit.getReadingsModel?.data?.spo;
    if(oxy_flow==null){
      getOxyFlow(
        age: age,
        gender_: gender,
        heart_rate: hr,
        spo2: spo2,
      ).then((value) =>setState(() {  }));
    }

    //to make our app suitable with any size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=DashboardCubit.get(context);

        var status=cubit.getReadingsModel?.data?.status;
        var prob=cubit.getReadingsModel?.data?.prob;
        if(prob!=null)
            probability=((double.parse(prob))*100).toInt();
        if(state=="0"){
           status="Normal";
        }else{
          status="Abnormal";
        }
        return Container(
          padding: EdgeInsets.all(5),
          height: screenHeight*0.99,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: const Color(0xff020227),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(width: 16,),
                          Container(
                              width: 35,height:35,child: Image(
                              image: AssetImage('assets/images/lungs.png'),
                              color: Colors.white,
                          )
                          ),
                          SizedBox(width: 16,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Predicted oxygen flow',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.85),
                                  fontSize:  screenWidth*0.05,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                              Text(
                                '${oxy_flow} LPM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.85),
                                  fontSize: screenWidth*0.05,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          ],
                            ),
                    ),
                    myDivider(),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(width: 16,),
                          Container(
                              width: 35,height:35,child: Image(
                              image: AssetImage('assets/images/heart.png'),
                              color: Colors.white,
                          )),
                          SizedBox(width: 16,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'Heart status: ${status}'}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.85),
                                  fontSize: screenWidth*0.05,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                'With probability: ${probability}%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kWhiteColor.withOpacity(0.85),
                                  fontSize: screenWidth*0.05,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                           navigateTo(context, HeartRateBarChart());
                      },
                      child: Text(
                        'Click here to see the normal and abnormal ranges',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth*0.04,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                    myDivider(),
                    SizedBox(height: screenHeight * 0.02),
                    CustomOutline(
                      height: screenWidth * 0.55,
                      width: screenWidth * 0.62,
                      strokeWidth: 2,
                      radius: screenWidth * 0.02,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kPinkColor,
                            kPinkColor.withOpacity(0),
                            kGreenColor.withOpacity(0.1),
                            kGreenColor
                          ],
                          stops: const [
                            0.2,
                            0.4,
                            0.6,
                            1
                          ]
                      ),
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: inputImage == null
                            ? Container(
                          height: screenWidth * 0.55,
                          width: screenWidth * 0.62,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,

                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/gallery.png'
                                    ),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.bottomLeft,
                                  ),
                                ),
                              )
                            : Container(
                          height: screenWidth * 0.55,
                          width: screenWidth * 0.62,

                          decoration: BoxDecoration(
                                   borderRadius:BorderRadius.all(Radius.circular(screenWidth * 0.02)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: FileImage(inputImage!),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.bottomLeft,

                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DefaultButton(
                          function: () {
                            pickImage();
                          },
                          text: 'Gallery',
                          width: screenWidth * 0.4,
                        ),
                        DefaultButton(
                          function: () {
                            upload();
                          },
                          text: 'PREDICT',
                          width: screenWidth * 0.4,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: success==false
                          ? Text(
                              'The Model hasn\'t predicted yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kWhiteColor.withOpacity(0.85),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : Container(
                              width:screenWidth*0.7 ,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 1, color: Colors.white70),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                 child: Row(
                                   children: [
                                     Column(

                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                              '${listOfKeys?[0]}',

                                          textAlign: TextAlign.center,
                                          style: TextStyle
                                            (
                                            color: kWhiteColor.withOpacity(0.85),
                                            fontSize: screenHeight <= 667 ? 16 : 20,
                                            fontWeight: FontWeight.w700,
                                           ),
                              ),
                                         Text(
                                               '${listOfKeys?[1]}',
                                           textAlign: TextAlign.center,
                                           style: TextStyle
                                             (
                                             color: kWhiteColor.withOpacity(0.85),
                                             fontSize: screenHeight <= 667 ? 16 : 20,
                                             fontWeight: FontWeight.w700,
                                           ),
                                         ),
                                         Text(
                                               '${listOfKeys?[2]}',
                                           textAlign: TextAlign.center,
                                           style: TextStyle
                                             (
                                             color: kWhiteColor.withOpacity(0.85),
                                             fontSize: screenHeight <= 667 ? 16 : 20,
                                             fontWeight: FontWeight.w700,
                                           ),
                                         ),
                                       ],
                                     ),
                                     SizedBox(width: 50,),
                                     Column(

                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           '${listOfValues?[0]}%',

                                           textAlign: TextAlign.center,
                                           style: TextStyle
                                             (
                                             color: kWhiteColor.withOpacity(0.85),
                                             fontSize: screenHeight <= 667 ? 16 : 20,
                                             fontWeight: FontWeight.w700,
                                           ),
                                         ),
                                         Text(
                                           '${listOfValues?[1]}%',
                                           textAlign: TextAlign.center,
                                           style: TextStyle
                                             (
                                             color: kWhiteColor.withOpacity(0.85),
                                             fontSize: screenHeight <= 667 ? 16 : 20,
                                             fontWeight: FontWeight.w700,
                                           ),
                                         ),
                                         Text(
                                           '${listOfValues?[2]}%',
                                           textAlign: TextAlign.center,
                                           style: TextStyle
                                             (
                                             color: kWhiteColor.withOpacity(0.85),
                                             fontSize: screenHeight <= 667 ? 16 : 20,
                                             fontWeight: FontWeight.w700,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                          ),



                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16),
                      height: screenHeight*0.5,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 1.0, // Set the maximum value for y-axis
                          barTouchData: BarTouchData(enabled: false),

                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              margin: 16,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return '${listOfKeys?[0]}';
                                  case 1:
                                    return '${listOfKeys?[1]}';
                                  case 2:
                                    return '${listOfKeys?[2]}';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              margin: 16,
                              reservedSize: 40,
                              interval:0.1,
                              getTitles: (value) {
                                const double epsilon = 1e-10; // Tolerance for floating-point comparisons
                                if ((value - 0).abs() < epsilon) {
                                  return '0%';
                                } else if ((value - 0.1).abs() < epsilon) {
                                  return '10%';
                                } else if ((value - 0.2).abs() < epsilon) {
                                  return '20%';
                                } else if ((value - 0.3).abs() < epsilon) {
                                  return '30%';
                                } else if ((value - 0.4).abs() < epsilon) {
                                  return '40%';
                                } else if ((value - 0.5).abs() < epsilon) {
                                  return '50%';
                                } else if ((value - 0.6).abs() < epsilon) {
                                  return '60%';
                                } else if ((value - 0.7).abs() < epsilon) {
                                  return '70%';
                                } else if ((value - 0.8).abs() < epsilon) {
                                  return '80%';
                                } else if ((value - 0.9).abs() < epsilon) {
                                  return '90%';
                                } else if ((value - 1.0).abs() < epsilon) {
                                  return '100%';
                                }

                                return '';
                              },
                            ),
                            rightTitles: SideTitles(
                              showTitles: false,
                            ),
                            topTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                          ),
                          barGroups: listOfValues?.asMap().entries.map((entry) {
                            int index = entry.key;
                            double probability = entry.value/100;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  y: probability,
                                  colors: [Colors.blue],
                                  width: 16,
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future  getOxyFlow ({
    required String? heart_rate,
    required String? gender_,
    required String? age,
    required String? spo2,
  }) async{
    var gender= gender_=="male"?1:0;

   await http.post(
        Uri.parse('https://flask-production-ecba.up.railway.app/predict?pr=${heart_rate}&gender=${gender}&age=${age}&nCoV2=1&spo2=${spo2}'))
        .then((value) {
      model=OxyFlowModel.fromJson(jsonDecode(value.body));
      oxy_flow=double.parse(model!.oxyFlow!).toInt();

      print(model?.oxyFlow);
    }  ).catchError((error){
      print(error);
    });
  }


  String? result;
  File? inputImage;
  final picker = ImagePicker();
  Future pickImage() async {
    var pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      inputImage = File(pickedFile!.path);
      print("###The path of the image is : $inputImage");
    });
  }
  var url = "http://10.0.2.2:5000/predict";//for the emulator

  List<String>? listOfKeys  ;
  List<double>? listOfValues;
  List<String> keys = [];
  List<double> values = [];
  bool success=false;
  void upload() async {
    success = false;
    keys = [];
    values = [];
    listOfValues = [];
    listOfKeys = [];

    final request = http.MultipartRequest("POST", Uri.parse(url));
    // Add the image file to the request.
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Form field name for the image
        inputImage!.path, // Path to the image file
      ),
    );


    try {
      // Send the request
      var response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Read and print the response
        var responseBody = await response.stream.transform(utf8.decoder).join();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        xRayModel = XRayModel.fromJson(jsonResponse);
        Map<String, dynamic> predMap = jsonResponse['pred'];


        predMap.forEach((key, value) {
          print('the key is $key and the value is $value');
          keys.add(key);
          values.add(value);
        });

        print('keys   $keys');
        print('values $values');
        listOfKeys = keys;
        values.forEach((element) {
          var value = element * 100;
          listOfValues?.add(
              double.parse(value.toStringAsPrecision(2))
          );
        });
        print(listOfValues);
        success = true;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }

    setState(() {});
  }
}
