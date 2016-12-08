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

build/town.json: build/TOWNSSURVEY_POLYM.shp
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='TOWNID' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.99 \
		-- towns=$<

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
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=.95 \
		-- tracts=$<

build/tract2.json: build/tl_2015_25_tract.shp build/aff/ACS_Map_Data.csv
	node_modules/.bin/topojson \
		-o $@ \
		--id-property='GEOID,GEOid2' \
		--external-properties=build/aff/ACS_Map_Data.csv \
		--properties='name=Geography' \
		--properties='areaLand=+d.properties["areaLand"]' \
		--properties='perc_water=+d.properties["Perc_Water"]' \
		--properties='households_2009=+d.properties["HousingUnits_2009"]' \
		--properties='households_2014=+d.properties["HousingUnits_2014"]' \
		--properties='popDen_2009=+d.properties["PopDen_2009"]' \
		--properties='popDen_2014=+d.properties["PopDen_2014"]' \
		--properties='popDen_Change=+d.properties["PopDen_Change"]' \
		--properties='population_2009=+d.properties["Pop_2009"]' \
		--properties='population_2014=+d.properties["Pop_2014"]' \
		--properties='perc_nonWhite_2009=+d.properties["Perc_NonWhite_2009"]' \
		--properties='perc_nonWhite_2014=+d.properties["Perc_NonWhite_2014"]' \
		--properties='perc_Black_2009=+d.properties["Perc_Black_2009"]' \
		--properties='perc_Black_2014=+d.properties["Perc_Black_2014"]' \
		--properties='perc_Hispanic_2009=+d.properties["Perc_Hispanic_2009"]' \
		--properties='perc_Hispanic_2014=+d.properties["Perc_Hispanic_2014"]' \
		--properties='perc_nonWhite_Change=+d.properties["Perc_NonWhite_Change"]' \
		--properties='perc_rentBurdened_2009=+d.properties["Perc_RentBurdened_2009"]' \
		--properties='perc_rentBurdened_2014=+d.properties["Perc_RentBurdened_2014"]' \
		--properties='perc_rentBurdened_Change=+d.properties["Perc_RentBurdened_Change"]' \
		--properties='median_income_2009=+d.properties["IncMedian_2009"]' \
		--properties='median_income_2014=+d.properties["IncMedian_2014"]' \
		--properties='median_rent_2009=+d.properties["MedianRent_2009"]' \
		--properties='median_rent_2014=+d.properties["MedianRent_2014"]' \
		--properties='perc_unitsOwned_2009=+d.properties["Perc_UnitsOwned_2009"]' \
		--properties='perc_unitsOwned_2014=+d.properties["Perc_UnitsOwned_2014"]' \
		--properties='median_rent_Change=+d.properties["RentMedianAbsChange"]' \
		--properties='median_perc_rent_Change=+d.properties["RentMedianPercChange"]' \
		--properties='median_inc_Change=+d.properties["IncMedianAbsChange"]' \
		--properties='median_perc_inc_Change=+d.properties["IncMedianPercChange"]' \
		--properties='displaced=+d.properties["Displaced_2014"]' \
		--properties='arrival=+d.properties["NewArrival_2014"]' \
		--properties='perc_displaced=+d.properties["Perc_Displaced"]' \
		--properties='perc_arrival=+d.properties["Perc_NewArrival"]' \
		--properties='perc_displacedRent=+d.properties["Perc_RenterDisplaced"]' \
		--properties='perc_arrivalRent=+d.properties["Perc_RenterNewArrival"]' \
		--properties='perc_displacedOwn=+d.properties["Perc_OwnerDisplaced"]' \
		--properties='perc_arrivalOwn=+d.properties["Perc_OwnerNewArrival"]' \
		--properties='density_arrival=+d.properties["NewArrival_Density_2014"]' \
		--properties='density_displaced=+d.properties["Displaced_Density_2014"]' \
		--projection='width = 960, height = 600, d3.geo.albers() \
  			.scale( 170000 ) \
  			.rotate( [71.13,0] ) \
  			.center( [0, 42.35] ) \
  			.translate( [width/2,height/2] );' \
		--simplify=1 \
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