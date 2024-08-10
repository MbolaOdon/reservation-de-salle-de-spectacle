import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spectacle/models/splash/page_pop_view.dart';
import 'package:spectacle/providers/theme_provider.dart';
import 'package:spectacle/utils/enum.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:spectacle/utils/text_styles.dart';
import 'package:spectacle/utils/themes.dart';

class HomeExplorerSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  HomeExplorerSliderView({Key? key, required this.opValue, required this.click}) : super(key: key);

  @override
  State<HomeExplorerSliderView> createState() => _HomeExplorerSliderView();

}

class _HomeExplorerSliderView extends State<HomeExplorerSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewData = [];
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewData.add(PageViewData(
      titleText: 'cap Town', subText: 'five_star', assetsImage: Localfiles.explore_2
    ));
    pageViewData.add(PageViewData(
      titleText: 'cap Town', subText: 'five_star', assetsImage: Localfiles.explore_3
    ));
    pageViewData.add(PageViewData(
      titleText: 'cap Town', subText: 'five_star', assetsImage: Localfiles.explore_1
    ));

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer){
      if(mounted) if(currentShowIndex == 0){
        pageController.animateTo(MediaQuery.of(context).size.width, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

      }else if(currentShowIndex == 1){
        pageController.animateTo(MediaQuery.of(context).size.width * 2, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

      }else if(currentShowIndex == 2){
        pageController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

      }
    });
    
    super.initState();
  }
  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IgnorePointer(
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            itemCount: pageViewData.length,
            itemBuilder: (BuildContext contex, int index) {
              return PagePopup(
                imageData: pageViewData[0],
                opValue: widget.opValue,
              );
            },
            // children: <Widget>[
            //   PagePopup(
            //     imageData: pageViewData[0],
            //     opValue: widget.opValue,
            //   ),
            //    PagePopup(
            //     imageData: pageViewData[0],
            //     opValue: widget.opValue,
            //   ),
            //    PagePopup(
            //     imageData: pageViewData[0],
            //     opValue: widget.opValue,
            //   ),
            // ],
          ),
          Positioned(
            bottom: 32,
            right: context.read<ThemeProvider>().languageType == LanguageType.ar
                ? null
                : 32,
            left: context.read<ThemeProvider>().languageType == LanguageType.ar
                ? 32
                : null,
            child: SmoothPageIndicator(
              controller: pageController,
              count: pageViewData.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Theme.of(context).dividerColor,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0,
              ),
              onDotClicked: (index) {}), 
            ),
          
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;
  const PagePopup({Key? key, required this.imageData, required this.opValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 1.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    imageData.titleText,
                    textAlign:  TextAlign.left,
                    style: TextStyles(context)
                        .getTitleStyle()
                        .copyWith(color: AppTheme.whiteColor),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    imageData.subText,
                    textAlign:  TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                 SizedBox(
                  height: 8,
                ),

              ],
            ),
          ),
        )
        ]
        ,);
  }
}