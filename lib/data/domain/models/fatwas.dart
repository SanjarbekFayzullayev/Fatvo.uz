class FatwasModel {
  int? count;
  int? pagesCount;
  String? next;
  dynamic previous;
  List<Results>? results;

  FatwasModel(
      {this.count, this.pagesCount, this.next, this.previous, this.results});

  FatwasModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pagesCount = json['pages_count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['count'] = this.count;
    data['pages_count'] = this.pagesCount;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? id;
  String? slug;
  String? title;
  String? truncatedQuestion;
  String? truncatedAnswer;
  int? view;
  String? updatedAt;

  Results(
      {this.id,
        this.slug,
        this.title,
        this.truncatedQuestion,
        this.truncatedAnswer,
        this.view,
        this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    truncatedQuestion = json['truncated_question'];
    truncatedAnswer = json['truncated_answer'];
    view = json['view'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['truncated_question'] = this.truncatedQuestion;
    data['truncated_answer'] = this.truncatedAnswer;
    data['view'] = this.view;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
