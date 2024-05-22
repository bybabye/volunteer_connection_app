import 'package:flutter/material.dart';
import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/features/chat/data/datasource/chat_data_source.dart';
import 'package:volunteer_connection/features/chat/data/repository/chat_respository_impl.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';
import 'package:volunteer_connection/features/chat/domain/usecase/create_mess.dart';
import 'package:volunteer_connection/features/chat/domain/usecase/get_chat_for_id.dart';
import 'package:volunteer_connection/features/chat/domain/usecase/get_mess_for_id.dart';

class ChatProvider extends ChangeNotifier {
  final GetChatForIdUseCase _getChatForIdUseCase;
  final GetMessForIdUseCase _getMessForIdUseCase;
  final CreateMessageUseCase _createMessageUseCase;

  ChatProvider()
      : _getMessForIdUseCase =
            GetMessForIdUseCase(ChatRespositoryImpl(ChatDataSourceImpl())),
        _createMessageUseCase =
            CreateMessageUseCase(ChatRespositoryImpl(ChatDataSourceImpl())),
        _getChatForIdUseCase =
            GetChatForIdUseCase(ChatRespositoryImpl(ChatDataSourceImpl()));

  Future<List<Chat>> getChatForId({required String id}) async {
    List<Chat> chats = [];
    try {
      final dataState = await _getChatForIdUseCase(p: id);

      if (dataState is DataFailed) {
        print("data is Failed :  ${dataState.error!.message}");
      }
      if (dataState is DataSuccess) {
        print("data is Success : ${dataState.data}");
        for (var element in dataState.data!) {
          chats.add(element);
        }
      }
    } catch (e) {
      print("data is Exception : ${e.toString()}");
    }
    return chats;
  }

  Future<List<Message>> getMessForId({required String id}) async {
    List<Message> messages = [];
    try {
      final dataState = await _getMessForIdUseCase(p: id);

      if (dataState is DataFailed) {
        print("data is Failed :  ${dataState.error!.message}");
      }
      if (dataState is DataSuccess) {
        print("data is Success : ${dataState.data}");
        for (var element in dataState.data!) {
          messages.add(element);
        }
      }
    } catch (e) {
      print("data is Exception : ${e.toString()}");
    }
    return messages;
  }

  Future<void> createMessage({required Message mess}) async {
    try {
      final dataState = await _createMessageUseCase(p: mess);

      if (dataState is DataFailed) {
        print("data is Failed :  ${dataState.error!.message}");
      }
      if (dataState is DataSuccess) {
        print("data is Success : ${dataState.data}");
      }
    } catch (e) {
      print("data is Exception : ${e}");
    }
  }
}
