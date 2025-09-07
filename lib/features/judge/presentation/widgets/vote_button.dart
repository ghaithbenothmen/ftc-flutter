import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ftc_app/core/constants/app_constants.dart';
import 'package:ftc_app/features/judge/application/judge_controller.dart';

class VoteButton extends HookConsumerWidget {
  final VoteType voteType;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled; 
  final VoteType? votedType; 

  const VoteButton({
    super.key,
    required this.voteType,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.votedType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final buttonSize = (screenWidth * 0.45).clamp(220.0, 380.0);
    
    final isLift = voteType == VoteType.lift;
    
    final backgroundColor = isDisabled 
        ? (isLift 
            ? Colors.white.withValues(alpha: 0.3) // Transparent white when disabled
            : const Color(0xFFE53E3E).withValues(alpha: 0.3)) // Transparent red when disabled
        : (isLift ? Colors.white : const Color(0xFFE53E3E));
    
    final shadowColor = isDisabled
        ? Colors.grey.withValues(alpha: 0.1)
        : (isLift 
            ? Colors.white.withValues(alpha: 0.4)
            : const Color(0xFFE53E3E).withValues(alpha: 0.4));
    
    // Border 
    final isClickedButton = isDisabled && votedType == voteType;
    final borderColor = isClickedButton
        ? (isLift ? Colors.white : const Color(0xFFE53E3E)) 
        : (isDisabled 
            ? Colors.transparent 
            : (isLift ? Colors.grey.shade300 : Colors.transparent));
    
    final borderWidth = isClickedButton ? 6.0 : (isLift && !isDisabled ? 2.0 : 0.0); 

    return Container(
      width: buttonSize,
      height: buttonSize,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Material(
        elevation: isDisabled ? 8 : (isLoading ? 4 : 12),
        shadowColor: shadowColor,
        shape: const CircleBorder(),
        child: AnimatedContainer(
          duration: AppConstants.buttonAnimationDuration,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            boxShadow: isDisabled 
                ? [
                    // Glowing effect when voted
                    BoxShadow(
                      color: isLift ? Colors.white.withValues(alpha: 0.8) : const Color(0xFFE53E3E).withValues(alpha: 0.6),
                      blurRadius: 25,
                      spreadRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: InkWell(
            onTap: (isLoading || isDisabled) ? null : onPressed,
            customBorder: const CircleBorder(),
            splashColor: isDisabled ? Colors.transparent : (isLift 
                ? Colors.grey.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.2)),
            highlightColor: isDisabled ? Colors.transparent : (isLift 
                ? Colors.grey.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.1)),
            child: AnimatedSwitcher(
              duration: AppConstants.buttonAnimationDuration,
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        width: buttonSize * 0.3,
                        height: buttonSize * 0.3,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isLift ? Colors.grey.shade600 : Colors.white,
                          ),
                        ),
                      ),
                    )
                  : isDisabled
                      ? const SizedBox.expand() 
                      : const SizedBox.expand(), 
            ),
          ),
        ),
      ),
    );
  }
}

class VoteButtonsWidget extends HookConsumerWidget {
  final Function(VoteType) onVote;

  const VoteButtonsWidget({
    super.key,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    
    
    final judgeState = ref.watch(judgeControllerProvider);
    
    // Determine which vote type was actually cast
    final lastVote = judgeState.votes.isNotEmpty ? judgeState.votes.last : null;
    final votedType = lastVote?.voteType;
    
    final buttonSpacing = (screenWidth * 0.08).clamp(20.0, 40.0);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
       //lift
        VoteButton(
          voteType: VoteType.lift,
          onPressed: () => onVote(VoteType.lift),
          isDisabled: judgeState.hasVoted,
          votedType: votedType, 
        ),
        
        SizedBox(height: buttonSpacing), 
        //nolift
        VoteButton(
          voteType: VoteType.noLift,
          onPressed: () => onVote(VoteType.noLift),
          isDisabled: judgeState.hasVoted,
          votedType: votedType, 
        ),
      ],
    );
  }
}
