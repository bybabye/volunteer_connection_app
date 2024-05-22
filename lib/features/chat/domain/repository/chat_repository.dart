import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';

abstract class ChatRepository {
  Future<DataState<List<Chat>>> getListChatForId({required String id});
  Future<DataState<List<Message>>> getListMessForId({required String id});
  Future<DataState<String>> createMessage({required Message message});
}
