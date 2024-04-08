import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:confetti/confetti.dart';


class Destination extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final ThemeMode themeMode;
  final bool isAdopted;
  final Function(bool) onAdoptChanged;

  const Destination({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.themeMode,
    required this.isAdopted,
    required this.onAdoptChanged,
  }) : super(key: key);

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  bool _isAdopted = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _isAdopted = widget.isAdopted;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: widget.themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PhotoView(
                  imageProvider: AssetImage(widget.imagePath),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showAdoptionConfirmation(context);
                  setState(() {
                    _isAdopted = !_isAdopted;
                  });
                  widget.onAdoptChanged(_isAdopted);
                },
                child: Text(_isAdopted ? 'Already Adopted' : 'Adopt Me'),
              ),
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  particleDrag: 0.05,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.05,
                  shouldLoop: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdoptionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adoption Confirmation'),
          content: Text('You have now adopted ${widget.title.split(' - ')[0]}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _confettiController.play();
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
