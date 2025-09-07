import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftc_app/core/constants/app_constants.dart';
import 'package:ftc_app/features/judge/domain/vote.dart';

// State for the current judge session
@immutable
class JudgeState {
  final String judgeId;
  final List<Vote> votes;
  final bool isVoting;
  final Vote? lastVote;
  final bool hasVoted; // New field to track if judge has voted for current attempt

  const JudgeState({
    required this.judgeId,
    this.votes = const [],
    this.isVoting = false,
    this.lastVote,
    this.hasVoted = false,
  });

  JudgeState copyWith({
    String? judgeId,
    List<Vote>? votes,
    bool? isVoting,
    Vote? lastVote,
    bool? hasVoted,
  }) {
    return JudgeState(
      judgeId: judgeId ?? this.judgeId,
      votes: votes ?? this.votes,
      isVoting: isVoting ?? this.isVoting,
      lastVote: lastVote ?? this.lastVote,
      hasVoted: hasVoted ?? this.hasVoted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JudgeState &&
        other.judgeId == judgeId &&
        other.votes == votes &&
        other.isVoting == isVoting &&
        other.lastVote == lastVote &&
        other.hasVoted == hasVoted;
  }

  @override
  int get hashCode {
    return judgeId.hashCode ^
        votes.hashCode ^
        isVoting.hashCode ^
        lastVote.hashCode ^
        hasVoted.hashCode;
  }
}

// Judge Controller using StateNotifier
class JudgeController extends StateNotifier<JudgeState> {
  JudgeController({String? judgeId})
      : super(JudgeState(
          judgeId: judgeId ?? AppConstants.defaultJudgeId,
        ));

  // Cast a vote (Lift or No Lift) - Only once per attempt
  Future<void> castVote(VoteType voteType) async {
    // Prevent voting if already voted
    if (state.hasVoted) {
      print('⚠️ Judge has already voted for this attempt');
      return;
    }

    // Set voting state to true
    state = state.copyWith(isVoting: true);

    try {
      // Simulate processing delay (for UI feedback)
      await Future.delayed(const Duration(milliseconds: 300));

      // Create the vote
      final vote = Vote(
        judgeId: state.judgeId,
        voteType: voteType,
        timestamp: DateTime.now(),
      );

      // Update state with new vote and mark as voted
      final updatedVotes = [...state.votes, vote];
      state = state.copyWith(
        votes: updatedVotes,
        lastVote: vote,
        isVoting: false,
        hasVoted: true, // Mark as voted
      );

      // Log the action (temporary - will be replaced with actual event sending)
      _logVoteAction(vote);
      
      // TODO: Send vote to backend/WebSocket
      // await _sendVoteToBackend(vote);
      
    } catch (error) {
      // Handle error
      state = state.copyWith(isVoting: false);
      print('Error casting vote: $error');
    }
  }

  // Helper method to log vote actions
  void _logVoteAction(Vote vote) {
    print('🏋️ JUDGE VOTE CAST:');
    print('  Judge ID: ${vote.judgeId}');
    print('  Vote: ${vote.voteType.displayName}');
    print('  Timestamp: ${vote.timestamp.toIso8601String()}');
    print('---');
  }

  // Reset judge session (clear all votes)
  void resetSession() {
    state = JudgeState(judgeId: state.judgeId);
    print('🔄 Judge session reset');
  }

  // Prepare for new attempt (reset hasVoted but keep history)
  void prepareNewAttempt() {
    state = state.copyWith(hasVoted: false);
    print('🆕 Prepared for new attempt - voting enabled');
  }

  // Change judge ID
  void setJudgeId(String newJudgeId) {
    state = state.copyWith(judgeId: newJudgeId);
    print('👨‍⚖️ Judge ID changed to: $newJudgeId');
  }
}

// Provider for the Judge Controller
final judgeControllerProvider = StateNotifierProvider<JudgeController, JudgeState>(
  (ref) => JudgeController(),
);

// Helper providers for easy access to specific state parts
final isVotingProvider = Provider<bool>((ref) {
  return ref.watch(judgeControllerProvider).isVoting;
});

final lastVoteProvider = Provider<Vote?>((ref) {
  return ref.watch(judgeControllerProvider).lastVote;
});

final voteCountProvider = Provider<int>((ref) {
  return ref.watch(judgeControllerProvider).votes.length;
});
