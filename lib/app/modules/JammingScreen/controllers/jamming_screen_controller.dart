import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../SearchScreen/controllers/search_screen_controller.dart';

class JammingScreenController extends GetxController {
  var selectedCategory = ''.obs;
  var selectedCategoryIndex = 0.obs;
  var selectedSong = ''.obs;
  var selectedSongIndex = (-1).obs;
  var isPlaying = false.obs;
  var isSearching = false.obs;
  var isLoading = true.obs;
  var spotifyTracks = [].obs;
  var categories = [].obs;
  var filteredTracks = [].obs;

  late WebSocketChannel channel;
  final int userId;
   int? targetUserId;

  // Constructor
  JammingScreenController({required this.userId,  this.targetUserId})
  {
    print("JammingScreenController initialized with userId:$userId and targetUserId: $targetUserId");
}/* final int userId;

  final int targetUserId;

  //JammingScreenController(this.targetUserId, {required this.userId});
  JammingScreenController(this.userId, this.targetUserId);*/

  @override
  void onInit() {
    super.onInit();
    fetchSpotifyTracks();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }

  // New method to initialize WebSocket from an external source
  void initializeWebSocket(WebSocketChannel webSocketChannel) {
    print('Initializing WebSocket connection...');
    channel = webSocketChannel;

    // print("targetUserId: $this.userId");
    channel.sink.add(jsonEncode({
      "type": "init",
      "userId": userId,
    }));

    channel.stream.listen((message) {
      handleWebSocketMessage(message);
    }, onError: (error) {
      print('WebSocket Error: $error');
    });
  }

  void handleWebSocketMessage(String message) {
    try {
      if (_isJson(message)) {
        print('Received JSON message/////////////////////////: $message');
        var data = jsonDecode(message);
        _processJsonData(data);
      } else {
        var jsonData = _convertStringToJson(message);
        if (jsonData != null) {
          _processJsonData(jsonData);
        } else {
          print('Received non-JSON message: $message');
        }
      }
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  void _processJsonData(Map<String, dynamic> data) {
    print('Processing JSON data: $data');
    print("targetUserId: $targetUserId");
    switch (data['type']) {
      case 'init':
        print('Initialization message received: ${data['message']}');
        break;
      case 'request':
        print('Jamming request received from user ${data['userId']}');
        print("targetUserId: ${data["targetUserId"]}"); //21
        print("userId: ${data["userId"]}"); //7
        if (data["targetUserId"] != null) {
          int targetUserId = int.parse(data["targetUserId"].toString());
          _showJammingRequestDialog(targetUserId);
        } else {
          print("Error: targetUserId is null");
        }


        break;
      case 'response':
        print('Jamming response received: ${data['action']}');
        if (data['action'] == 'accept') {
          Get.snackbar("Accepted", "Jamming session accepted by user ${data['userId']}. Starting session...");
        } else {
          Get.snackbar("Rejected", "Jamming session rejected by user ${data['userId']}.");
        }
        break;
      case 'url':
        print('Song URL received: ${data['songUrl']}');
        // Play the song or handle it accordingly
        break;
      default:
        print('Unknown message type');
    }
  }

  void _showJammingRequestDialog(int requestingUserId) {
    Get.find<SearchScreenController>().showJammingRequestDialog(requestingUserId);
  }

  bool _isJson(String str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  Map<String, dynamic>? _convertStringToJson(String str) {
    try {
      if (str.contains(":")) {
        var parts = str.split(":");
        return {"type": "info", "message": str.trim()};
      }
    } catch (e) {
      print('Error converting string to JSON: $e');
    }
    return null;
  }

  void sendJammingRequest(int targetUserId) {
    channel.sink.add(jsonEncode({
      "type": "request",
      "userId": userId,
      "targetUserId": targetUserId,
    }));
  }

  void sendJammingResponse(int targetUserId, String action) {
    print('Sending jamming response: $action');
    channel.sink.add(jsonEncode({
      "type": "response",
      "userId": userId,
      "targetUserId": targetUserId,
      "action": action,
    }));
    print("///////");
    print("targetUserId: $targetUserId");
    print("userId: $userId");
    print("action: $action");
    print("channel: $channel");
    print("channel.sink: ${channel.sink}");
    print("channel.stream: ${channel.stream}");

  }

  void sendSongUrl(int targetUserId, String songUrl, int? songDuration) {
    final message = {
      "type": "url",
      "userId": userId,
      "targetUserId": targetUserId,
      "songUrl": songUrl,
      "songDuration": songDuration ?? 0,
    };

    channel.sink.add(jsonEncode(message));
    print("Song URL sent: $songUrl");
    //print();
  }


  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      clearSearch();
    }
  }

  void clearSearch() {
    filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
  }

  Future<void> filterSongs(String query) async {
    if (query.isEmpty) {
      clearSearch();
    } else {
      isLoading.value = true;

      final String url = 'https://meet-around-apis-production.up.railway.app/spotify/search?query=$query&limit=10';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          filteredTracks.assignAll(data.map((track) {
            return {
              'name': track['name'],
              'uri': track['url'],
              'images': [{'url': track['image']}],
            };
          }).toList());
        } else {
          Get.snackbar("Error", "Failed to load search results. Status code: ${response.statusCode}");
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred while searching: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }

  void setSelectedSong(String song) {
    selectedSong.value = song;
  }

  void togglePlaying() {
    isPlaying.value = !isPlaying.value;
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
    selectedCategory.value = categories[index];
    filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }

  Future<void> openSpotifyTrack(String spotifyUri, {bool isArtist = false}) async {
    final Uri spotifyUrl = Uri.parse(spotifyUri);
    final Uri spotifyWebUrl = Uri.parse(spotifyUri);
    final Uri playStoreUrl = Uri.parse("https://play.google.com/store/apps/details?id=com.spotify.music");

    try {
      await launchUrl(
        spotifyWebUrl,
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      Get.snackbar("Error", "An error occurred while launching: $e");
    }
  }

  Future<void> fetchSpotifyTracks() async {
    print("The user id that send request is: $userId");
    print("The target user id is: $targetUserId");
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://meet-around-apis-production.up.railway.app/spotify/tracks'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        spotifyTracks.clear();
        categories.clear();
        for (var item in data) {
          spotifyTracks.add({
            'name': item['name'],
            'uri': item['url'],
            'images': [{'url': item['image']}],
            'category': item['category'],
          });

          if (!categories.contains(item['category'])) {
            categories.add(item['category']);
          }
        }

        if (categories.isNotEmpty) {
          selectedCategory.value = categories[0];
          filteredTracks.assignAll(spotifyTracks.where((track) => track['category'] == selectedCategory.value).toList());
        }
      } else {
        Get.snackbar("Error", "Failed to load tracks from Spotify. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching tracks: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
