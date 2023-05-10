// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/shared/constants.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../../auth.dart';
import '../../../../../shared/responsive.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardHeader extends StatelessWidget {
  DashboardHeader({
    super.key,
  });
  int notifcationCount = 0;
  @override
  Widget build(BuildContext context) {
    bool notificationStatus =
        context.watch<DashboardController>().isNotificationOpened;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Responsive.isDesktop(context))
            AutoSizeText(
              "Hello!\nWelcome back!",
              style: GoogleFonts.akshar(
                fontSize: Responsive.isMobile(context) ? 23 : 45,
                fontWeight: fwBold,
                color: secondaryColor,
                letterSpacing: Responsive.isMobile(context) ? 2.3 : 4.5,
              ),
            ),
          if (!Responsive.isDesktop(context))
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  size: 32,
                  Icons.menu,
                  color: secondaryColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Container(
                  height: Responsive.isMobile(context) ? 35 : 57,
                  width: Responsive.isMobile(context) ? 35 : 57,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: secondaryColor,
                  ),
                  child: FutureBuilder<List<ContainerItem>>(
                      future: _getContainerItems(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          notifcationCount = snapshot.data!.length;
                          return badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -15, end: -12),
                            badgeContent: Text(
                              notifcationCount == 0 || notificationStatus
                                  ? ''
                                  : notifcationCount.toString(),
                              style: GoogleFonts.akshar(
                                fontSize: 20,
                                fontWeight: fwLight,
                                color: Colors.black,
                              ),
                            ),
                            badgeStyle: badges.BadgeStyle(
                              padding: const EdgeInsets.all(10.0),
                              badgeColor:
                                  notifcationCount == 0 || notificationStatus
                                      ? Colors.transparent
                                      : const Color(0xFFFEDE57),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.notifications_none_outlined,
                                  size: Responsive.isMobile(context) ? 16 : 24,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Provider.of<DashboardController>(context,
                                          listen: false)
                                      .changeNotificationStatus();
                                  showPopover(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    transition: PopoverTransition.other,
                                    bodyBuilder: (context) => ListItems(),
                                    direction: PopoverDirection.bottom,
                                    width: !Responsive.isDesktop(context)
                                        ? 200
                                        : 600,
                                    height: 400,
                                    contentDyOffset: 15,
                                    radius: 15,
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return Center(
                              child: Icon(
                            Icons.notifications_none_outlined,
                            size: Responsive.isMobile(context) ? 16 : 24,
                            color: Colors.black,
                          ));
                        }
                      }),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  Future<List<ContainerItem>> _getContainerItems() async {
    final User? user = Auth().currentUser;
    List<ContainerItem> containerList = [];
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("UsersData")
        .child(user!.uid)
        .child("readings");

    final DatabaseEvent event = await usersRef.limitToLast(1).once();
    final DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> readings = snapshot.value as Map;
      readings.forEach((key, value) {
        String cont1 = value['container1Distance'].toString();
        String cont2 = value['container2Distance'].toString();
        String cont3 = value['container3Distance'].toString();
        String cont4 = value['container4Distance'].toString();
        if (int.tryParse(cont1)! >= 8) {
          containerList.add(
              ContainerItem("Shampoo", value['container1Distance'].toString()));
        }
        if (int.tryParse(cont2)! >= 8) {
          containerList.add(ContainerItem(
              "Hair Conditioner", value['container2Distance'].toString()));
        }
        if (int.tryParse(cont3)! >= 8) {
          containerList.add(ContainerItem(
              "Liquid Detergent", value['container3Distance'].toString()));
        }
        if (int.tryParse(cont4)! >= 8) {
          containerList.add(ContainerItem(
              "Fabric Conditioner", value['container4Distance'].toString()));
        }
      });
    }

    return containerList;
  }
}

class ListItems extends StatelessWidget {
  ListItems({Key? key}) : super(key: key);
  List<ContainerItem> containerList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FutureBuilder(
          future: _getContainerItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            } else if (snapshot.hasData) {
              containerList = snapshot.data!;
              if (containerList.isEmpty) {
                return Center(
                  child: Text(
                    "No Notifications",
                    style: GoogleFonts.akshar(
                      fontSize: 24,
                      fontWeight: fwRegular,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: containerList.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final container = containerList[index];

                    return Container(
                      padding: const EdgeInsets.all(8),
                      height: 70,
                      color: primaryColor,
                      child: Center(
                        child: Text(
                          'Product ${container.name} is almost empty, please refill ',
                          style: GoogleFonts.akshar(
                            fontSize: !Responsive.isDesktop(context) ? 16 : 24,
                            fontWeight: fwLight,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 10,
                    );
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Container NotificationItem() {
    return Container(
      height: 70,
      color: primaryColor,
      child: Center(
        child: Text(
          'Product "ProductName" is almost empty, please refill ',
          style: GoogleFonts.akshar(
            fontSize: 24,
            fontWeight: fwLight,
            color: secondaryColor,
          ),
        ),
      ),
    );
  }

  Future<List<ContainerItem>> _getContainerItems() async {
    final User? user = Auth().currentUser;
    List<ContainerItem> containerList = [];
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("UsersData")
        .child(user!.uid)
        .child("readings");

    final DatabaseEvent event = await usersRef.limitToLast(1).once();
    final DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> readings = snapshot.value as Map;
      readings.forEach((key, value) {
        String cont1 = value['container1Distance'].toString();
        String cont2 = value['container2Distance'].toString();
        String cont3 = value['container3Distance'].toString();
        String cont4 = value['container4Distance'].toString();
        if (int.tryParse(cont1)! >= 8) {
          containerList.add(
              ContainerItem("Shampoo", value['container1Distance'].toString()));
        }
        if (int.tryParse(cont2)! >= 8) {
          containerList.add(ContainerItem(
              "Hair Conditioner", value['container2Distance'].toString()));
        }
        if (int.tryParse(cont3)! >= 8) {
          containerList.add(ContainerItem(
              "Liquid Detergent", value['container3Distance'].toString()));
        }
        if (int.tryParse(cont4)! >= 8) {
          containerList.add(ContainerItem(
              "Fabric Conditioner", value['container4Distance'].toString()));
        }
      });
    }

    return containerList;
  }
}

class ContainerItem {
  String name;
  String distance;
  ContainerItem(this.name, this.distance);
}
