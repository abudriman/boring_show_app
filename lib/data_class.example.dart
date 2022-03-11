import 'dart:convert';

import 'package:equatable/equatable.dart';

class Dog {
  //field
  final String breed;
  final String name;
  final String furColor;
  final int height;

  Dog({
    required this.breed,
    required this.name,
    required this.furColor,
    required this.height,
  });

  Dog copyWith({
    String? breed,
    String? name,
    String? furColor,
    int? height,
  }) {
    return Dog(
      breed: breed ?? this.breed,
      name: name ?? this.name,
      furColor: furColor ?? this.furColor,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'breed': breed,
      'name': name,
      'furColor': furColor,
      'height': height,
    };
  }

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      breed: map['breed'] ?? '',
      name: map['name'] ?? '',
      furColor: map['furColor'] ?? '',
      height: map['height']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dog.fromJson(String source) => Dog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Dog(breed: $breed, name: $name, furColor: $furColor, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dog &&
        other.breed == breed &&
        other.name == name &&
        other.furColor == furColor &&
        other.height == height;
  }

  @override
  int get hashCode {
    return breed.hashCode ^ name.hashCode ^ furColor.hashCode ^ height.hashCode;
  }
}

class Cat extends Equatable {
  final String breed;
  final String name;
  final String furColor;
  final int height;

  const Cat({
    required this.breed,
    required this.name,
    required this.furColor,
    required this.height,
  });

  Cat copyWith({
    String? breed,
    String? name,
    String? furColor,
    int? height,
  }) {
    return Cat(
      breed: breed ?? this.breed,
      name: name ?? this.name,
      furColor: furColor ?? this.furColor,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'breed': breed,
      'name': name,
      'furColor': furColor,
      'height': height,
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      breed: map['breed'] ?? '',
      name: map['name'] ?? '',
      furColor: map['furColor'] ?? '',
      height: map['height']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cat.fromJson(String source) => Cat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cat(breed: $breed, name: $name, furColor: $furColor, height: $height)';
  }

  @override
  List<Object> get props => [breed, name, furColor, height];
}
