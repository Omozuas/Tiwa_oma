import 'package:Tiwa_Oma/services/model/notification_model.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/providers/notificationApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/widgets/notificationItemAndCard.dart';
import 'package:Tiwa_Oma/widgets/stylistNotificationCardAndList.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientNotification extends StatefulWidget {
  ClientNotification({super.key, this.token, this.message});
  final token;
  final message;
  static const route = '/ClientNotification';
  @override
  State<ClientNotification> createState() => _ClientNotificationState();
}

class _ClientNotificationState extends State<ClientNotification> {
  late SharedPreferences prefsDevice;
  String fcmToken = '';
  String username = '';
  String email = '';
  String accountType = '';
  late final id;
  String? profileImg = '';
  @override
  void initState() {
    super.initState();
    initSharedPref();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    id = jwtDecodedToken['id'];
    try {
      email = jwtDecodedToken['email'];

      getuserById(id);

      print("see $fcmToken");
      print(id);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
    print(widget.token);
  }

  void initSharedPref() async {
    prefsDevice = await SharedPreferences.getInstance();
    var tokend = prefsDevice.getString('token');
    setState(() {
      fcmToken = tokend!;
    });
    print("token $tokend");
  }

  Future<void> getuserById(id) async {
    GetUsers.fetchStylistData(widget.token, id).then((res) {
      if (res.data['firebaseToken'] == null) {
        initSharedPref();
      } else {
        print(res.data['firebaseToken']);
      }
      setState(() {
        email = res.data['email'];
        username = res.data['username'];
        profileImg = res.data['profileImg'];
        accountType = res.data['accountType'];
      });
      getNotificationByUserId(id);
    });
  }

  Future<void> getNotificationByUserId(id) async {
    if (accountType == "client") {
      final res = await NotificationApi.fetchBookingById(widget.token, id);
      print(" my account typ $accountType");
      setState(() {
        notification = res;
      });
    } else if (accountType == 'stylist') {
      final res =
          await NotificationApi.fetchBookingStylistById(widget.token, id);
      print(" my account typ $accountType");
      setState(() {
        notification2 = res;
      });
    }
  }

  List<NotificationModel> notification = [];

  List<NotificationModel> notification2 = [];
  @override
  Widget build(BuildContext context) {
    // final message =
    //     ModalRoute.of(context)?.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notifications"),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await getuserById(id);
          await getNotificationByUserId(id);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (accountType == 'client')
                  NotificationItemList(notifyList: notification),
                if (accountType == 'stylist')
                  StylistNotificationItemList(notifyList: notification2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
