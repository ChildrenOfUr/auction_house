library item_browse;

import '../imports.dart';

@CustomTag('item-browse')
class ItemBrowse extends PolymerElement {
	@published Map<String, List<Item>> items = toObservable({});

	ItemBrowse.created() : super.created() {
		//generate the item list dynamically from the server in the future
		getItems();
	}

	getItems() async {
		String response = await HttpRequest.getString('$serverAddress/getItems');
		List<Item> items = decode(JSON.decode(response), Item);
		items.forEach((Item i) {
			if(this.items.containsKey(i.category)) {
				this.items[i.category].add(i);
			}
			else {
				this.items[i.category] = [i];
			}
		});
	}

	search(Event event, var detail, Element target) async {
		String itemName = target.text;

		new Message('itemDetailRequest', itemName);

		//show auctions
		Map parameters = {'where':"item_name = '$itemName'"};
		List<Auction> auctions = await AuctionSearch.getAuctions(parameters);
		new Message('auctionSearchUpdate', auctions);
	}
}