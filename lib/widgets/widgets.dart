import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _TerminalState extends State<Terminal> with SingleTickerProviderStateMixin{
  final AnimatedTextController typeWriterController = AnimatedTextController();
  bool isDone = false;
  
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

class _ProjectsState extends State<Projects> with SingleTickerProviderStateMixin{
  late Animation<Alignment> _aniAlign;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this
      );
    _aniAlign = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        weight: 1
      )
    ]).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context,_) {
        return ListView(
          children: [
            projectTile(
              "Seven Segment Display module",
              "A MicroPython library to control traditional 4 digit seven segment display.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  width: 45,
                  "assets/images/python.svg",
                ),
              )
            ),
            //TODO: Add Vertical divider
            projectTile(
              "AI Whatsapp Bot",
              "A whatsapp bot created by integrating Google Gemini API with Whatsapp API.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  width: 45,
                  "assets/images/python.svg",
                ),
              )
            ),
            projectTile(
              "KTU result prank",
              "KTU result page clone with fake result, I learned flutter by doing this.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    height: 35,
                    "assets/images/flutter.svg",
                  ),
                ),
              )
            ),
            projectTile(
              "File Tree View",
              "A flutter package to display directiories in a VScode style tree structure.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    height: 35,
                    "assets/images/flutter.svg",
                  ),
                ),
              )
            ),
          ],
        );
      }
    );
  }
}

Widget projectTile(String title, String subtitle, bool status, String link, dynamic icon){
  return ListTile(
    titleTextStyle: GoogleFonts.museoModerno(
      color: Colors.white,
      fontSize: 22
    ),
    title: Row(
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Colors.greenAccent.withAlpha(122),
                  blurRadius: 15,
                  spreadRadius: 1
                )
              ],
              border: Border.all(
                color: Colors.greenAccent,
                width: 1.5
              ),
              shape: BoxShape.circle
            ),
            child: icon,
          ),
        ),
        Text(title)
      ],
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style:  GoogleFonts.montserrat(
              color: Colors.grey[400],
              fontSize: 16
            ),
          ),
          Row(
            spacing: 5,
            children: [
              Text(
                "Status: ${status ? "Completed" : "Under development"}",
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
              Icon(
                Icons.check_circle_rounded,
                size: 15,
                color: Colors.greenAccent,
              )
            ],
          ),
          TextButton(
            onPressed: (){},
            child: Text("Source code")
          )
        ],
      ),
    ),
  );
}