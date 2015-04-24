library item;

import 'imports.dart';

class Item {
	@Field()
	String category;
	@Field()
	String iconUrl;
	@Field()
	String spriteUrl;
	@Field()
	String toolAnimation;
	@Field()
	String name;
	@Field()
	String description;
	@Field()
	int price;
	@Field()
	int stacksTo;
	@Field()
	int iconNum = 4;
	@Field()
	bool isContainer = false;

	String style;
}