import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/auth.dart';
import '../views/settings.dart';
import '../views/signup.dart';
import '../data/card_deatils.dart';
import '../db services/db_services.dart';
import '../utils/responsive.dart';
import '../views/home.dart';
import '../views/home_screen.dart';
import 'custom_card_widget.dart';

class ActivityDetailsCard extends StatelessWidget {
  ActivityDetailsCard({super.key});
  DB database = DB();
  @override
  Widget build(BuildContext context) {
    tapped(int index) {
      Widget page;

      // You can also use if else here.
      switch (index) {
        case 0:
          page = Settings(
            database: database,
          );
          break;
        case 1:
          page = StockEntry(
            database: database,
          );
          break;
        case 2:
          page = Home();
          break;

        default:
          page = AuthScreen(); // default item when no matching category found
      }

      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (context) {
        return page;
      }));
    }

    final cardDetails = CardDetails();
    return GridView.builder(
      itemCount: cardDetails.cardData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => tapped(index),
        child: CustomCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                cardDetails.cardData[index].icon,
                width: 30,
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 4),
                // child: Text(
                //   healthDetails.healthData[index].value,
                //   style: const TextStyle(
                //     fontSize: 18,
                //     color: Colors.white,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ),
              Text(
                cardDetails.cardData[index].title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
