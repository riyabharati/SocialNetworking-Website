import 'dart:convert';

class SuccessResponse {
  final bool? success;
  final String? message;
  SuccessResponse({
    this.success,
    this.message,
  });

  SuccessResponse copyWith({
    bool? success,
    String? message,
  }) {
    return SuccessResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory SuccessResponse.fromMap(Map<String, dynamic> map) {
    return SuccessResponse(
      success: map['success'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SuccessResponse.fromJson(String source) =>
      SuccessResponse.fromMap(json.decode(source));

  @override
  String toString() => 'SuccessResponse(status: $success)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuccessResponse && other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}
