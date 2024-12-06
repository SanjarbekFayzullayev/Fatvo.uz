class MyQuestions {
  String? title;
  String? question;
  String? answer;
  String? slug;
  Category? category;
  Questioner? questioner;
  bool? isAnswered;
  String? attachedFile;
  int? view;
  String? createdAt;
  String? updatedAt;

  MyQuestions(
      {this.title,
        this.question,
        this.answer,
        this.slug,
        this.category,
        this.questioner,
        this.isAnswered,
        this.attachedFile,
        this.view,
        this.createdAt,
        this.updatedAt});

  MyQuestions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    question = json['question'];
    answer = json['answer'];
    slug = json['slug'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    questioner = json['questioner'] != null
        ? new Questioner.fromJson(json['questioner'])
        : null;
    isAnswered = json['is_answered'];
    attachedFile = json['attached_file'];
    view = json['view'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['slug'] = this.slug;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.questioner != null) {
      data['questioner'] = this.questioner!.toJson();
    }
    data['is_answered'] = this.isAnswered;
    data['attached_file'] = this.attachedFile;
    data['view'] = this.view;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  String? translations;
  String? slug;

  Category({this.translations, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    translations = json['translations'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translations'] = this.translations;
    data['slug'] = this.slug;
    return data;
  }
}

class Questioner {
  int? id;
  String? firstName;
  String? lastName;

  Questioner({this.id, this.firstName, this.lastName});

  Questioner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
