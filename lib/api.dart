import 'dart:convert';

import 'package:http/http.dart' as http;

import 'constants.dart';
import 'models/video.dart';

class API {
  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  Future<List<Video>> loadNextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      var videos = decoded["items"].map<Video>((v) {
        return Video.fromJson(v);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
