library search_result_list;

import '../../imports.dart';

@CustomTag('search-result-list')
class SearchResultList extends PolymerElement
{
	@published List<SearchResult> results = toObservable([]);

	SearchResultList.created() : super.created()
	{
		new Service(['searchUpdate'], (m) {
			results.clear();
			m.forEach((Item item) => results.add(new SearchResult(item)));
		});
	}

	showDetails(Event event, var detail, Element target) async
	{
		String itemName = target.attributes['data-item-name'];
		transmit('itemDetailRequest', itemName);

		//show auctions
		Map parameters = {'where':"item_name = '$itemName'"};
		List<Auction> auctions = await AuctionSearch.getAuctions(parameters);
		transmit('auctionSearchUpdate',auctions);
	}

	changeFav(Event event, var detail, InputElement target)
	{
		String itemName = target.attributes['data-item-name'];
		SearchResult.changeFav(itemName,target.checked);

		if(target.checked)
			transmit('addFavToList', results.singleWhere((SearchResult result) => result.item.name == itemName));
		else
			transmit('removeFavFromList', results.singleWhere((SearchResult result) => result.item.name == itemName));
	}
}