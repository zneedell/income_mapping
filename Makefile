build/tl_2015_25_tract.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/TRACT/$(notdir $@)

build/tl_2015_25_bg.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/BG/$(notdir $@)

build/tl_2015_25_tract.shp: build/tl_2015_25_tract.zip
	unzip -od $(dir $@) $<
	touch $@

build/tl_2015_25_bg.shp: build/tl_2015_25_bg.zip
	unzip -od $(dir $@) $<
	touch $@

build/tracts.json: build/tl_2015_25_tract.shp build/R11273541_SL140.csv
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='GEOID,Geo_FIPS' \
		--external-properties=build/R11273541_SL140.csv \
		--properties='name=Geography' \
		--properties='population=+d.properties["SE_T014_001"]' \
		--properties='meanincome=+d.properties["SE_T057_001"]' \
		--properties='households=+d.properties["SE_T080_001"]' \
		--properties='medianrent=+d.properties["SE_T104_001"]' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 150000 ) \
  			.rotate( [71.2,0] ) \
  			.center( [0, 42.313] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.5 \
		-- tracts=$<

build/bgs.json: build/tl_2015_25_bg.shp build/BG_2014.csv
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='GEOID,Geo_FIPS' \
		--external-properties=build/BG_2014.csv \
		--properties='name=Geography' \
		--properties='population=+d.properties["SE_T014_001"]' \
		--properties='meanincome=+d.properties["SE_T057_001"]' \
		--properties='households=+d.properties["SE_T080_001"]' \
		--properties='medianrent=+d.properties["SE_T104_001"]' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.8 \
		-- bgs=$<