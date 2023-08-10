import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/providers.dart';
import '../ui/ui.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
		final bookmarks = ref.watch(paginatedBookmarksProvider);
		//WARNING: not a efficient way to do this but, ...
		final moreBookmarksAvailable = ref.read(paginatedBookmarksProvider.notifier).moreBookmarksAvailable;
    return Scaffold(
			appBar: AppBar(title: const Text('Slink'),),
			body: 
			bookmarks.when(
				loading: () => const Text('Loading'),
				data: (data) => ListView.builder(
					itemCount: moreBookmarksAvailable ? data.length + 1: data.length,
					itemBuilder: (context, index) {
						if (index == data.length) {
							return ElevatedButton(
								onPressed: () {
									ref.read(paginatedBookmarksProvider.notifier).next();
								},
								child: const Text('Load More'),
							);
						}
						final bookmark = data[index];
						return Padding(
							padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
						  child: BookmarkTile(
						  	bookmark: bookmark
						  ),
						);
					},
				),
				error: (err, stack) => Text('Error: $err \n$stack'),
			),
		);
  }
}

