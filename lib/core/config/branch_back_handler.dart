import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BranchBackHandler extends StatefulWidget {
  final Widget child;
  final bool isHome;

  const BranchBackHandler({
    super.key,
    required this.child,
    this.isHome = false,
  });

  @override
  State<BranchBackHandler> createState() => _BranchBackHandlerState();
}

class _BranchBackHandlerState extends State<BranchBackHandler> {


  void _handleBack() {
    // ============================================================
    // اگر Home نیستیم → Home
    // ============================================================

    if (!widget.isHome) {
      context.go('/Home_screen');
      return;
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        _handleBack();
      },
      child: widget.child,
    );
  }
}
