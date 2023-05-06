import 'package:flutter/material.dart';
import 'package:my_portfolio/views/about_me.dart';
import 'package:my_portfolio/views/contact_us.dart';
import 'package:my_portfolio/views/footer_class.dart';
import 'package:my_portfolio/views/home_page.dart';
import 'package:my_portfolio/views/my_portfolio.dart';
import 'package:my_portfolio/views/my_services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({Key? key}) : super(key: key);

  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  final onMenuHover = Matrix4.identity()..scale(1.0);
  final menuItems = <String>[
    'Home',
    'About',
    'Services',
    'Portfolio',
    'Contact',
  ];

  var menuIndex = 0;

  final screensList = const <Widget>[
    HomePage(),
    AboutMe(),
    MyServices(),
    MyPortfolio(),
    ContactUs(),
    FooterClass(),
  ];

  Future scrollTo({required int index}) async {
    _itemScrollController
        .scrollTo(
            index: index,
            duration: const Duration(seconds: 2),
            curve: Curves.fastLinearToSlowEaseIn)
        .whenComplete(() {
      setState(() {
        menuIndex = index;
      });
    });
  }

  final yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        toolbarHeight: 90,
        titleSpacing: 40,
        elevation: 0,
        title: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Portfolio'),
                  const Spacer(),
                  PopupMenuButton(
                    icon: Icon(
                      Icons.menu_sharp,
                      size: 32,
                      color: AppColors.white,
                    ),
                    color: AppColors.bgColor2,
                    position: PopupMenuPosition.under,
                    constraints:
                        BoxConstraints.tightFor(width: size.width * 0.9),
                    itemBuilder: (BuildContext context) => menuItems
                        .asMap()
                        .entries
                        .map(
                          (e) => PopupMenuItem(
                            textStyle: AppTextStyles.headerTextStyle(),
                            onTap: () {
                              scrollTo(index: e.key);
                            },
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Portfolio'),
                  const Spacer(),
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, child) =>
                          Constants.sizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            scrollTo(index: index);
                          },
                          borderRadius: BorderRadius.circular(100),
                          onHover: (value) {
                            setState(() {
                              if (value) {
                                menuIndex = index;
                              } else {
                                menuIndex = 0;
                              }
                            });
                          },
                          child: buildNavBarAnimatedContainer(
                              index, menuIndex == index ? true : false),
                        );
                      },
                    ),
                  ),
                  Constants.sizedBox(width: 30),
                ],
              );
            }
          },
        ),
      ),
      body: Scrollbar(
        trackVisibility: true,
        thumbVisibility: true,
        thickness: 8,
        interactive: true,
        controller: yourScrollController,
        child: ScrollablePositionedList.builder(
          itemCount: screensList.length,
          itemScrollController: _itemScrollController,
          itemPositionsListener: itemPositionsListener,
          scrollOffsetListener: scrollOffsetListener,
          itemBuilder: (context, index) {
            return screensList[index];
          },
        ),
      ),
    );
  }

  AnimatedContainer buildNavBarAnimatedContainer(int index, bool hover) {
    return AnimatedContainer(
      alignment: Alignment.center,
      width: hover ? 80 : 75,
      duration: const Duration(milliseconds: 200),
      transform: hover ? onMenuHover : null,
      child: Text(
        menuItems[index],
        style: AppTextStyles.headerTextStyle(
            color: hover ? AppColors.themeColor : AppColors.white),
      ),
    );
  }
}
