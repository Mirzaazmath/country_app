import 'package:countrys_app/providers/countyr_provider.dart';
import 'package:countrys_app/widgets/country_grid.dart';
import 'package:flutter/material.dart';
import '../models/country_model.dart';
import '../widgets/global_shimmer.dart';
import '../widgets/error_card.dart';
import '../widgets/text_utlis.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Country App"),
        ),
        body: FutureBuilder<dynamic>(
            future: CountryProvider().getCountryList(),
            builder: (context, snaphot) {
              if (snaphot.connectionState == ConnectionState.waiting) {
                return GlobalShimmerWidget(
                    child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: <Widget>[
                    for (int i = 0; i < 20; i++) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ]
                  ],
                ));
              } else if (snaphot.hasError || snaphot.data == null) {
                return Container(
                    height: 300, color: Colors.white, child: const ErrorCard());
              } else {
                List<CountryModel> dataList =
                    snaphot.data as List<CountryModel>;
                debugPrint("data===$dataList");
                return dataList.isEmpty
                    ? Center(
                        child: TextUtil(
                          text: "No Data Found",
                          weight: true,
                          size: 22,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : CountryGridWidget(
                        dataList: dataList,
                      );
              }
            }));
  }
}
