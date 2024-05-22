import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/chat/data/repository/chat_respository_impl.dart';
import 'package:volunteer_connection/features/chat/domain/entity/message.dart';

class CreateMessageUseCase implements UseCase<DataState<String>, Message> {
  final ChatRespositoryImpl _chatRI;
  CreateMessageUseCase(this._chatRI);
  @override
  Future<DataState<String>> call({required Message p}) {
    return _chatRI.createMessage(message: p);
  }
}
