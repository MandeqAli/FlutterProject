import 'package:flutter/material.dart';
import 'onboundttwo.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  final List<String> imageUrls = const [
    'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/dfh/dfh00191/y/27.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzCBC1eK0F6zvYph2REOVRU-n-ExXTkGLxjQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTraeWDUcLF-G0E1UdliRJFOjsKVk89qInbRA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrjg6DTwvOUsgrrmRqpiGStISTaeKWmrvKrA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdITc8mzDJhh7BUl0rK9w9efBLb177ecB3JQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8oAJhAhr0Px5fGFii5XLF2ypt2R5Ha6OxoA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTONTbR14hZE_dA2mCZaVUUaCKCTebqhjMPtg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5tbJ_S_wYueEloLhr59Qgv9KVkda1qrrFKw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiIfZUU5MXZiU3JS8DxvPLhxPs-XANw38eeg&s',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0D0D),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            'Choose your medicines',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Discover healthcare products from trusted brands.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: imageUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return _HoverImage(url: imageUrls[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const OnboardingTwo()),
                    );
                  },
                  child: const Text('Skip', style: TextStyle(color: Colors.white70)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OnboardingTwo()),
                    );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Hover/tap zoom effect for images
class _HoverImage extends StatefulWidget {
  final String url;
  const _HoverImage({required this.url});

  @override
  State<_HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<_HoverImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _hovering = true),
        onTapUp: (_) => setState(() => _hovering = false),
        onTapCancel: () => setState(() => _hovering = false),
        child: AnimatedScale(
          scale: _hovering ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.white10,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white10,
                      child: const Icon(Icons.broken_image, color: Colors.white54),
                    );
                  },
                ),
                if (_hovering)
                  Container(
                    color: Colors.black26,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
