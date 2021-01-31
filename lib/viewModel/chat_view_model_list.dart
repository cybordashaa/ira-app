import 'package:ira_app/models/message.dart';
import 'package:ira_app/service/AuthService.dart';
import 'package:ira_app/viewModel/chat_view_model.dart';
import 'package:mobx/mobx.dart';
part 'chat_view_model_list.g.dart';

class ChatListState = ChatListVM with _$ChatListState;
enum MessageStatus { loading, loaded, empty }

abstract class ChatListVM with Store {
  @observable
  MessageStatus messageStatus = MessageStatus.empty;

  @observable
  ObservableList<ChatViewModel> messageList = ObservableList<ChatViewModel>();

  @observable
  ObservableList<String> writingUsers = ObservableList<String>();

  @action
  Future<void> fetchMessage() async {
    messageStatus = MessageStatus.loading; // Veriler Getiriliyor
    var list = await AuthService.shared.fetchMessageList();
    this.messageList =
        ObservableList.of((list.map((e) => ChatViewModel(message: e))));

    if (messageList.isNotEmpty) {
      // Veri Var ise
      messageStatus = MessageStatus.loaded;
    } else {
      messageStatus = MessageStatus.empty;
    }
  }

  @action
  addMessage(
      {String message,
      bool file,
      String file_type,
      String op,
      String whoType}) {
    messageList.add(ChatViewModel(
        message: Message(
      message: message,
      op: op,
      file: file,
      file_type: file_type,
      seen: false,
      whoType: whoType,
      createdAt: DateTime.now().toString(),
    )));
    messageStatus = MessageStatus.loaded;
  }

  @action
  setWritingUsers(List<String> writing) {
    writingUsers = ObservableList.of(writing);
  }
}
