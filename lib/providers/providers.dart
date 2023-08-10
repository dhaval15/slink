import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkding/linkding.dart';

import 'models.dart';
import 'notifiers.dart';

final credentialProvider = StateNotifierProvider<CredentialNotifier, Credential>((ref) => CredentialNotifier());

final servicesProvider = Provider((ref) {
	final credential = ref.watch(credentialProvider);
	if (credential == Credential.none){
		return null;
	}
	return Services(
		client: LinkdingClient(
			token: credential.token,
			baseUrl: credential.host,
		),
		encoder: const JsonEncoder(),
		decoder: const JsonDecoder(),
	);
});

final bookmarksProvider = FutureProvider<List<Bookmark>>((ref) async {
	final service = ref.watch(servicesProvider)?.bookmarks;
	final response = await service?.find();
	return response?.results ?? [];
});

final paginatedBookmarksProvider = StateNotifierProvider<PaginatedBookmarksNotifier, AsyncValue<List<Bookmark>>>((ref) {
	final service = ref.watch(servicesProvider)?.bookmarks;
	return PaginatedBookmarksNotifier(
		initial: const BookmarkFilter(q: '', limit: 5, offset: 0), 
		onFetch: (filter) {
			return service!.find(filter);
		},
	)..init();
});

