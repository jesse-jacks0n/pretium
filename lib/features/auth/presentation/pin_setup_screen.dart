import 'package:flutter/material.dart';
import 'package:pretium/core/theme/app_colors.dart';
import 'package:pretium/features/home/presentation/home_screen.dart';

/// PIN setup screen where users create a secure 4-digit PIN
/// This includes both initial PIN creation and confirmation steps
/// PIN will be used for subsequent app access
class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({Key? key}) : super(key: key);

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  /// Stores the initial PIN entry from the user
  final List<String> _pin = ['', '', '', ''];
  
  /// Stores the confirmation PIN entry from the user
  final List<String> _confirmPin = ['', '', '', ''];
  
  /// Tracks the current position in the PIN entry
  int _currentIndex = 0;
  
  /// Indicates whether we're in the initial entry or confirmation step
  bool _isConfirmStep = false;
  
  /// Error message to display when PINs don't match
  String _errorMessage = '';

  /// Handles digit button presses for PIN entry
  void _addDigit(String digit) {
    if (!_isConfirmStep) {
      // First PIN entry
      if (_currentIndex < 4) {
        setState(() {
          _pin[_currentIndex] = digit;
          _currentIndex++;
          _errorMessage = '';
        });

        // When first PIN is complete, move to confirmation step
        if (_currentIndex == 4) {
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              _isConfirmStep = true;
              _currentIndex = 0;
            });
          });
        }
      }
    } else {
      // Confirmation PIN entry
      if (_currentIndex < 4) {
        setState(() {
          _confirmPin[_currentIndex] = digit;
          _currentIndex++;
          _errorMessage = '';
        });

        // When confirmation PIN is complete, validate and proceed
        if (_currentIndex == 4) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _validatePins();
          });
        }
      }
    }
  }

  /// Validates that the initial PIN and confirmation PIN match
  /// Navigates to home screen if successful, shows error if not
  void _validatePins() {
    bool pinsMatch = true;
    for (int i = 0; i < 4; i++) {
      if (_pin[i] != _confirmPin[i]) {
        pinsMatch = false;
        break;
      }
    }

    if (pinsMatch) {
      // PINs match, navigate to home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // PINs don't match, reset confirmation
      setState(() {
        _errorMessage = 'PINs don\'t match. Try again.';
        _confirmPin.fillRange(0, 4, '');
        _currentIndex = 0;
      });
    }
  }

  /// Handles backspace button press during PIN entry
  void _removeDigit() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        if (_isConfirmStep) {
          _confirmPin[_currentIndex] = '';
        } else {
          _pin[_currentIndex] = '';
        }
      });
    }
  }

  /// Resets entire PIN setup process to start over
  void _resetPinSetup() {
    setState(() {
      _isConfirmStep = false;
      _currentIndex = 0;
      _pin.fillRange(0, 4, '');
      _confirmPin.fillRange(0, 4, '');
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            
            // Lock icon at the top
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.white,
            ),
            
            const SizedBox(height: 40),
            
            // Title changes based on current step
            Text(
              _isConfirmStep ? 'Confirm your PIN' : 'Create a 4-digit PIN',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // PIN entry indicators (dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_isConfirmStep ? _confirmPin[index].isNotEmpty : _pin[index].isNotEmpty)
                        ? Colors.white 
                        : Colors.white.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 16),
            
            // Error message shown when PINs don't match
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            
            const SizedBox(height: 16),
            
            // Instructional text
            Text(
              _isConfirmStep 
                ? 'Re-enter your PIN to confirm'
                : 'Your PIN will be required to access the app',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            
            // Start over button (only shown during confirmation)
            if (_isConfirmStep)
              TextButton(
                onPressed: _resetPinSetup,
                child: Text(
                  'Start Over',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            
            const Spacer(),
            
            // Numeric keypad for PIN entry
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  // Row 1: 1, 2, 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('1'),
                      _buildKeypadButton('2'),
                      _buildKeypadButton('3'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Row 2: 4, 5, 6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('4'),
                      _buildKeypadButton('5'),
                      _buildKeypadButton('6'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Row 3: 7, 8, 9
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('7'),
                      _buildKeypadButton('8'),
                      _buildKeypadButton('9'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Row 4: empty, 0, backspace
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 60, height: 60), // Empty space
                      _buildKeypadButton('0'),
                      _buildBackspaceButton(),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds a single numeric button for the keypad
  Widget _buildKeypadButton(String digit) {
    return InkWell(
      onTap: () => _addDigit(digit),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: Text(
          digit,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Builds the backspace button for the keypad
  Widget _buildBackspaceButton() {
    return InkWell(
      onTap: _removeDigit,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: const Icon(
          Icons.backspace_outlined,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
} 