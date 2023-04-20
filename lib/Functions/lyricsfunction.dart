import 'package:as_player/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:as_player/Screens/playingnow.dart';

// return getLyrics(audioPlayer.getCurrentAudioTitle, audioPlayer.getCurrentAudioArtist);

void lyricsBottom(context, titlename, artistname) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: Colors.black.withOpacity(.7),
        contentTextStyle: const TextStyle(color: Colors.white),
        content: FutureBuilder(
          future: getLyrics(titlename, artistname),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(snapshot.data!),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                child: const Center(
                  child: Text(
                    'Failed to load lyrics',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ]),
  );
}

// Future<String> getLyrics(String songName, String artistName) async {
//   const musixmatchApiKey = '951bb5b3014ba8bf553411374865e6b8';
//   final searchResponse = await http.get(
//     Uri.parse(
//         'https://api.musixmatch.com/ws/1.1/track.search?q_track=$songName&q_artist=$artistName&apikey=$musixmatchApiKey'),
//   );

//   if (searchResponse.statusCode == 200) {
//     final searchBody = json.decode(searchResponse.body);
//     final trackId =
//         searchBody['message']['body']['track_list'][0]['track']['track_id'];

//     final lyricsResponse = await http.get(
//       Uri.parse(
//           'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$musixmatchApiKey'),
//     );

//     if (lyricsResponse.statusCode == 200) {
//       final lyricsBody = json.decode(lyricsResponse.body);
//       final lyrics = lyricsBody['message']['body']['lyrics']['lyrics_body'];
//       return lyrics;
//     }
//   }

//   throw Exception('Failed to load lyrics');
// }
Future getLyrics(String songName, String artistName) async {
  const apiKey = '605a5382d4c7031ed33ffed6ab6cf941';
  final response = await http.get(Uri.parse(
      'https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?apikey=$apiKey&q_track=$songName&q_artist=$artistName'));
  if (response.statusCode == 200) {
    final lyricsResponse = jsonDecode(response.body);
    final lyrics = lyricsResponse['message']['body']['lyrics']['lyrics_body'];
    return lyrics;
  } else {
    const text = Text('Failed to fetch lyrics');
    return text;
 }
}
