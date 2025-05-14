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

class _ProjectsState extends State<Projects> with TickerProviderStateMixin{

  late final List<AnimationController> _projectIconControllers;
  late final List<Animation<Color?>> _colorAnimations;

  late final List<AnimationController> _projectTextControllers;
  late final List<Animation<Color?>> _textColorAnimation;

  late final List<AnimationController> _iconColorController;
  late final List<Animation<Color?>> _iconColorAnimation;

  late final List<AnimationController> _subtitleColorController;
  late final List<Animation<Color?>> _subtitleColorAnimation;

  @override
  void initState() {
     _projectIconControllers = List.generate(4, (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ));
      _colorAnimations = List.generate(4, (index) =>
        ColorTween(begin: Colors.transparent, end: Colors.greenAccent)
          .animate(_projectIconControllers[index])
      );

      _projectTextControllers = List.generate(4, (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ));
      _textColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: const Color.fromARGB(255, 59, 58, 58), end: Colors.white).animate(_projectTextControllers[index])
      );

      _iconColorController = List.generate(4, (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ));
      _iconColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: Colors.black, end: Colors.transparent).animate(_iconColorController[index])
      );

      _subtitleColorController = List.generate(4, (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ));
      _subtitleColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: const Color.fromARGB(255, 52, 52, 52), end: Colors.grey[400]).animate(_iconColorController[index])
      );

      for (int i = 0; i < _projectIconControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 1300), () {
          _projectIconControllers[i].forward();
          _projectTextControllers[i].forward();
          _iconColorController[i].forward();
          _subtitleColorController[i].forward();
        });
      }
      
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: projectTile(
                _colorAnimations[0],
                _projectIconControllers[0],
                _textColorAnimation[0],
                _projectTextControllers[0],
                _subtitleColorAnimation[0],
                _subtitleColorController[0],
                "Seven Segment Display module",
                "A MicroPython library to control traditional 4 digit seven segment display.",
                true,
                "",
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: AnimatedBuilder(
                    animation: _iconColorController[0],
                    builder: (context,_) {
                      return SvgPicture.asset(
                        colorFilter: ColorFilter.mode(_iconColorAnimation[0].value!, BlendMode.color),
                        width: 45,
                        "assets/images/python.svg",
                      );
                    }
                  ),
                )
              ),
            ),
            Positioned(
              left: 47,
              top: 87,
              child: Saber(startAfter: Duration(milliseconds: 600), height: 85)
            ),    
          ],
        ),
        Stack(
          children: [
            projectTile(
              _colorAnimations[1],
              _projectIconControllers[1],
              _textColorAnimation[1],
              _projectTextControllers[1],
              _subtitleColorAnimation[1],
              _subtitleColorController[1],
              "AI Whatsapp Bot",
              "A whatsapp bot created by integrating Google Gemini API with Whatsapp API.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: AnimatedBuilder(
                  animation: _iconColorController[1],
                  builder: (context,_) {
                    return SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_iconColorAnimation[1].value!, BlendMode.color),
                      width: 45,
                      "assets/images/python.svg",
                    );
                  }
                ),
              )
            ),
            Positioned(
              left: 47,
              top: 72,
              child: Saber(startAfter: Duration(milliseconds: 1900), height: 85)
            ), 
          ],
        ),
        Stack(
          children: [
            projectTile(
              _colorAnimations[2],
              _projectIconControllers[2],
              _textColorAnimation[2],
              _projectTextControllers[2],
              _subtitleColorAnimation[2],
              _subtitleColorController[2],
              "KTU result prank",
              "KTU result page clone with fake result, I learned flutter by doing this.",
              true,
              "",
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: _iconColorController[2],
                    builder: (context,_) {
                      return SvgPicture.asset(
                        colorFilter: ColorFilter.mode(_iconColorAnimation[2].value!, BlendMode.color),
                        height: 35,
                        "assets/images/flutter.svg",
                      );
                    }
                  ),
                ),
              )
            ),
            Positioned(
              left: 47,
              top: 75,
              child: Saber(startAfter: Duration(milliseconds: 3300), height: 85)
            ), 
          ],
        ),
        projectTile(
          _colorAnimations[3],
          _projectIconControllers[3],
          _textColorAnimation[3],
          _projectTextControllers[3],
          _subtitleColorAnimation[3],
          _subtitleColorController[3],
          "File Tree View",
          "A flutter package to display directiories in a VScode style tree structure.",
          true,
          "",
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: _iconColorController[3],
                builder: (context,_) {
                  return SvgPicture.asset(
                    colorFilter: ColorFilter.mode(_iconColorAnimation[3].value!, BlendMode.color),
                    height: 35,
                    "assets/images/flutter.svg",
                  );
                }
              ),
            ),
          )
        ),
      ],
    );
  }
}

Widget projectTile(
    Animation<Color?> colorAnimation,
    AnimationController controller,
    Animation<Color?> textColorAnimation,
    AnimationController textColorController,
    Animation<Color?> subtitleColorAnimation,
    AnimationController subtitleColorController,
    String title,
    String subtitle,
    bool status,
    String link,
    dynamic icon,
  ){
  return AnimatedBuilder(
    animation: controller,
    builder: (context, child) {
      return AnimatedBuilder(
        animation: textColorController,
        builder: (context,child) {
          return ListTile(
            titleTextStyle: GoogleFonts.museoModerno(
              color: textColorAnimation.value,
              fontSize: 22
            ),
            title: Row(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: colorAnimation.value!.withAlpha(122),
                          blurRadius: 15,
                          spreadRadius: 1
                        )
                      ],
                      border: Border.all(
                        color: colorAnimation.value ?? Colors.transparent,
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
            subtitle: AnimatedBuilder(
              animation: subtitleColorController,
              builder: (context,_) {
                return Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style:  GoogleFonts.montserrat(
                          color: subtitleColorAnimation.value,
                          fontSize: 16
                        ),
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Text(
                            "Status: ${status ? "Completed" : "Under development"}",
                            style: GoogleFonts.montserrat(
                              color: subtitleColorAnimation.value,
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
                );
              }
            ),
          );
        }
      );
    }
  );
}


class Saber extends StatefulWidget {
  final Duration startAfter;
  final double? height;

  const Saber({
    super.key, 
    required this.startAfter,
    this.height
  });

  @override
  State<Saber> createState() => _SaberState();
}

class _SaberState extends State<Saber> with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState(){
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.height ?? 300).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(widget.startAfter, ()=> _controller.forward());
    super.initState();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 2.5,
            height: _animation.value,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withAlpha(122),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}