import 'dart:async';
import 'package:ftc_app/features/judge/domain/vote.dart';

// Mock repository for sending votes (will be replaced with real API/WebSocket later)
abstract class VoteRepository {
  Future<void> sendVote(Vote vote);
  Stream<Vote> get voteStream;
}

class MockVoteRepository implements VoteRepository {
  final StreamController<Vote> _voteController = StreamController<Vote>.broadcast();

  @override
  Future<void> sendVote(Vote vote) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Mock successful response
    print('📡 Mock: Vote sent to server - ${vote.toString()}');
    
    // Emit the vote to any listeners
    _voteController.add(vote);
  }

  @override
  Stream<Vote> get voteStream => _voteController.stream;

  void dispose() {
    _voteController.close();
  }
}

// Future: Real WebSocket implementation
class WebSocketVoteRepository implements VoteRepository {
  // TODO: Implement WebSocket connection for real-time voting
  // - Connect to PowerLifting server
  // - Send votes in real-time
  // - Listen for other judges' votes
  // - Handle connection errors and reconnection

  @override
  Future<void> sendVote(Vote vote) async {
    throw UnimplementedError('WebSocket implementation coming soon');
  }

  @override
  Stream<Vote> get voteStream => throw UnimplementedError('WebSocket implementation coming soon');
}
