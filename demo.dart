// Demo Script for Powerlifting Judge App
// This file demonstrates the key functionality and architecture

import 'package:ftc_app/core/constants/app_constants.dart';
import 'package:ftc_app/features/judge/domain/vote.dart';
import 'package:ftc_app/features/judge/infrastructure/vote_repository.dart';

void main() {
  demoVoteSystem();
}

void demoVoteSystem() {
  print('🏋️ POWERLIFTING JUDGE APP DEMO');
  print('================================');
  
  // 1. Create judge votes
  print('\n1. Creating sample votes...');
  
  final liftVote = Vote.createLift(
    judgeId: 'judge_001',
    sessionId: 'session_123',
    lifterId: 'athlete_456',
    attemptNumber: 1,
  );
  
  final noLiftVote = Vote.createNoLift(
    judgeId: 'judge_001',
    sessionId: 'session_123',
    lifterId: 'athlete_456',
    attemptNumber: 2,
  );
  
  print('   Lift Vote: ${liftVote.voteType.displayName}');
  print('   No Lift Vote: ${noLiftVote.voteType.displayName}');
  
  // 2. Show vote serialization
  print('\n2. Vote serialization...');
  print('   JSON: ${liftVote.toJson()}');
  
  // 3. Mock repository usage
  print('\n3. Mock repository test...');
  final repository = MockVoteRepository();
  
  // Simulate sending votes
  repository.sendVote(liftVote);
  repository.sendVote(noLiftVote);
  
  // 4. Show constants usage
  print('\n4. App constants...');
  print('   App Name: ${AppConstants.appName}');
  print('   Default Judge: ${AppConstants.defaultJudgeId}');
  print('   Button Animation: ${AppConstants.buttonAnimationDuration}');
  
  print('\n✅ Demo completed! App is ready to run.');
  print('   Run: flutter run -d chrome');
  print('   Or:  flutter run (for mobile device)');
}
