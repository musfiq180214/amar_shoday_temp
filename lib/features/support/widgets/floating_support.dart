// widgets/floating_support.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingSupportController {
  static final FloatingSupportController _instance =
      FloatingSupportController._internal();
  factory FloatingSupportController() => _instance;
  FloatingSupportController._internal();

  Offset position = const Offset(300, 425);
  bool isOpen = false;

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) => _listeners.add(listener);
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  void updatePosition(Offset newPosition) {
    position = newPosition;
    for (var listener in _listeners) listener();
  }

  void togglePopup() {
    isOpen = !isOpen;
    for (var listener in _listeners) listener();
  }
}

class FloatingSupport extends StatefulWidget {
  const FloatingSupport({super.key});

  @override
  State<FloatingSupport> createState() => _FloatingSupportState();
}

class _FloatingSupportState extends State<FloatingSupport>
    with SingleTickerProviderStateMixin {
  final FloatingSupportController _controller = FloatingSupportController();

  late AnimationController _animationController;
  late Animation<double> _popupAnimation;

  final String contactNumber = "+8801827741300";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _popupAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _controller.addListener(() {
      if (!mounted) return;

      if (_controller.isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () => _controller.togglePopup(),
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.blue,
        ),
        child: Center(
          child: Image.asset(
            "assets/support.png",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _callNumber() async {
    final Uri callUri = Uri(scheme: 'tel', path: contactNumber);

    try {
      // Force to open external app
      bool launched = await launchUrl(
        callUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open dialer")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to launch dialer")),
      );
    }
  }

  Future<void> _openWhatsApp() async {
    final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$contactNumber");
    final Uri fallbackUri = Uri.parse("https://wa.me/$contactNumber");

    try {
      // Try deep link first
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      }
      // Fallback to web link if WhatsApp is not installed
      else if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
      // If nothing works
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot open WhatsApp")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to launch WhatsApp")),
      );
    }
  }

  Widget _buildPopupOption(String text, String assetPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Image.asset(
              assetPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopup() {
    return SizeTransition(
      sizeFactor: _popupAnimation,
      axis: Axis.vertical,
      axisAlignment: -1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top bar with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 20),
                    padding: const EdgeInsets.all(4),
                    onPressed: () => _controller.togglePopup(),
                  ),
                ],
              ),
              _buildPopupOption(
                  "Call for order", "assets/call.png", _callNumber),
              const Divider(color: Colors.white, height: 0.5),
              _buildPopupOption(
                  "Order via WhatsApp", "assets/whatsapp.png", _openWhatsApp),

              const Divider(color: Colors.white, height: 0.5),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final pos = _controller.position;

    double popupWidth = 200;

    // Center popup horizontally above button
    double left = pos.dx + 40 - popupWidth / 2;
    left = left.clamp(8.0, screenSize.width - popupWidth - 8.0);

    // Estimate popup height dynamically: base height + option rows + top bar
    double popupHeight = 40 + // top bar with close button
        60 + // Call option
        1 + // Divider
        60; // WhatsApp option
    double gap = -20; // gap between button and popup
    double top = pos.dy - popupHeight - gap;

    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: _buildPopup(),
        ),
        Positioned(
          left: pos.dx,
          top: pos.dy,
          child: Draggable(
            feedback: _buildButton(),
            childWhenDragging: const SizedBox.shrink(),
            onDragEnd: (details) {
              double dx = details.offset.dx.clamp(0.0, screenSize.width - 60);
              double dy = details.offset.dy.clamp(
                  0.0, screenSize.height - 60 - kBottomNavigationBarHeight);

              _controller.updatePosition(Offset(dx, dy));
            },
            child: _buildButton(),
          ),
        ),
      ],
    );
  }
}
