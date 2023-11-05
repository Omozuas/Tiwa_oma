import 'dart:convert';
import 'package:Tiwa_Oma/services/model/book_model.dart';
import 'package:Tiwa_Oma/services/model/review_model.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/user_model.dart';
import 'package:http/http.dart' as http;

class BookingApi {
  static Future<List<BookinModel>> fetchBookingData(
      String? token, String userId1) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookings = "${url}bookings/user-reviews/${userId1}";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);

    final results = responData['data'] as List<dynamic>;

    print(responData['amount']);
    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentTime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          bookingCount: e['bookingCount'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingDataId(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookings = "${url}bookings/stylist/${stylistId}/clients/display";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdDetails(
      String? token, String userId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookingsDetails = "${url}bookings/count/user/${userId}";

    final respons = await http.get(Uri.parse(getUserBookingsDetails), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;
    final results2 = responData['data2'];

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          transactionId: e['transactionId'],
          bookingCount: results2,
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdUserId(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookingsUserId =
        "${url}bookings/togetid/stylist/${stylistId}/users";

    final respons = await http.get(Uri.parse(getUserBookingsUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['username'],
          profileImg: e['profileImg'],
          email: e['email'],
          address: e['address'],
          state: e['state'],
          country: e['country'],
          gender: e['gender'],
          accountType: e['accountType'],
          stripeCostormerId: e['stripeCostormerId'],
          number: e['number'],
          id: e['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel2>> fetchBookingDataIdFrequentUserId(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookingsUserId =
        "${url}bookings/togetid/stylist/${stylistId}/most-frequent-user";

    final respons = await http.get(Uri.parse(getUserBookingsUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);

      return BookinModel2(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: e['stylistId'],
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: e['ratingId']);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingById(
      String? token, String id) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookingsUserId = "${url}bookings/find/bookID/${id}";

    final respons = await http.get(Uri.parse(getUserBookingsUserId), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    var responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingDataIdToday(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookings = "${url}bookings/booking/today/${stylistId}";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingDataIdYestaday(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookings = "${url}bookings/booking/yesterday/${stylistId}";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchBookingDataIdPreviousDays(
      String? token, String stylistId) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getUserBookings = "${url}bookings/booking/previous/${stylistId}";

    final respons = await http.get(Uri.parse(getUserBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<BookinModel>> fetchAllBookingData(String? token) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getBookings = "${url}bookings/getAllBooking";

    final respons = await http.get(Uri.parse(getBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    // print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['_id']);
      final userId2 = ReviewName(
        accountType: e['userId']['accountType'],
        profileImg: e['userId']['profileImg'],
        number: e['userId']['number'],
        username: e['userId']['username'],
        country: e['userId']['country'],
        email: e['userId']['email'],
        address: e['userId']['address'],
        state: e['userId']['state'],
        gender: e['userId']['gender'],
        id: e['userId']['_id'],
      );
      final userId = UserModel(
          username: e['userId']['username'],
          profileImg: e['userId']['profileImg'],
          email: e['userId']['email'],
          address: e['userId']['address'],
          state: e['userId']['state'],
          country: e['userId']['country'],
          stripeCostormerId: e['userId']['stripeCostormerId'],
          gender: e['userId']['gender'],
          accountType: e['userId']['accountType'],
          number: e['userId']['number'],
          id: e['userId']['_id']);
      final ratingId = ReviewModel(
          rating: e['rating'],
          feedback: e['feedback'],
          userId: userId2,
          category: e['category']);
      return BookinModel(
          appointmentDate: e['appointmentDate'],
          id: e['_id'],
          hairImg: e['hairImg'],
          hairName: e['hairName'],
          appointmentTime: e['appointmentime'],
          amount: e['amount'],
          showStatus: e['showStatus'],
          userId: userId,
          stylistId: stylistId,
          transactionId: e['transactionId'],
          bookingCount: e['bookingCount'],
          ratingId: ratingId);
    }).toList();
    return bookingModelUser;
  }

  static Future<List<StylistBookinModel>> fetchAllBookingMadeWithAndCount(
      String? token) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getBookings = "${url}bookings/bookings-by-stylist";

    final respons = await http.get(Uri.parse(getBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylist']['username'],
          profileImg: e['stylist']['profileImg'],
          email: e['stylist']['email'],
          address: e['stylist']['address'],
          state: e['stylist']['state'],
          country: e['stylist']['country'],
          gender: e['stylist']['gender'],
          accountType: e['stylist']['accountType'],
          number: e['stylist']['number'],
          id: e['stylist']['_id']);

      return StylistBookinModel(
          stylistId: stylistId,
          bookingCount: e['bookingCount'],
          averageRating: e['averageRating']);
    }).toList();
    // print(bookingModelUser);
    return bookingModelUser;
  }

  static Future<List<StylistBookinModel1>> fetchStylistDetailsAndBookingCount(
      String? token) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getBookings = "${url}bookings/stylist-booking-counts";

    final respons = await http.get(Uri.parse(getBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final stylistId = StylistModel(
          username: e['stylistId']['username'],
          profileImg: e['stylistId']['profileImg'],
          email: e['stylistId']['email'],
          address: e['stylistId']['address'],
          state: e['stylistId']['state'],
          country: e['stylistId']['country'],
          gender: e['stylistId']['gender'],
          accountType: e['stylistId']['accountType'],
          number: e['stylistId']['number'],
          id: e['stylistId']['_id']);

      return StylistBookinModel1(
        stylistId: stylistId,
        bookingCount: e['bookingCount'],
      );
    }).toList();
    // print(bookingModelUser);
    return bookingModelUser;
  }

  static Future<List<ClientBookinModel>>
      fetchAllBookingMadeWithCustormersAndCount(String? token) async {
    const url = 'https://tiwa-oma-api.onrender.com/';
    var getBookings = "${url}bookings/client-booking-counts";

    final respons = await http.get(Uri.parse(getBookings), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}",
    });
    final Map<String, dynamic> responData = jsonDecode(respons.body);
    print(responData);
    final results = responData['data'] as List<dynamic>;

    final bookingModelUser = results.map((e) {
      final clientId = UserModel(
          username: e['userIds']['username'],
          profileImg: e['userIds']['profileImg'],
          email: e['userIds']['email'],
          address: e['userIds']['address'],
          state: e['userIds']['state'],
          country: e['userIds']['country'],
          gender: e['userIds']['gender'],
          accountType: e['userIds']['accountType'],
          number: e['userIds']['number'],
          id: e['userIds']['_id']);

      return ClientBookinModel(
        clientId: clientId,
        bookingCount: e['bookingCount'],
      );
    }).toList();
    // print(bookingModelUser);
    return bookingModelUser;
  }
}
