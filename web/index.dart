import "package:polymer/polymer.dart";
import "package:redstone_mapper/mapper_factory.dart";

//it's necessary to import every lib that contains encodable classes
import "package:cou_auction_house/auction_house/item.dart";
import "package:cou_auction_house/auction_house/auction.dart";

main() {
	bootstrapMapper();
	initPolymer();
}