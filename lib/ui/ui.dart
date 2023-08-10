import 'package:flutter/material.dart';
import 'package:linkding/linkding.dart';

class BookmarkTile extends StatelessWidget {
  final Bookmark bookmark;

  BookmarkTile({required this.bookmark})
      : super(key: ValueKey('BookmarkTile #${bookmark.id}'));

  @override
  Widget build(BuildContext context) {
    final title = bookmark.prettyTitle;
    final url = bookmark.url;
    final description = bookmark.prettyDescription;
    final List<String> tagNames = bookmark.tagNames;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
					Text(
						title ?? url,
						style: const TextStyle(
							fontWeight: FontWeight.bold,
							fontSize: 18,
						),
					),
					if (title != null) Text(url, style: const TextStyle(color: Colors.blue)),
					if (description != null) Text(description),
          Wrap(
            spacing: 8,
            children: tagNames
                .map((tag) => Text('#$tag'))
                .toList(),
          ),
        ].spaced(const SizedBox(height: 4)),
      ),
    );
  }
}

extension BookmarkExtension on Bookmark {
	String? get prettyTitle => title.isNotEmpty ? title : websiteTitle;
	String? get prettyDescription => description.isNotEmpty ? description : websiteDescription;
}

extension ListWidgetExtension on List<Widget> {
	List<Widget> spaced(Widget space) => [
		for (final widget in this)
			... [
				widget,
				space,
			],
	]..removeLast();
}
