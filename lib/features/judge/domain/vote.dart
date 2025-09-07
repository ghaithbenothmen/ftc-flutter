import 'package:ftc_app/core/constants/app_constants.dart';

// Simple Vote model (can be enhanced with Freezed later)
class Vote {
  final String judgeId;
  final VoteType voteType;
  final DateTime timestamp;
  final String? sessionId;
  final String? lifterId;
  final int? attemptNumber;

  const Vote({
    required this.judgeId,
    required this.voteType,
    required this.timestamp,
    this.sessionId,
    this.lifterId,
    this.attemptNumber,
  });

  // Factory methods for easy creation
  static Vote createLift({
    required String judgeId,
    String? sessionId,
    String? lifterId,
    int? attemptNumber,
  }) {
    return Vote(
      judgeId: judgeId,
      voteType: VoteType.lift,
      timestamp: DateTime.now(),
      sessionId: sessionId,
      lifterId: lifterId,
      attemptNumber: attemptNumber,
    );
  }

  static Vote createNoLift({
    required String judgeId,
    String? sessionId,
    String? lifterId,
    int? attemptNumber,
  }) {
    return Vote(
      judgeId: judgeId,
      voteType: VoteType.noLift,
      timestamp: DateTime.now(),
      sessionId: sessionId,
      lifterId: lifterId,
      attemptNumber: attemptNumber,
    );
  }

  // Convert to Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'judgeId': judgeId,
      'voteType': voteType.value,
      'timestamp': timestamp.toIso8601String(),
      'sessionId': sessionId,
      'lifterId': lifterId,
      'attemptNumber': attemptNumber,
    };
  }

  // Create from Map for JSON deserialization
  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      judgeId: json['judgeId'] as String,
      voteType: json['voteType'] == 'lift' ? VoteType.lift : VoteType.noLift,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sessionId: json['sessionId'] as String?,
      lifterId: json['lifterId'] as String?,
      attemptNumber: json['attemptNumber'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vote &&
        other.judgeId == judgeId &&
        other.voteType == voteType &&
        other.timestamp == timestamp &&
        other.sessionId == sessionId &&
        other.lifterId == lifterId &&
        other.attemptNumber == attemptNumber;
  }

  @override
  int get hashCode {
    return judgeId.hashCode ^
        voteType.hashCode ^
        timestamp.hashCode ^
        sessionId.hashCode ^
        lifterId.hashCode ^
        attemptNumber.hashCode;
  }

  @override
  String toString() {
    return 'Vote(judgeId: $judgeId, voteType: $voteType, timestamp: $timestamp)';
  }
}
