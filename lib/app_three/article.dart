import 'dart:convert';

import 'package:flutter/foundation.dart';

class Article {
  final int id;
  final bool? deleted;
  final String? type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final List<dynamic>? kids;
  final String? url;
  final int? score;
  final String? title;
  final List<dynamic>? parts;
  final int? descendants;

  Article({
    required this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.parts,
    this.descendants,
  });

  Article copyWith({
    int? id,
    bool? deleted,
    String? type,
    String? by,
    int? time,
    String? text,
    bool? dead,
    int? parent,
    List<dynamic>? kids,
    String? url,
    int? score,
    String? title,
    List<dynamic>? parts,
    int? descendants,
  }) {
    return Article(
      id: id ?? this.id,
      deleted: deleted ?? this.deleted,
      type: type ?? this.type,
      by: by ?? this.by,
      time: time ?? this.time,
      text: text ?? this.text,
      dead: dead ?? this.dead,
      parent: parent ?? this.parent,
      kids: kids ?? this.kids,
      url: url ?? this.url,
      score: score ?? this.score,
      title: title ?? this.title,
      parts: parts ?? this.parts,
      descendants: descendants ?? this.descendants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deleted': deleted,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead,
      'parent': parent,
      'kids': kids,
      'url': url,
      'score': score,
      'title': title,
      'parts': parts,
      'descendants': descendants,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id']?.toInt() ?? 0,
      deleted: map['deleted'],
      type: map['type'],
      by: map['by'],
      time: map['time']?.toInt(),
      text: map['text'],
      dead: map['dead'],
      parent: map['parent']?.toInt(),
      kids: map['kids'] == null ? null : List<dynamic>.from(map['kids']),
      url: map['url'],
      score: map['score']?.toInt(),
      title: map['title'],
      parts: map['parts'] == null ? null : List<dynamic>.from(map['parts']),
      descendants: map['descendants']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Article(id: $id, deleted: $deleted, type: $type, by: $by, time: $time, text: $text, dead: $dead, parent: $parent, kids: $kids, url: $url, score: $score, title: $title, parts: $parts, descendants: $descendants)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.id == id &&
        other.deleted == deleted &&
        other.type == type &&
        other.by == by &&
        other.time == time &&
        other.text == text &&
        other.dead == dead &&
        other.parent == parent &&
        listEquals(other.kids, kids) &&
        other.url == url &&
        other.score == score &&
        other.title == title &&
        listEquals(other.parts, parts) &&
        other.descendants == descendants;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deleted.hashCode ^
        type.hashCode ^
        by.hashCode ^
        time.hashCode ^
        text.hashCode ^
        dead.hashCode ^
        parent.hashCode ^
        kids.hashCode ^
        url.hashCode ^
        score.hashCode ^
        title.hashCode ^
        parts.hashCode ^
        descendants.hashCode;
  }
}
