import 'package:dio/dio.dart';
import 'package:volunteer_connection/config/constanst_config.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';

abstract class ChatDataSource {
  Future<Response<List<Chat>>> getListChatForId({required String id});
  Future<Response<List<Message>>> getListMessForId({required String id});
  Future<Response<String>> createMessage({required Message message});
}

class ChatDataSourceImpl implements ChatDataSource {
  final dio = Dio();
  @override
  Future<Response<List<Chat>>> getListChatForId({required String id}) async {
    Response response;

    try {
      response = await dio.get("${ConstanstConfig.getChat}/$id");
      // Giả sử response.data!['data'] là một List<dynamic> chứa dữ liệu JSON của các đối tượng Chat
      List<dynamic> jsonDataList = response.data!['data'] as List<dynamic>;

// Khai báo một danh sách để lưu trữ các đối tượng Chat được chuyển đổi từ JSON
      List<Chat> result = [];

// Lặp qua mỗi phần tử trong danh sách JSON và chuyển đổi nó thành một đối tượng Chat
      jsonDataList.forEach((json) {
        result.add(Chat.fromJson(json as Map<String, dynamic>));
      });
      return Response(
        statusCode: 200,
        data: result,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
          statusCode: e.response!.statusCode,
          statusMessage: e.response!.data['message']['message'],
          data: null,
          requestOptions: RequestOptions(),
        );
      } else {
        return Response(
          statusCode: 500,
          statusMessage: e.toString(),
          data: null,
          requestOptions: RequestOptions(),
        );
      }
    }
  }

  @override
  Future<Response<List<Message>>> getListMessForId({required String id}) async {
    Response response;
    print("${ConstanstConfig.getMess}/$id");
    try {
      response = await dio.get("${ConstanstConfig.getMess}/$id");

      // Giả sử response.data!['data'] là một List<dynamic> chứa dữ liệu JSON của các đối tượng Chat
      List<dynamic> jsonDataList = response.data!['data'] as List<dynamic>;

// Khai báo một danh sách để lưu trữ các đối tượng Chat được chuyển đổi từ JSON
      List<Message> result = [];

// Lặp qua mỗi phần tử trong danh sách JSON và chuyển đổi nó thành một đối tượng Chat
      jsonDataList.forEach((json) {
        result.add(Message.fromJson(json as Map<String, dynamic>));
      });
      return Response(
        statusCode: 200,
        data: result,
        requestOptions: RequestOptions(),
      );
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        return Response(
          statusCode: e.response!.statusCode,
          statusMessage: e.response!.data['message']['message'],
          data: null,
          requestOptions: RequestOptions(),
        );
      } else {
        return Response(
          statusCode: 500,
          statusMessage: e.toString(),
          data: null,
          requestOptions: RequestOptions(),
        );
      }
    }
  }

  @override
  Future<Response<String>> createMessage({required Message message}) async {
    print("${ConstanstConfig.createMess}/${message.chatId}");
    try {
      await dio.post(ConstanstConfig.createMess, data: {
        'type': message.type,
        'content': message.content,
        'chatId': message.chatId,
        'senderId': message.sender.id
      });
      return Response(
        statusCode: 200,
        data: "success",
        requestOptions: RequestOptions(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
          statusCode: e.response!.statusCode,
          statusMessage: e.response!.data['message']['message'],
          data: null,
          requestOptions: RequestOptions(),
        );
      } else {
        return Response(
          statusCode: 500,
          statusMessage: e.toString(),
          data: null,
          requestOptions: RequestOptions(),
        );
      }
    }
  }
}
