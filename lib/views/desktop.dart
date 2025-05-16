import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_a_portfolio/widgets/widgets.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  DesktopBodyState createState() => DesktopBodyState();
}

class DesktopBodyState extends State<DesktopBody> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                  Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      "assets/images/cat.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Not a Portfolio",
                        style: GoogleFonts.tangerine(
                          fontSize: 130,
                          color: Colors.white
                      )),
                      SizedBox(height: 350),
                      Column(
                        children: [
                          Text(
                            '"Why decorate a README profile when the repo itself tells the story?"',
                            style: GoogleFonts.kalam(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 200),
                              child: Text(
                                "-A wise man",
                                style: GoogleFonts.kalam(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "No intension to showcase anything.\nJust built a site for fun.",
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
                        const SlideEffect(
                          begin: Offset(2, 0),
                          end: Offset.zero,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.bounceIn
                        )
                      ],
                      child: const Terminal(
                        command: "whoami",
                        result: "Just a sleep-deprived engineering student with too many side projects and hate theory subjects.\n\nMy parents named me 'Athul'. I hate that name. \nStudying at the 'College of Engineering Attingal', even the locals don't know it exists.\n\nUnlike most of the rats running behind HTML, I started with Python.\n\nThen I learned flutter for front end.\nI chose Flutter not just for mobile, but because it’s a framework that makes sense. Native speed, cross-platform power. A full-stack framework that meets my needs. I loved that I could write once and deploy anywhere. Android, iOS, and web – all from a single codebase.\n\nCurrently learning OS development using C and assembly."
                      ),
                    ),
                  ),
                )
              ),
              
            ],
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Side Projects",
                    style: GoogleFonts.museoModerno(
                      color: Colors.white,
                      fontSize: 38
                    ),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.3, top: 60),
                child: Projects(),
              ),
            ],
          ),
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.3),
                child: PendingProjects()
              ),
              SizedBox(height: 100),
              Align(
                alignment: Alignment.center,
                child: Text("Upcoming Project(s)", style: GoogleFonts.museoModerno(
                  color: Colors.white,
                  fontSize: 38
                )),
              ),
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.3),
                child: upcomingProject,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200,left: 200),
                  child: getInTouch,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(75),
                  child: Animate(
                    effects: [
                      const SlideEffect(
                        begin: Offset(2, 0),
                        end: Offset.zero,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.bounceIn,
                      )
                    ],
                    child: Terminal(
                      command: "sudo load cringe",
                      result: "> generating Readme.md profile...\nerror: Operation blocked.\nreason: Newbie glitter detected — does not meet developer credibility requirements.\n\n> get relationship --status\nstatus: Single since birth.\n\n> uptime\ntoo long.\n\n> go to sleep\nerror: Too many thoughts running.\n\n~\$ git checkout responsibilities\ngit: Switched to branch 'nah'\n\n~\$ df -h\n/dev/brain   Not working properly.\n\n~\$ ./lab.sh\n Half wired, Half wrong -- full marks anyway.\n\n> Cringe threshold exceeded. Exiting...",
                      delay: 150,
                      curve: Curves.easeIn,
                    ),
                  ),
                )
              )
            ],
          )
        ],
      )
    );
  }
}