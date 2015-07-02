library favorite_list;

import '../../imports.dart';

@CustomTag('favorite-list')
class FavoriteList extends PolymerElement {
	@published List<SearchResult> results = toObservable([]);
	Map<String, String> favSaves = {};

	FavoriteList.created() : super.created() {
		if(window.localStorage.containsKey('favSaves'))
			favSaves = JSON.decode(window.localStorage['favSaves']);

		new Service(['addFavToList'], (m) {
			results.add(m);
		});
		new Service(['removeFavFromList'], (m) {
			results.removeWhere((SearchResult result) => result.item.name == m.item.name);
		});

		getItems();
	}

	getItems() async {
		String regex = "(";
		favSaves.forEach((String itemName, String isFav) {
			if(isFav == "true")
				regex += "$itemName|";
		});
		//add a bogus item to the end so that we don't have a hanging OR clause
		regex += "invlaid_item)";

		String response = await HttpRequest.getString('$serverAddress/getItems?name=$regex&isRegex=true');
		List<Item> items = decode(response, type: const TypeHelper<List<Item>>().type);

		results.clear();
		items.forEach((Item item) => results.add(new SearchResult(item)));
	}

	showDetails(Event event, var detail, Element target) async
	{
		String itemName = target.attributes['data-item-name'];
		transmit('itemDetailRequest', itemName);

		//show auctions
		Map parameters = {'where':"item_name = '$itemName'"};
		List<Auction> auctions = await AuctionSearch.getAuctions(parameters);
		transmit('auctionSearchUpdate', auctions);
	}

	removeFav(Event event, var detail, Element target) {
		String itemName = target.attributes['data-item-name'];
		SearchResult.changeFav(itemName, false);
		results.removeWhere((SearchResult result) => result.item.name == itemName);
	}
}