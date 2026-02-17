import 'package:flutter/material.dart';

class MyOverflowBar extends StatefulWidget {
  const MyOverflowBar({
    super.key,
    required this.pageController,
    required this.tabs,
  });

  final PageController pageController;
  final List<String> tabs;

  @override
  State<MyOverflowBar> createState() => _MyOverflowBarState();
}

class _MyOverflowBarState extends State<MyOverflowBar> {
  int get currentIndex =>
      widget.pageController.hasClients
          ? widget.pageController.page!.round()
          : 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 10 * (widget.tabs.length + 1)) /
        widget.tabs.length;
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.tabs.length, (index) {
        Color? textColor =
            currentIndex == index
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).textTheme.titleLarge?.color;
        Color borderColor =
            currentIndex == index
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent;
        return SizedBox(
          width: width,
          child: OutlinedButton(
            onPressed: () {
              widget.pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              side: WidgetStateProperty.all<BorderSide>(
                BorderSide(color: borderColor),
              ),
            ),
            child: Text(
              widget.tabs[index],
              style: TextStyle(
                fontSize: index == currentIndex ? 16 : 14,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }),
    );
  }
}
