import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';


void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width; */
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                    Opacity(
                      opacity: 0.15,
                      child: Image.asset(
                        "assets/images/cat.webp",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Text("Not a Portfolio", style: GoogleFonts.tangerine(
                          fontSize: 130,
                          color: Colors.white
                        )),
                        Text(
                          "No intension to showcase anything.\nJust built a site for fun",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 19,
                            height: 1.5
                          ),
                        ),   
                      ],
                    )
                    ],
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xff090909),
                    child: Padding(
                      padding: const EdgeInsets.all(75),
                      child: Animate(
                        effects: [
                          SlideEffect(
                            begin: const Offset(2, 0),
                            end: Offset.zero,
                            duration: Duration(milliseconds: 1500),
                            // curve: Curves.easeOut
                          )
                        ],
                        child: Terminal(
                          command: "whoami",
                          result: "My parents named me 'Athul'. I hate that name. \nStudying at the 'College of Engineering Attingal', even the locals don't know it exists. Unlike most of the rats running behind HTML, I started with Python."
                        ),
                      ),
                    ),
                  )
                ),
                
              ],
            ),
          )
        ],
      )
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

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
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: const Color(0xff161616),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      IconButton(onPressed: (){} ,icon: Icon(Icons.minimize), color: Colors.grey),
                      IconButton(onPressed: (){} ,icon: Icon(Icons.crop_square_sharp), color: Colors.grey),
                      IconButton(onPressed: (){} ,icon: Icon(Icons.close), color: Colors.grey),
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
                child: Column(
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