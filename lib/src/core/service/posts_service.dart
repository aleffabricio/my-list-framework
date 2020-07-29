import 'package:dio/dio.dart';
import 'package:my_list_framework/src/core/constants/constants.dart';
import 'dart:convert';

import 'package:my_list_framework/src/core/entity/posts_entity.dart';

class PostService {
  Future<List<PostsEntity>> getPosts() async {

    BaseOptions options = BaseOptions(
      baseUrl: '$BASE_URL/posts',
      connectTimeout: 100000,
      receiveTimeout: 50000,
    );

    Dio dio = Dio(options);
    CancelToken token = CancelToken();

    try {
      Response response = await dio.get(dio.options.baseUrl, cancelToken: token);
      if((response.data as List).length > 0){
        return postsEntityFromJson(json.encode(response.data));
      }else{
        return null;
      }
    } on DioError catch (e) {
      token.cancel("Requisição cancelada.");
      if(e.type == DioErrorType.DEFAULT  || e.type == DioErrorType.RESPONSE){
        print('Site está fora do ar');
      }else if(e.type == DioErrorType.CONNECT_TIMEOUT){
        print('Servidor demorou a responder');
      }else if(e.type == DioErrorType.RECEIVE_TIMEOUT){
        print('Servidor não retornou dados.');
      }
      return null;
    }
  }
}
