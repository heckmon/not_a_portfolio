import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terminal extends StatefulWidget {
  final String command;
  final String result;
  const Terminal({
    super.key,
    required this.command,
    required this.result,
  });

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  
  final AnimatedTextController typeWriterController = AnimatedTextController();
  bool isDone = false;
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    typeWriterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.greenAccent
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withAlpha(122),
            blurRadius: 8.0,
            spreadRadius: 5.0
          )
        ]
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: const Color(0xff161616),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 18,
                    children: [
                      const Icon(Icons.minimize, size: 18, color: Colors.grey),
                      const Icon(Icons.crop_square_sharp, size: 18, color: Colors.grey),
                      const Icon(Icons.close, size: 19, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            )
          ),
          Expanded(
            flex: 13,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Container(
                color: Colors.black,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            " root@athul",
                            style: GoogleFonts.sourceCodePro (
                              fontSize: 20,
                              color: const Color(0xff23d18b),
                            )
                          ),
                          Text(":\$",style: GoogleFonts.sourceCodePro(color: Colors.grey, fontSize: 20)),
                          const SizedBox(width: 5),
                          DefaultTextStyle(
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.grey[400],
                              fontSize: 20
                            ),
                            child: AnimatedTextKit(
                              onFinished: () => setState(() => isDone = true),
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  speed: Duration(milliseconds: 400), 
                                  curve: Curves.bounceIn,
                                  widget.command,
                                )
                              ],
                              controller: typeWriterController,
                            )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Visibility(
                        visible: isDone,
                        child: Text(
                          widget.result,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.sourceCodePro(
                            color: Colors.grey,
                            fontSize: 18.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}