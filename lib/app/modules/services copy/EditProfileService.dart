// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';

// class EditProfileService {
//   final String baseUrl;

//   EditProfileService({required this.baseUrl});

//   Future<Response> editProfile({
//     required int userId,
//     required String name,
//     required String birthdate,
//     required String gender,
//     required List<String> interests,
//     required File profilePicture,
//     required String latitude,
//     required String longitude,
//     required bool verified,
//   }) async {
//     final String url = 'https://meet-around-apis-production.up.railway.app/api/user/editProfile';
//     final storage = GetStorage();
//     final token = storage.read('token');

//     final dio = Dio();
//     FormData formData = FormData.fromMap({
//       'userId': userId,
//       'name': name,
//       'birthdate': birthdate,
//       'gender': gender,
//       'interests': interests,
//       'profile_picture': await MultipartFile.fromFile(profilePicture.path),
//       'latitude': latitude,
//       'longitude': longitude,
//       'verified': verified,
//     });

//     try {
//       print('Sending request to: $url');
//       print('Request data: ${formData.fields}');
//       print(token);
//       final response = await dio.post(
//         url,
//         data: formData,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );
//       print('Response: ${response.data}');
//       return response;
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to update profile: $e');
//     }
//   }
// }
