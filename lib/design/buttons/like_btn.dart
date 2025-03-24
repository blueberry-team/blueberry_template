import 'package:flutter/material.dart';

/// 좋아요 버튼 컴포넌트
class LikeBtn extends StatefulWidget {
  /// 좋아요 개수
  final int likeCount;

  /// 좋아요 상태 (활성화 여부)
  final bool isLiked;

  /// 애니메이션 표시 여부
  final bool isAnimated;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// LikeButton 생성자
  const LikeBtn({
    super.key,
    required this.likeCount,
    this.isLiked = false,
    this.isAnimated = true,
    this.onPressed,
  });

  @override
  State<LikeBtn> createState() => _LikeBtnState();
}

class _LikeBtnState extends State<LikeBtn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  final List<_HeartIcon> _hearts = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeOut),
        reverseCurve: const Interval(0.3, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addHeart() {
    if (!widget.isAnimated) return;

    setState(() {
      _hearts.add(
        _HeartIcon(
          key: UniqueKey(),
          onComplete: () {
            setState(() {
              _hearts.removeAt(0);
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        TextButton.icon(
          onPressed: () {
            widget.onPressed?.call();
            if (widget.isAnimated) {
              _controller.forward().then((_) => _controller.reverse());
            }
            _addHeart();
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          icon:
              widget.isAnimated
                  ? ScaleTransition(
                    scale: _scaleAnimation,
                    child: Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color:
                          widget.isLiked
                              ? Colors.red.withAlpha(200)
                              : colorScheme.onSurface,
                    ),
                  )
                  : Icon(
                    widget.isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                    color:
                        widget.isLiked
                            ? Colors.red.withAlpha(200)
                            : colorScheme.onSurface,
                  ),
          label: Text('${widget.likeCount}'),
        ),
        if (widget.isAnimated) ..._hearts,
      ],
    );
  }
}

class _HeartIcon extends StatefulWidget {
  final VoidCallback onComplete;

  const _HeartIcon({required Key key, required this.onComplete})
    : super(key: key);

  @override
  State<_HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<_HeartIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Icon(Icons.favorite, size: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
