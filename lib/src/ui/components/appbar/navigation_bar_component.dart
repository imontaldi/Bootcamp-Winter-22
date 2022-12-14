import 'package:flutter/material.dart';
import 'package:playground_app/values/k_colors.dart';

// ignore: must_be_immutable
class NavigationBarComponent extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final Widget? titleContent;
  bool isContentBarExtended;
  bool isFooterBarExtended;
  Widget? contentExtendContent;
  double contentExtendHeight;
  Widget? footerExtendedContent;
  final bool hasBack;
  final bool hasCancel;
  final Function? onMenuClick;
  final Function()? onBackClick;
  final Function()? onCancelClick;
  final Function? onNotification;
  final Function? onClose;
  final Function? onInfo;
  bool hideNotificationButton = false;
  bool hideInfoButton = false;

  NavigationBarComponent({
    Key? key,
    this.title = '',
    this.isContentBarExtended = false,
    this.isFooterBarExtended = false,
    this.contentExtendContent,
    this.footerExtendedContent,
    this.contentExtendHeight = 0,
    this.titleContent,
    this.hasBack = false,
    this.hasCancel = false,
    this.onMenuClick,
    this.onBackClick,
    this.onCancelClick,
    this.onClose,
    this.onNotification,
    this.onInfo,
    this.hideInfoButton = false,
    this.hideNotificationButton = false,
  }) : super(key: key);

  @override
  _NavigationBarComponentState createState() => _NavigationBarComponentState();
  final double barSize = 55;
  final double footerBarSize = 45;

  @override
  Size get preferredSize =>
      Size.fromHeight(((isFooterBarExtended && isContentBarExtended)
          ? barSize + footerBarSize + contentExtendHeight + 5
          : (isFooterBarExtended)
              ? barSize + footerBarSize
              : (isContentBarExtended)
                  ? barSize + contentExtendHeight
                  : barSize));
}

class _NavigationBarComponentState extends State<NavigationBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: ((widget.isFooterBarExtended && widget.isContentBarExtended)
              ? widget.barSize +
                  widget.footerBarSize +
                  widget.contentExtendHeight
              : (widget.isFooterBarExtended)
                  ? widget.barSize + widget.footerBarSize
                  : (widget.isContentBarExtended)
                      ? widget.barSize + widget.contentExtendHeight
                      : widget.barSize) +
          5,
      child: Column(
        //overflow: Overflow.visible,
        children: [
          _menu(),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: widget.isFooterBarExtended ? 45 : 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 1,
                    child: Container(
                      height: 40,
                      color: Colors.white,
                      child: widget.footerExtendedContent,
                    ),
                  ),
                ],
              )),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: widget.isContentBarExtended
                  ? widget.contentExtendHeight + 5
                  : 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  _menuButtons(),
                ],
              )),
          // _menuButtons(),
        ],
      ),
    );
  }

  _menu() {
    return Material(
      elevation: 4,
      shadowColor: KGrey_L3.withOpacity(0.5),
      child: Container(
        height: 55,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: (widget.titleContent != null)
                  ? widget.titleContent!
                  : Center(
                      child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: Color(0xFF666666), fontSize: 15),
                    )),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _menuButton(),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buttonInfo(),
                          _buttonNotification(),
                          _buttonClose(),
                        ],
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _menuButtons() {
    return Container(
      height: widget.contentExtendHeight,
      color: Colors.white,
      child: widget.contentExtendContent,
    );
  }

  _menuButton() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
      child: Material(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: widget.hasBack
                ? Image.asset(
                    "images/icon_button_back.png",
                    color: KPrimary,
                    alignment: Alignment.centerLeft,
                    height: 20,
                    width: 20,
                  )
                : Image.asset(
                    "images/icon_menu.png",
                    color: KPrimary,
                    alignment: Alignment.centerLeft,
                    height: 20,
                    width: 20,
                  ),
          ),
          onTap: widget.hasBack
              ? widget.onBackClick
              : widget.onMenuClick != null
                  ? () {
                      widget.onMenuClick!();
                    }
                  : () {},
        ),
      ),
    );
  }

  _buttonInfo() {
    return Visibility(
      visible: !widget.hideInfoButton,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "images/icon_info.png",
                height: 20,
                width: 20,
              ),
            ),
            // ToDo: Add icon tap
            onTap: () {
              if (widget.onInfo != null) {
                widget.onInfo!();
              }
            },
          ),
        ),
      ),
    );
  }

  _buttonNotification() {
    return Visibility(
      visible: !widget.hideNotificationButton,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'images/icon_notifications.png',
                height: 20,
                width: 20,
              ),
            ),
            onTap: () {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  _buttonClose() {
    return Visibility(
      visible: widget.hasCancel,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "images/icon_close.png",
                  height: 20,
                  width: 20,
                ),
              ),
              onTap: widget.onCancelClick),
        ),
      ),
    );
  }
}
