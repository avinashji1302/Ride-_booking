import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/help/model/help_model.dart';
import 'package:app/screens/help/viewmodel/help_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _CmsListScreenState();
}

class _CmsListScreenState extends State<HelpScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HelpProvider>().loadPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HelpProvider>();

    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        foregroundColor: AppColor.black,
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.grey,))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [

                /// HEADER
                const Text(
                  "How can we help you?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Find answers about rides, payments, and policies.",
                  style: TextStyle(color: AppColor.grey),
                ),

                const SizedBox(height: 20),

                /// CMS LIST
                ...provider.pages.map(
                  (page) => _HelpCard(page: page),
                ),
              ],
            ),
    );
  }
}
class _HelpCard extends StatelessWidget {
  final HelpModel page;

  const _HelpCard({required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CmsDetailScreen(page: page),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [

            /// ICON BOX
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColor.lightyellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColor.darkYellow,
              ),
            ),

            const SizedBox(width: 14),

            /// TITLE
            Expanded(
              child: Text(
                page.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}


class CmsDetailScreen extends StatelessWidget {
  final HelpModel page;

  const CmsDetailScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,

      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        foregroundColor: AppColor.black,
        title: Text(
          page.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// CONTENT CARD
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.primaryYellow),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Html(
                data: page.content,

                style: {
                  "body": Style(
                    fontSize: FontSize(15),
                    lineHeight: LineHeight.number(1.6),
                  ),
                  "h1": Style(
                    fontSize: FontSize(20),
                    fontWeight: FontWeight.bold,
                  ),
                  "li": Style(
                    margin: Margins.only(bottom: 8),
                  ),
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}