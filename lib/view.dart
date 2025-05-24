import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_a_portfolio/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  DesktopBodyState createState() => DesktopBodyState();
}

class DesktopBodyState extends State<DesktopBody> {

  late ScrollController _scrollController;
  int _projectsRebuild = 0;
  bool _hasTriggeredProjects = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      backgroundColor: Colors.black,
      body: WebSmoothScroll(
        scrollSpeed: 3,
        scrollAnimationLength: 800,
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          physics: isDesktop && screenHeight < 1200 ?  NeverScrollableScrollPhysics() : null,
          children: [
            Container(
              color: Color(0xff090909),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async => await launchUrl(Uri.parse("https://github.com/heckmon")),
                    icon: Icon(FontAwesomeIcons.github, color: Colors.white, size: 28)
                  ),
                  SizedBox(width: 25)
                ],  
              )
            ),
            SizedBox(
              height: screenHeight,
              child: isDesktop ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: screenHeight,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                        image,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            heading (false),
                            SizedBox(height: 250),
                            Column(
                              children: [
                                quote(false),
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
                            ending,   
                          ],
                        )
                        ],
                      ),
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
                          child: terminal1(false, context),
                        ),
                      ),
                    )
                  ),
                  
                ],
              ) : Column(
                children: [
                  SizedBox(
                    height: screenHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        image,
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: heading(true)
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: terminal1(true, context)
                        ),
                        Positioned(
                          left: 20,
                          bottom: 110,
                          child: quote(true)
                        ),
                        Positioned(
                          bottom: 90,
                          right: 15,
                          child: Text("-A wise man", style: GoogleFonts.kalam(
                          fontSize: 20,
                          color: Colors.white
                        ))),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Align(
                            alignment:Alignment.bottomCenter,
                            child: ending
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Transform.scale(
              scale: !isDesktop ? 0.8 : 1,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: isDesktop ? 20 : 0),
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
                    padding: EdgeInsets.only(left: !isDesktop ? 0 : screenWidth * 0.3, top: isDesktop ? 60 : 20),
                    child: VisibilityDetector(
                      key: Key("projects"),
                      onVisibilityChanged: (info) {
                        double visiblePercentage = info.visibleFraction * 100;
                        if (visiblePercentage >= 20 && !_hasTriggeredProjects) {
                          setState(() {
                            _projectsRebuild++;
                            _hasTriggeredProjects = true;
                          });
                        }
              
                        if (visiblePercentage < 10 && _hasTriggeredProjects) {
                          _hasTriggeredProjects = false;
                        }
                      },
                      child: Projects(key: ValueKey(_projectsRebuild))
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: !isDesktop ? 0.8 : 1,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: !isDesktop ? 0 : screenWidth * 0.3),
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
                    padding: EdgeInsets.only(left: !isDesktop ? 0 : screenWidth * 0.3),
                    child: upcomingProject(!isDesktop),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: isDesktop ? screenHeight : null,
              child: isDesktop ? Row(
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
                        child: terminal2(!isDesktop, context),
                      ),
                    )
                  )
                ],
              ) : Column(
                children: [
                  terminal2(!isDesktop, context),
                  Transform.scale(scale: 0.8, child: getInTouch)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}