class AppConstants {
  // App Information
  static const String appName = 'Powerlifting Judge';
  static const String appVersion = '1.0.0';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  
  static const double buttonHeight = 80.0;
  static const double buttonWidth = 200.0;
  static const double buttonBorderRadius = 16.0;
  
  // Animation Durations
  static const Duration buttonAnimationDuration = Duration(milliseconds: 150);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  
  // Judge Settings
  static const String defaultJudgeId = 'judge_001';
  
  // Spacing
  static const double buttonSpacing = 32.0;
}

enum VoteType {
  lift,
  noLift,
}

extension VoteTypeExtension on VoteType {
  String get displayName {
    switch (this) {
      case VoteType.lift:
        return 'Lift';
      case VoteType.noLift:
        return 'No Lift';
    }
  }
  
  String get value {
    switch (this) {
      case VoteType.lift:
        return 'lift';
      case VoteType.noLift:
        return 'no_lift';
    }
  }
}
