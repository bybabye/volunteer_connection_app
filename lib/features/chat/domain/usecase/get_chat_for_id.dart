import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/chat/data/repository/chat_respository_impl.dart';
import 'package:volunteer_connection/features/chat/domain/entity/chat.dart';

class GetChatForIdUseCase implements UseCase<DataState<List<Chat>>, String> {
  final ChatRespositoryImpl _chatRI;
  GetChatForIdUseCase(this._chatRI);

  @override
  Future<DataState<List<Chat>>> call({String? p}) {
    return _chatRI.getListChatForId(id: p!);
  }
}
