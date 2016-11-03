build/tl_2015_25_tract.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/TRACT/$(notdir $@)

build/tl_2015_25_tract.shp: build/tl_2015_25_tract.zip
	unzip -od $(dir $@) $<
	touch $@

build/tracts.json: build/tl_2015_25_tract.shp
	node_modules/.bin/topojson \
		-o $@ \
		--projection='width = 960, height = 600, d3.geo.albersUsa() \
			.scale(1280) \
			.translate([width / 2, height / 2])' \
		--simplify=.5 \
		-- tracts=$<