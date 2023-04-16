import 'dart:convert';

import 'package:chat_pot/models/auth_response.dart';
import 'package:flutter/foundation.dart';

class PostResponse {
  final bool? success;
  final MyPost? myPost;
  PostResponse({
    this.success,
    this.myPost,
  });

  PostResponse copyWith({
    bool? success,
    MyPost? myPost,
  }) {
    return PostResponse(
      success: success ?? this.success,
      myPost: myPost ?? this.myPost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'myPost': myPost?.toMap(),
    };
  }

  factory PostResponse.fromMap(Map<String, dynamic> map) {
    return PostResponse(
      success: map['success'],
      myPost: map['myPost'] != null ? MyPost.fromMap(map['myPost']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostResponse.fromJson(String source) =>
      PostResponse.fromMap(json.decode(source));

  @override
  String toString() => 'PostResponse(success: $success, myPost: $myPost)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostResponse &&
        other.success == success &&
        other.myPost == myPost;
  }

  @override
  int get hashCode => success.hashCode ^ myPost.hashCode;
}

class MyPostResponse {
  final bool? success;
  final List<MyPost>? myPost;

  MyPostResponse({
    this.success,
    this.myPost,
  });

  MyPostResponse copyWith({
    bool? success,
    List<MyPost>? myPost,
    User? user,
  }) {
    return MyPostResponse(
      success: success ?? this.success,
      myPost: myPost ?? this.myPost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'myPost': myPost?.map((x) => x.toMap()).toList(),
    };
  }

  factory MyPostResponse.fromMap(Map<String, dynamic> map) {
    return MyPostResponse(
      success: map['success'],
      myPost: map['myPost'] != null
          ? List<MyPost>.from(map['myPost']?.map((x) => MyPost.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPostResponse.fromJson(String source) =>
      MyPostResponse.fromMap(json.decode(source));

  @override
  String toString() => 'MyPostResponse(success: $success, myPost: $myPost)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyPostResponse &&
        other.success == success &&
        listEquals(other.myPost, myPost);
  }

  @override
  int get hashCode => success.hashCode ^ myPost.hashCode;
}

class MyPost {
  final String? id;
  final String? message;
  final List<String>? photos;

  final User? user;
  MyPost({
    this.id,
    this.message,
    this.photos,
    this.user,
  });

  MyPost copyWith({
    String? id,
    String? message,
    List<String>? photos,
    User? user,
  }) {
    return MyPost(
      message: message ?? this.message,
      photos: photos ?? this.photos,
      user: user ?? this.user,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'photos': photos,
      'user': user,
    };
  }

  factory MyPost.fromMap(Map<String, dynamic> map) {
    return MyPost(
      id: map['_id'],
      message: map['message'],
      photos: List<String>.from(map['photos']),
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPost.fromJson(String source) => MyPost.fromMap(json.decode(source));

  @override
  String toString() =>
      'MyPost(message: $message, photos: $photos, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyPost &&
        other.message == message &&
        listEquals(other.photos, photos) &&
        other.user == user;
  }

  @override
  int get hashCode => message.hashCode ^ photos.hashCode ^ user.hashCode;
}
