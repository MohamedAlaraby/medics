import 'package:dio/dio.dart';
import 'package:medics/shared/constants.dart';
class DioHelper{
  static late Dio dio;
  static late Dio PredictionDio;
  static init(){
    dio=Dio(
      BaseOptions(
          baseUrl: 'https://test.saloni.ma/api/',
          receiveDataWhenStatusError: true,//receive response data even when the HTTP status code indicates an error.
      ),

    );


    PredictionDio=Dio(
      BaseOptions(
        baseUrl: 'https://flask-production-ecba.up.railway.app/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData({
    required String? url,
    Map <String ,dynamic>? query,
    String? lang='en',
    String? token,
  })async{

    dio.options.headers={
        'lang':lang,
         'Authorization':'Bearer ${token}',
         'Content-Type':'application/json',
      };
   return await dio.get(
        url!,
        queryParameters: query
    );
  }


  static Future<Response> postData({
    required String url,
    required dynamic data,
    String? lang='en',
    String? token,
  })async{
    dio.options.headers = {
      'lang':lang,
      'Authorization':'Bearer ${token}',
      'Content-Type':'application/json',

    };
    return await dio.post(
        url,//your endpoint
        data:data
    );
  }



  static Future<Response> postDataPred({
    required String url,
    required dynamic data,
  }) async{

    return await PredictionDio.post(
        url,
        data:data
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String,dynamic>? query,
    required Map <String ,dynamic> data,
    String? lang='en',
    String? token,
  })async{

    dio.options.headers={
      'lang':lang,
      'Authorization':'Bearer ${token}',
      'Content-Type':'application/json',
    };
    return await dio.put(
        url,
        queryParameters: query,
        data:data
    );
  }
}