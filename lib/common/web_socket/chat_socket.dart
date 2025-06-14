import 'package:chat_application/common/const/url_const.dart';
import 'package:chat_application/common/storage/app_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatSocket {
  static final AppStorage _appStorage = GetIt.I.get<AppStorage>();
  static String get init => "init";
  static String get joinRoom => "join_room";
  static String get newMessage => "new_message";
  static String get sendMessage => "send_message";
  static late Socket socket;
  static void connect() {
    print("Connect socket");
    socket = io(
        UrlConst.socket,
        OptionBuilder()
            .setTransports(['websocket']) // 👈 this is essential
            .enableAutoConnect()
            .build());
    String id = _appStorage.getUserId();
    socket.onConnect((v) {
      emit(cmd: init, data: id);
    });
    socket.onConnectError((err) {
      print("Connect error: $err");
    });
    socket.onDisconnect((_) {
      print("Socket disconnected");
    });
  }

  static void emit({required String cmd, required dynamic data}) {
    print("Emit :$cmd - $data");
    socket.emit(cmd, data);
  }

  static void listen(
      {required String cmd, required Function(dynamic) callback}) {
    print("Listen :$cmd");
    socket.on(cmd, callback);
  }
}
