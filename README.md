# Powerlifting Judge Mobile App

A professional Flutter mobile application for powerlifting judges to cast votes during competitions.

## 🏋️ Features

- **Modern & Minimal UI**: Clean interface with two primary voting buttons
- **Professional State Management**: Uses Riverpod for scalable state management
- **Material 3 Design**: Modern design principles with light/dark theme support
- **Responsive Design**: Optimized for mobile devices with portrait orientation
- **Clean Architecture**: Structured with domain, application, presentation, and infrastructure layers

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/        # App constants and enums
│   └── theme/           # Theme configuration
├── features/
│   └── judge/
│       ├── domain/      # Vote model and entities
│       ├── application/ # State management (Riverpod providers)
│       ├── presentation/# UI screens and widgets
│       └── infrastructure/ # Repository patterns (future API/WebSocket)
└── shared/
    └── widgets/         # Reusable UI components
```

## 📱 UI Components

### Main Voting Screen
- **Judge Information**: Display current judge ID
- **Vote Buttons**: 
  - "LIFT" - White button with green check icon
  - "NO LIFT" - Red button with red cross icon
- **Vote History**: Shows last vote and vote count
- **Settings**: Floating action button to change judge ID

### Vote Buttons
- Large, centered, responsive design
- Rounded corners with shadows
- Loading states with animations
- Visual feedback for different vote types

## 🔧 Dependencies

- `flutter_riverpod` - State management
- `hooks_riverpod` - Riverpod with Flutter Hooks
- `flutter_hooks` - Widget lifecycle management
- `freezed` & `json_annotation` - Model code generation (ready for future use)

## 🚀 Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the app**:
   ```bash
   flutter run
   ```

3. **For code generation** (when using Freezed models):
   ```bash
   flutter packages pub run build_runner build
   ```

## 📝 Usage

1. **Cast Votes**: Tap "LIFT" for good lifts or "NO LIFT" for failed attempts
2. **View History**: See vote count in the app bar and last vote status
3. **Change Judge ID**: Tap the settings button to update judge identifier
4. **Reset Session**: Use the refresh button to clear all votes

## 🔮 Future Enhancements

- **Real-time Communication**: WebSocket integration for live judging sessions
- **Multiple Judges**: Support for 3-judge panels with vote aggregation
- **Competition Management**: Integration with lift attempts and athlete data
- **Video Review**: Slow-motion replay integration
- **Statistics**: Vote analytics and performance tracking

## 🎯 Vote State Management

The app uses a clean state management pattern:

```dart
// Vote Model
class Vote {
  final String judgeId;
  final VoteType voteType;  // lift | noLift
  final DateTime timestamp;
  // ... additional fields
}

// State Controller
class JudgeController extends StateNotifier<JudgeState> {
  // Cast vote with loading states
  Future<void> castVote(VoteType voteType) async { ... }
  
  // Reset session
  void resetSession() { ... }
}
```

## 🎨 Theming

- **Light Theme**: Clean white backgrounds with green/red accents
- **Dark Theme**: Dark surfaces with consistent color schemes
- **Material 3**: Modern design language with proper elevation and typography
- **Custom Components**: Consistent styling across all UI elements

## 🧪 Current State

This is the **foundation phase** of the larger Powerlifting Judging System. The app currently:

- ✅ Displays voting interface
- ✅ Manages vote state with Riverpod
- ✅ Logs votes to console (temporary)
- ✅ Provides settings for judge configuration
- 🔄 Ready for backend integration
- 🔄 Prepared for real-time communication

## 📄 License

This project is part of a professional powerlifting judging system development.

---

**Note**: Print statements are used for development/debugging and will be replaced with proper logging and backend communication in future iterations.
