import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';
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

  //late WebSocketChannel channel;
  // final int userId;
  // int? targetUserId;

  // Constructor
  //JammingScreenController() {}
  // print(
  //     "JammingScreenController initialized with userId:$userId and targetUserId: $targetUserId");
  /* final int userId;

  final int targetUserId;

  //JammingScreenController(this.targetUserId, {required this.userId});
  JammingScreenController(this.userId, this.targetUserId);*/

  @override
  void onInit() {
    super.onInit();
    fetchSpotifyTracks();
  }

  /* @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }*/
  ///WEBSOCKETS v1
/*
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
*/
  ///WEBSOCKETS v1

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      clearSearch();
    }
  }

  void clearSearch() {
    filteredTracks.assignAll(spotifyTracks
        .where((track) => track['category'] == selectedCategory.value)
        .toList());
  }

  Future<void> filterSongs(String query) async {
    if (query.isEmpty) {
      clearSearch();
    } else {
      isLoading.value = true;

      final String url =
          'https://meet-around-apis-production.up.railway.app/spotify/search?query=$query&limit=10';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          filteredTracks.assignAll(data.map((track) {
            return {
              'name': track['name'],
              'uri': track['url'],
              'images': [
                {'url': track['image']}
              ],
            };
          }).toList());
        } else {
          Get.snackbar("Error",
              "Failed to load search results. Status code: ${response.statusCode}");
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
    filteredTracks.assignAll(spotifyTracks
        .where((track) => track['category'] == selectedCategory.value)
        .toList());
  }

  void setSelectedSongIndex(int index) {
    selectedSongIndex.value = index;
  }

/*  Future<void> openSpotifyTrack(String spotifyUri, {bool isArtist = false}) async {
    final Uri spotifyUrl = Uri.parse(spotifyUri);
    final Uri spotifyWebUrl = Uri.parse(spotifyUri);
    final Uri playStoreUrl = Uri.parse("https://play.google.com/store/apps/details?id=com.spotify.music");

    try {
      print("Launching spotify webview");
      await launchUrl(
        spotifyWebUrl,
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      Get.snackbar("Error", "An error occurred while launching: $e");
    }
  }*/

  Future<void> openSpotifyTrack(String spotifyUri) async {
    Get.to(() => SpotifyWebView(spotifyUri: spotifyUri));
  }

  Future<void> fetchSpotifyTracks() async {
    // print("The user id that send request is: $userId");
    // print("The target user id is: $targetUserId");
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
            'https://meet-around-apis-production.up.railway.app/spotify/tracks'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        print("the response of TRACK API is: $data");
        spotifyTracks.clear();
        categories.clear();
        for (var item in data) {
          spotifyTracks.add({
            'name': item['name'],
            'uri': item['url'],
            'images': [
              {'url': item['image']}
            ],
            'category': item['category'],
          });

          if (!categories.contains(item['category'])) {
            categories.add(item['category']);
          }
        }

        if (categories.isNotEmpty) {
          selectedCategory.value = categories[0];
          filteredTracks.assignAll(spotifyTracks
              .where((track) => track['category'] == selectedCategory.value)
              .toList());
        }
      } else {
        Get.snackbar("Error",
            "Failed to load tracks from Spotify. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching tracks: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

class SpotifyWebView extends StatefulWidget {
  final String spotifyUri;

  SpotifyWebView({required this.spotifyUri});

  @override
  _SpotifyWebViewState createState() => _SpotifyWebViewState();
}

class _SpotifyWebViewState extends State<SpotifyWebView> {
  late final WebViewController _controller;
  bool _pageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _pageLoaded = true;
              });
            }

            // Inject JavaScript to check for the audio element and play the song
            _controller.runJavaScript('''
              (function() {
                var tryToPlay = function() {
                  var audioElement = document.querySelector('audio');
                  if (audioElement) {
                    audioElement.play().catch(function(error) {
                      console.log('Autoplay was prevented: ', error);
                    });
                  } else {
                    setTimeout(tryToPlay, 500); // Try again after 500ms if audio element isn't found
                  }
                };
                tryToPlay();
              })();
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.spotifyUri));
  }

  @override
  void dispose() {
    _stopJamming();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //_showCancelJammingDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Spotify"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _showCancelJammingDialog(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _pageLoaded
                      ? WebViewWidget(controller: _controller)
                      : SizedBox.shrink(),
                ),
                Container(
                  color: Color(0xFFFF69B4),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF69B4),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      _showCancelJammingDialog(context);
                    },
                    child: Text(
                      "Cancel Jamming",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            if (!_pageLoaded)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _showCancelJammingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Jamming'),
          content: Text('Do you really want to cancel jamming?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _stopJamming();
                Navigator.of(context).pop(); // Dismiss the dialog
                Get.back(); // Go back to the previous screen
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _stopJamming() {
    // Run JavaScript to stop the audio playback
    _controller.runJavaScript('''
      var audioElement = document.querySelector('audio');
      if (audioElement) {
        audioElement.pause();
        audioElement.currentTime = 0;
      }
    ''').then((_) {
      if (mounted) {
        // Ensure the widget is still mounted before calling setState
        setState(() {
          _pageLoaded = false;
        });
      }
    });
  }
}
