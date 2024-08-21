// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class SpotifyService {
//   final String token = 'BQCmMlkA-vsVQWDhx0r2ztrccSAJToMkb_jI6gL7tkckBfV9E1St03BmamiQ4-LK-7zozetFBlzbVdUJTu90U3jTQABiX5Oq9G3nhJKd4LMn91jRt7SdQVkAWzym5mF9Pp7q9WvdIC-toTdtM3gyUPadSlVhsfD64MF2BTipsqAiFgNrsQ_xEPqSWCS88oucdbDBGqKnTHKYy_UF1HSH_NAuW_W4JQBGGUE2-uvafZcrprAqNo7zOwnAySTDAKOUWiJLf9C2-TyOWet7gYaldtgLUwY3Sw';

//   Future<Map<String, dynamic>> fetchWebApi(String endpoint, String method, [Map<String, dynamic>? body]) async {
//     final response = await (method == 'GET'
//         ? http.get(Uri.parse('https://api.spotify.com/$endpoint'), headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     })
//         : http.post(Uri.parse('https://api.spotify.com/$endpoint'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(body)));

//     return json.decode(response.body);
//   }

//   Future<List<Map<String, dynamic>>> getTopTracks() async {
//     final response = await fetchWebApi('v1/me/top/tracks?time_range=long_term&limit=5', 'GET');
//     return List<Map<String, dynamic>>.from(response['items']);
//   }

//   Future<List<Map<String, dynamic>>> getRecommendations(List<String> seedTrackIds) async {
//     final response = await fetchWebApi(
//         'v1/recommendations?limit=5&seed_tracks=${seedTrackIds.join(',')}', 'GET');
//     return List<Map<String, dynamic>>.from(response['tracks']);
//   }

//   Future<Map<String, dynamic>> createPlaylist(List<String> tracksUri) async {
//     final user = await fetchWebApi('v1/me', 'GET');
//     final userId = user['id'];
//     final playlist = await fetchWebApi(
//         'v1/users/$userId/playlists', 'POST',
//         {
//           'name': 'My recommendation playlist',
//           'description': 'Playlist created by the tutorial on developer.spotify.com',
//           'public': false,
//         });
//     await fetchWebApi(
//         'v1/playlists/${playlist['id']}/tracks?uris=${tracksUri.join(',')}', 'POST');
//     return playlist;
//   }

//   Future<void> connectToSpotifyRemote(String clientId, String redirectUri) async {
//     await SpotifySdk.connectToSpotifyRemote(clientId: clientId, redirectUrl: redirectUri);
//   }

//   Future<void> play(String spotifyUri) async {
//     await SpotifySdk.play(spotifyUri: spotifyUri);
//   }

//   Future<void> pause() async {
//     await SpotifySdk.pause();
//   }

//   Future<void> resume() async {
//     await SpotifySdk.resume();
//   }

//   Future<Stream<PlayerState>> subscribePlayerState() async {
//     return SpotifySdk.subscribePlayerState();
//   }
// }
