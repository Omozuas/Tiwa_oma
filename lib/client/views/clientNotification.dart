import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';

class ClientNotification extends StatefulWidget {
  ClientNotification({super.key, this.token, this.message});
  final token;
  final message;
  static const route = '/ClientNotification';
  @override
  State<ClientNotification> createState() => _ClientNotificationState();
}

class _ClientNotificationState extends State<ClientNotification> {
  @override
  void initState() {
    super.initState();

    print(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    // final message =
    //     ModalRoute.of(context)?.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
        elevation: 0,
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Text("${message.notification?.title.toString()}"),
          // Text("${message.notification?.body}"),
          // Text('${message.data}')
        ],
      ),
    );
  }
}
