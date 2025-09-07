import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ftc_app/core/constants/app_constants.dart';
import 'package:ftc_app/core/presentation/widgets/app_header_widget.dart';
import 'package:ftc_app/core/presentation/widgets/app_background_widget.dart';
import 'package:ftc_app/features/judge/application/judge_controller.dart';
import 'package:ftc_app/features/judge/presentation/widgets/vote_button.dart';

class JudgeScreen extends HookConsumerWidget {
  const JudgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final judgeState = ref.watch(judgeControllerProvider);
    final judgeController = ref.read(judgeControllerProvider.notifier);
    
    return Scaffold(
      appBar: AppHeaderWidget(
        title: 'Judge: ${judgeState.judgeId}',
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/ftc_logo.png',
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              // Fallback icon if logo not found
              return const Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 32,
              );
            },
          ),
        ),
      ),
      body: AppBackgroundWidget(
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            children: [
              // Voting buttons section - Main area
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: AppConstants.buttonAnimationDuration,
                    child: judgeState.isVoting
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(strokeWidth: 3),
                              SizedBox(height: 16),
                              Text(
                                'Casting Vote...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : VoteButtonsWidget(
                            onVote: (voteType) async {
                              await judgeController.castVote(voteType);
                            },
                          ),
                  ),
                ),
              ),
              
            
            ],
          ),
        ),
      ),
      ),
      // Floating action button for settings (future use)
    );
  }
}
