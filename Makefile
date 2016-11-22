build/tl_2015_25_tract.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/TRACT/$(notdir $@)

build/tl_2015_us_county.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/COUNTY/$(notdir $@)


build/tl_2015_25_bg.zip:
	mkdir -p $(dir $@)
	curl -o $@ ftp://ftp2.census.gov/geo/tiger//TIGER2015/BG/$(notdir $@)

build/tl_2015_25_tract.shp: build/tl_2015_25_tract.zip
	unzip -od $(dir $@) $<
	touch $@

build/tl_2015_25_bg.shp: build/tl_2015_25_bg.zip
	unzip -od $(dir $@) $<
	touch $@

build/tl_2015_us_county.shp: build/tl_2015_us_county.zip
	unzip -od $(dir $@) $<
	touch $@

# build/tracts.json: build/tl_2015_25_tract.shp build/R11273541_SL140.csv
# 	node_modules/.bin/topojson \
# 		-o $@ \
# 		--id-property='GEOID,Geo_FIPS' \
# 		--external-properties=build/R11273541_SL140.csv \
# 		--properties='name=Geography' \
# 		--projection='width = 960, height = 600, d3.geo.albers() \
#   			.scale( 170000 ) \
#   			.rotate( [71.13,0] ) \
#   			.center( [0, 42.35] ) \
#   			.translate( [width/2,height/2] );' \
# 		--simplify=.9 \
# 		-- tracts=$<

build/county.json: build/tl_2015_us_county.shp
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='GEOID' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.95 \
		-- counties=$<

build/tracts.json: build/tl_2015_25_tract.shp build/aff/ACS_2010_Combined.csv
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='GEOID,GEOid2' \
		--external-properties=build/aff/ACS_2010_Combined.csv \
		--properties='name=Geography' \
		--properties='households_2009=+d.properties["Inc_Dist_Count_2009"]' \
		--properties='households_2014=+d.properties["Inc_Dist_Count_2014"]' \
		--properties='rentalUnits_2009=+d.properties["RentIncPer_Count_2009"]' \
		--properties='rentalUnits_2014=+d.properties["RentIncPer_Count_2014"]' \
		--properties='medianIncome_2009=+d.properties["IncMedian_2009"]' \
		--properties='medianIncome_2014=+d.properties["IncMedian_2014"]' \
		--properties='medianRent_2009=+d.properties["MedianRent_2009"]' \
		--properties='medianRent_2014=+d.properties["MedianRent_2014"]' \
		--properties='medianRent_Change=+d.properties["MedianRent_Change"]' \
		--properties='medianIncome_Change=+d.properties["IncMedian_Change"]' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.95 \
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
		--properties='county=+d.properties["Geo_COUNTY"]' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.9 \
		-- bgs=$<