import 'package:volunteer_connection/core/resources/data_state.dart';
import 'package:volunteer_connection/core/usecase/usecase.dart';
import 'package:volunteer_connection/features/chat/data/repository/chat_respository_impl.dart';

import 'package:volunteer_connection/features/chat/domain/entity/message.dart';

class GetMessForIdUseCase implements UseCase<DataState<List<Message>>, String> {
  final ChatRespositoryImpl _chatRI;
  GetMessForIdUseCase(this._chatRI);

  @override
  Future<DataState<List<Message>>> call({String? p}) {
    return _chatRI.getListMessForId(id: p!);
  }
}
