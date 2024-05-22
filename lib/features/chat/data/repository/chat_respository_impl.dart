import 'package:dio/dio.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/chat/data/datasource/chat_data_source.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';
import 'package:volunteer_connection/features/chat/domain/repository/chat_repository.dart';

class ChatRespositoryImpl implements ChatRepository {
  final ChatDataSourceImpl _chatDSI;

  ChatRespositoryImpl(this._chatDSI);
  @override
  Future<DataState<List<Chat>>> getListChatForId({required String id}) async {
    try {
      final httpResponse = await _chatDSI.getListChatForId(id: id);

      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
            message: httpResponse.statusMessage,
            requestOptions: RequestOptions(),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Message>>> getListMessForId(
      {required String id}) async {
    try {
      final httpResponse = await _chatDSI.getListMessForId(id: id);

      if (httpResponse.statusCode == 200) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
            message: httpResponse.statusMessage,
            requestOptions: RequestOptions(),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
