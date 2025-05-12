import 'package:flutter/material.dart';

class AppIcons {
  // Bill payment icon
  static Widget billIcon({double size = 48.0, Color color = const Color(0xFF0F6458)}) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: BillIconPainter(color: color),
      ),
    );
  }
  
  // Stablecoin/accept payment icon
  static Widget walletIcon({double size = 48.0, Color color = const Color(0xFF0F6458)}) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: WalletIconPainter(color: color),
      ),
    );
  }
  
  // Credit card/direct pay icon
  static Widget cardIcon({double size = 48.0, Color color = const Color(0xFF0F6458)}) {
    return Container(
      width: size,
      height: size,
      child: Icon(
        Icons.credit_card,
        size: size * 0.6,
        color: color,
      ),
    );
  }
}

// Custom painter for bill icon
class BillIconPainter extends CustomPainter {
  final Color color;
  
  BillIconPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;
      
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Draw receipt
    final Path receiptPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.25, size.height * 0.8)
      ..lineTo(size.width * 0.75, size.height * 0.8)
      ..lineTo(size.width * 0.75, size.height * 0.2)
      ..lineTo(size.width * 0.25, size.height * 0.2);
      
    // Draw zigzag at top
    final Path zigzagPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.33, size.height * 0.15)
      ..lineTo(size.width * 0.41, size.height * 0.2)
      ..lineTo(size.width * 0.49, size.height * 0.15)
      ..lineTo(size.width * 0.57, size.height * 0.2)
      ..lineTo(size.width * 0.66, size.height * 0.15)
      ..lineTo(size.width * 0.75, size.height * 0.2);
    
    // Draw lines for text
    final Path linesPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.35)
      ..lineTo(size.width * 0.65, size.height * 0.35)
      ..moveTo(size.width * 0.35, size.height * 0.5)
      ..lineTo(size.width * 0.65, size.height * 0.5)
      ..moveTo(size.width * 0.35, size.height * 0.65)
      ..lineTo(size.width * 0.65, size.height * 0.65);
    
    canvas.drawPath(receiptPath, paint);
    canvas.drawPath(zigzagPath, paint);
    canvas.drawPath(linesPath, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for wallet icon
class WalletIconPainter extends CustomPainter {
  final Color color;
  
  WalletIconPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;
      
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Draw wallet base
    final RRect walletRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.3, 
                   size.width * 0.6, size.height * 0.45),
      Radius.circular(size.width * 0.06)
    );
    
    // Draw circle for coin
    final Offset circleCenter = Offset(size.width * 0.6, size.height * 0.5);
    
    canvas.drawRRect(walletRect, paint);
    canvas.drawCircle(circleCenter, size.width * 0.1, fillPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 