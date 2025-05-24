import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Terminal extends StatefulWidget {
  final String command;
  final String result;
  final Curve? curve;
  final int? delay;
  final double? height;
  final double? width;
  const Terminal({
    super.key,
    required this.command,
    required this.result,
    this.curve,
    this.delay,
    this.height,
    this.width
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
      height: widget.height,
      width: widget.width,
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
            flex: ResponsiveBreakpoints.of(context).isMobile ? 2 : 1,
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
                child: Transform.scale(
                  scale: ResponsiveBreakpoints.of(context).isMobile ? 0.95 : 1,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Wrap(
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
                                    speed: Duration(milliseconds: widget.delay ?? 400), 
                                    curve: widget.curve ?? Curves.bounceIn,
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

  late final List<AnimationController> _projectAnimationControllers;
  late final List<Animation<Color?>> _colorAnimations;
  late final List<Animation<Color?>> _textColorAnimation;
  late final List<Animation<Color?>> _iconColorAnimation;
  late final List<Animation<Color?>> _subtitleColorAnimation;

  @override
  void initState() {
     _projectAnimationControllers = List.generate(4, (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ));

      _colorAnimations = List.generate(4, (index) =>
        ColorTween(begin: Colors.transparent, end: Colors.greenAccent).animate(_projectAnimationControllers[index])
      );

      _textColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: const Color.fromARGB(255, 59, 58, 58), end: Colors.white).animate(_projectAnimationControllers[index])
      );

      _iconColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: Colors.black, end: Colors.transparent).animate(_projectAnimationControllers[index])
      );

      _subtitleColorAnimation = List.generate(4, (index) => 
        ColorTween(begin: const Color.fromARGB(255, 52, 52, 52), end: Colors.grey[400]).animate(_projectAnimationControllers[index])
      );

      for (int i = 0; i < _projectAnimationControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 1100), () {
          if(mounted) _projectAnimationControllers[i].forward();
        });
      }
      
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      for(AnimationController controller in _projectAnimationControllers){
        if(mounted) controller.dispose();
    }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: projectTile(
                context,
                _projectAnimationControllers[0],
                _colorAnimations[0],
                _textColorAnimation[0],
                _subtitleColorAnimation[0],
                "7 Segment Display module",
                "A MicroPython library to control traditional 4 digit seven segment display.",
                "",
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: AnimatedBuilder(
                    animation: _projectAnimationControllers[0],
                    builder: (context,_) {
                      return SvgPicture.asset(
                        colorFilter: ColorFilter.mode(_iconColorAnimation[0].value!, BlendMode.color),
                        width: 45,
                        "assets/images/python.svg",
                      );
                    }
                  ),
                ),
                () async{
                  await launchUrl(Uri.parse("https://github.com/heckmon/micropython_7segment_display_library"));
                }
              ),
            ),
            Positioned(
              left: 47,
              top: 87,
              child: Saber(startAfter: Duration(milliseconds: 400), height: isMobile ? 145 : 85)
            ),    
          ],
        ),
        Stack(
          children: [
            projectTile(
              context,
              _projectAnimationControllers[1],
              _colorAnimations[1],
              _textColorAnimation[1],
              _subtitleColorAnimation[1],
              "AI Whatsapp Bot",
              "A whatsapp bot created by integrating Google Gemini API with Whatsapp API.",
              "",
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: AnimatedBuilder(
                  animation: _projectAnimationControllers[1],
                  builder: (context,_) {
                    return SvgPicture.asset(
                      colorFilter: ColorFilter.mode(_iconColorAnimation[1].value!, BlendMode.color),
                      width: 45,
                      "assets/images/python.svg",
                    );
                  }
                ),
              ),
              () async{
                await launchUrl(Uri.parse("https://github.com/heckmon/Whatsapp_Gemini_AI_Bot"));
              }
            ),
            Positioned(
              left: 47,
              top: 72,
              child: Saber(startAfter: Duration(milliseconds: 1700), height: isMobile ? 145 : 85)
            ), 
          ],
        ),
        Stack(
          children: [
            projectTile(
              context,
              _projectAnimationControllers[2],
              _colorAnimations[2],
              _textColorAnimation[2],
              _subtitleColorAnimation[2],
              "KTU result prank",
              "KTU result page clone with fake result, I learned flutter by doing this.",
              "",
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: _projectAnimationControllers[2],
                    builder: (context,_) {
                      return SvgPicture.asset(
                        colorFilter: ColorFilter.mode(_iconColorAnimation[2].value!, BlendMode.color),
                        height: 35,
                        "assets/images/flutter.svg",
                      );
                    }
                  ),
                ),
              ),
              () async{
                await launchUrl(Uri.parse("https://github.com/heckmon/ktu_results_2025"));
              }
            ),
            Positioned(
              left: 47,
              top: 75,
              child: Saber(startAfter: Duration(milliseconds: 2700), height: isMobile ? 145 : 85)
            ), 
          ],
        ),
        Stack(
          children: [
            projectTile(
              context,
              _projectAnimationControllers[3],
              _colorAnimations[3],
              _textColorAnimation[3],
              _subtitleColorAnimation[3],
              "File Tree View",
              "A flutter package to display directiories in a VScode style tree structure.",
              "",
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom:8, right: 11),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: _projectAnimationControllers[3],
                    builder: (context,_) {
                      return SvgPicture.asset(
                        colorFilter: ColorFilter.mode(_iconColorAnimation[3].value!, BlendMode.color),
                        height: 35,
                        "assets/images/flutter.svg",
                      );
                    }
                  ),
                ),
              ),
              () async{
                await launchUrl(Uri.parse("https://github.com/heckmon/file_tree_view"));
              }
            ),
            Positioned(
              left: 47,
              top: 75,
              child: Saber(startAfter: Duration(milliseconds: 3800), height: isMobile ? 110 : 50)
            ),
          ],
        ),
        pendingProjectTile(
          "Code Crafter",
          "A powerful flutter code editor package with LSP support.",
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 11),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                height: 35,
                "assets/images/flutter.svg"
              ),
            ),
          )
        ),
      ],
    );
  }
}

class PendingProjects extends StatelessWidget {
  const PendingProjects({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Column(
      children: [
        pendingProjectTile(
          "VSDroid",
          "A full fledged IDE on android uses Code Crafter under the hood.",
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 11),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                height: 35,
                "assets/images/flutter.svg"
              ),
            ),
          )
        ),
        pendingProjectTile(
          "OS from Scratch",
          "A kernel from scratch using C.",
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                height: 38,
                "assets/images/c-1.svg"
              ),
            ),
          )
        ),
        pendingProjectTile(
          "Mini PC from scratch using ${isMobile ? "\n" : ""} NAND gates",
          "Following the 'NandToTetris' course",
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                height: 40,
                "assets/images/pcb.svg"
              ),
            ),
          )
        ),
      ],
    );
  }
}

Widget projectTile(
    BuildContext context,
    AnimationController controller,
    Animation<Color?> colorAnimation,
    Animation<Color?> textColorAnimation,
    Animation<Color?> subtitleColorAnimation,
    String title,
    String subtitle,
    String link,
    dynamic icon,
    VoidCallback onPressed
  ){
  bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
  return AnimatedBuilder(
    animation: controller,
    builder: (context,child) {
      return ListTile(
        titleTextStyle: GoogleFonts.museoModerno(
          color: textColorAnimation.value,
          fontSize: 22
        ),
        title: Row(
          spacing: 19,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: isMobile ? colorAnimation.value! : colorAnimation.value!.withAlpha(122),
                    blurRadius: isMobile ? 25 : 15,
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
                  color: subtitleColorAnimation.value,
                  fontSize: 16
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  Text(
                    "Status: Completed",
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
                onPressed: onPressed,
                child: Text("Source code")
              )
            ],
          ),
        ),
      );
    }
  );
}

Widget pendingProjectTile(
  String title,
  String subtitle,
  dynamic icon
){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      titleTextStyle: GoogleFonts.museoModerno(
        color: const Color.fromARGB(255, 80, 79, 79),
        fontSize: 22
      ),
      title: Row(
        spacing: 20,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle
            ),
            child: icon,
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
                color: const Color.fromARGB(255, 74, 73, 73),
                fontSize: 16
              ),
            ),
            Row(
              spacing: 5,
              children: [
                Text(
                  "Status: Under development",
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 80, 79, 79),
                    fontSize: 14
                  ),
                ),
                Icon(
                  Icons.construction,
                  size: 17,
                )
              ],
            ),
          ],
        ),
      ),
    ),
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
    Future.delayed(widget.startAfter, (){ 
      if(mounted)_controller.forward();
    });
    super.initState();
  }
  
  @override
  void dispose() {
    if(mounted) _controller.dispose();
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
                  color: ResponsiveBreakpoints.of(context).isDesktop ? Colors.greenAccent.withAlpha(122) : Colors.greenAccent,
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

ListTile upcomingProject(bool isMobile) => ListTile(
  titleTextStyle: GoogleFonts.museoModerno(
    color: Colors.white,
    fontSize: 22
  ),
  title: Row(
    spacing: 30,
    children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.blueAccent.withAlpha(122),
              blurRadius: 15,
              spreadRadius: 0
            )
          ],
          shape: BoxShape.circle
        ),
        child: SvgPicture.asset("assets/images/c-1.svg", height: 45),
      ),
      Text("DIY steering wheel set${isMobile ? "\n" : ""}for PC Games")
    ],
  ),
  subtitle: Padding(
    padding: const EdgeInsets.only(left: 70),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "DIY steering wheel and gear box set using ATmega-8A microcontroller.",
            style:  GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 16
            ),
          ),
        ),
      ],
    ),
  ),
);

final Widget getInTouch = DefaultTextStyle(
  style: GoogleFonts.montserrat(
    height: 1.5,
    color: Colors.grey[400],
    fontSize: 18
  ),
  child: Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get in Touch",
          style: GoogleFonts.museoModerno(
            color: Colors.white,
            fontSize: 40
          ),
        ),
        Text("Reach out for collaborations or inquiries anytime.",style: TextStyle(color: Colors.white)),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.5),
                child: Icon(Icons.email_outlined, color: Colors.white),
              ),
              Text("Email"),
              Text("Your message is welcome!"),
              Text("athulas2005@gmail.com"),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.5),
                child: Icon(Icons.phone_enabled_outlined, color: Colors.white),
              ),
              Text("Phone"),
              Text("Available for calls anytime."),
              Text("+918848278440"),
            ],
          ),
        ),
      ],
    ),
  ),
);

Text heading(bool isMobile) => Text(
  "Not a Portfolio",
  style: GoogleFonts.tangerine(
    fontSize: !isMobile ? 130 : 65,
    color: Colors.white
));

Text quote(bool isMobile) => Text(
  '"Why decorate a README profile when ${isMobile ? "\n" : ""} the repo itself tells the story?"',
  style: GoogleFonts.kalam(
    color: Colors.white,
    fontSize: 20,
    fontStyle: FontStyle.italic
  ),
);

final Widget image = Opacity(
  opacity: 0.15,
  child: Image.asset(
    "assets/images/cat.webp",
    fit: BoxFit.cover,
  ),
);

final Text ending = Text(
  "No intension to showcase anything.\nJust built a site for fun.",
  textAlign: TextAlign.center,
  style: GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 19,
    height: 1.5
  ),
);

Terminal terminal1(bool isMobile, BuildContext context) => Terminal(
  height: isMobile ? MediaQuery.of(context).size.height * 0.5 : null,
  width: isMobile ? 300 : double.infinity,
  command: "whoami",
  result: "Just a sleep-deprived engineering student with too many side projects and hate theory subjects.\n\nMy parents named me 'Athul'. I hate that name. \nStudying at the 'College of Engineering Attingal', even the locals don't know it exists.\n\nUnlike most of the rats running behind HTML, I started with Python.\n\nThen I learned flutter for front end.\nI chose Flutter not just for mobile, but because it’s a framework that makes sense. Native speed, cross-platform power. A full-stack framework that meets my needs. I loved that I could write once and deploy anywhere. Android, iOS, and web – all from a single codebase.\n\nCurrently learning OS development using C and assembly."
);

Terminal terminal2(bool isMobile, BuildContext context) => Terminal(
  height: isMobile ? MediaQuery.of(context).size.height * 0.5 : null,
  width: isMobile ? 300 : double.infinity,
  command: "sudo load cringe",
  result: "> generating Readme.md profile...\nerror: Operation blocked.\nreason: Newbie glitter detected — does not meet developer credibility requirements.\n\n> get relationship --status\nstatus: Single since birth.\n\n> uptime\ntoo long.\n\n> go to sleep\nerror: Too many thoughts running.\n\n~\$ git checkout responsibilities\ngit: Switched to branch 'nah'\n\n~\$ df -h\n/dev/brain   Not working properly.\n\n~\$ ./lab.sh\n Half wired, Half wrong -- full marks anyway.\n\n> Cringe threshold exceeded. Exiting...",
  delay: 150,
  curve: Curves.easeIn,
);