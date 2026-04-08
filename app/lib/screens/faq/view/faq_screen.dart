import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/faq/model/faq_model.dart';
import 'package:app/screens/faq/viewmodel/faq_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FaqProvider>().faqData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FaqProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & FAQs"),
      ),
      body: Builder(
        builder: (_) {
          /// ---------- LOADING ----------
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.grey,));
          }

          /// ---------- EMPTY ----------
          if (provider.faqList.isEmpty) {
            return const Center(
              child: Text("No FAQs Available"),
            );
          }

          /// ---------- FAQ LIST ----------
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.faqList.length,
            itemBuilder: (context, index) {
              final faq = provider.faqList[index];
              return _FaqTile(faq: faq);
            },
          );
        },
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  final FaqModel faq;

  const _FaqTile({required this.faq});

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.primaryYellow),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ---------- QUESTION ----------
          ListTile(
            title: Text(
              widget.faq.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),

          /// ---------- ANSWER ----------
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding:
                  const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.faq.content,
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}