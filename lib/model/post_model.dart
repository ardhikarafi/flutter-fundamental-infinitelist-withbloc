part of 'model.dart';

class PostModel {
  String id, title, body;

  PostModel({this.id, this.title, this.body});

  factory PostModel.fromJSON(Map<String, dynamic> object) {
    return PostModel(
      id: object["id"],
      title: object["title"],
      body: object["body"],
    );
  }

  static Future<List<PostModel>> konekToAPI(int start, int limit) async {
    String apiURL = "https://jsonplaceholder.typicode.com/posts?_start=" +
        start.toString() +
        "&_limit" +
        limit.toString();
    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body) as List;

    return jsonObject
        .map<PostModel>((item) => PostModel(
            id: item["id"].toString(),
            title: item["title"],
            body: item["body"]))
        .toList();
  }
}
