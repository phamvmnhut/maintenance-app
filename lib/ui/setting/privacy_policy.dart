import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../config/color.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            const SizedBox(height: 52),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 32),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.arrow_back_sharp,
                      size: 16.0,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 150))
                    .then((value) {
                  return rootBundle.loadString('assets/docs/privacy_policy.md');
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      data: snapshot.data!,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 52),
          ],
        ),
      ),
    );
  }
}
