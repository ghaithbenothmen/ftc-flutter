import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ftc_app/core/constants/app_constants.dart';
import 'package:ftc_app/core/presentation/widgets/app_header_widget.dart';
import 'package:ftc_app/core/presentation/widgets/app_background_widget.dart';
import 'package:ftc_app/features/judge/application/judge_controller.dart';
import 'package:ftc_app/features/judge/presentation/screens/judge_screen.dart';

/// Écran de sélection du rôle de juge (Left, Center, Right)
class RoleSelectionScreen extends HookConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth * 0.8).clamp(250.0, 400.0);
    
    return Scaffold(
      appBar: const AppHeaderWidget(
        title: 'Select Judge Role',
        automaticallyImplyLeading: false,
      ),
      body: AppBackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Column(
              children: [
                // Titre principal
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.1),
                        Colors.transparent,
                        Colors.red.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'POWERLIFTING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          shadows: [
                            Shadow(
                              color: Colors.red,
                              offset: Offset(2, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      SizedBox(height: 8),
                      
                      Text(
                        'JUDGE SYSTEM',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                const Text(
                  'Select Your Position',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 20),
                
                // Boutons de sélection de rôle - Zone principale
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    // Left Judge
                    _buildModernRoleButton(
                      context: context,
                      ref: ref,
                      role: 'LEFT',
                      judgeId: 'judge_left',
                      gradientColors: [
                        const Color(0xFFDC2626),
                        const Color(0xFF991B1B), 
                        const Color(0xFF450A0A),
                      ],
                      width: buttonWidth,
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Center Judge
                    _buildModernRoleButton(
                      context: context,
                      ref: ref,
                      role: 'CENTER',
                      judgeId: 'judge_center',
                      gradientColors: [
                        const Color(0xFFDC2626),
                        const Color(0xFF991B1B), 
                        const Color(0xFF450A0A), 
                      ],
                      width: buttonWidth,
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Right Judge
                    _buildModernRoleButton(
                      context: context,
                      ref: ref,
                      role: 'RIGHT',
                      judgeId: 'judge_right',
                      gradientColors: [
                        const Color(0xFFDC2626),
                        const Color(0xFF991B1B), 
                        const Color(0xFF450A0A),
                      ],
                      width: buttonWidth,
                    ),
                      ],
                    ),
                  ),
                ),
                
                // Information en bas
               
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernRoleButton({
    required BuildContext context,
    required WidgetRef ref,
    required String role,
    required String judgeId,
    required List<Color> gradientColors,
    required double width,
  }) {
    return Container(
      width: width,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectRole(context, ref, judgeId),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Position indicator
                Container(
                  width: 8,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Role text
                Expanded(
                  child: Text(
                    role,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Judge text
                Text(
                  'JUDGE',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectRole(BuildContext context, WidgetRef ref, String judgeId) {
    // Définir l'ID du juge dans le contrôleur
    final judgeController = ref.read(judgeControllerProvider.notifier);
    judgeController.setJudgeId(judgeId);
    
    // Naviguer vers l'écran de jugement
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const JudgeScreen(),
      ),
    );
  }
}
