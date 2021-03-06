load('GeoData.mat')
count = [4:31,34:40,42:80];
perc  = [32,33,41];

tractChanges = readtable('tiger/ma25trf.csv');

[ GeoData ] = rectifyCensus( tractChanges, GeoData_2009, GeoData_2014, count, perc );

GeoData_Joined = join(GeoData,GeoData_2014);
writetable(GeoData_Joined,'ACS_2010_Combined.csv');


%%

infFactor = 1.1021;
sqm2sqmi = 1/(1609.34^2);

mapVars = table(GeoData_Joined.GEOid);
mapVars.GEOid2 = GeoData_Joined.GEOid2;
mapVars.areaLand = GeoData_Joined.areaLand*sqm2sqmi;
mapVars.Perc_Water = GeoData_Joined.areaWater./(GeoData_Joined.areaLand + GeoData_Joined.areaWater);

mapVars.Pop_2009 = GeoData_Joined.Pop_2009;
mapVars.PopDen_2009 = mapVars.Pop_2009./mapVars.areaLand;
mapVars.Pop_Black_2009 = GeoData_Joined.Pop_Black_2009;
mapVars.Pop_Hispanic_2009 = GeoData_Joined.Pop_WhiteHisp_2009;
mapVars.Pop_WhiteNH_2009 = GeoData_Joined.Pop_WhiteNonHisp_2009;
mapVars.Pop_NonWhite_2009 = mapVars.Pop_2009 - mapVars.Pop_WhiteNH_2009;
mapVars.Perc_NonWhite_2009 = mapVars.Pop_NonWhite_2009./mapVars.Pop_2009;
mapVars.Perc_Black_2009 = mapVars.Pop_Black_2009./mapVars.Pop_2009;
mapVars.Perc_Hispanic_2009 = mapVars.Pop_Hispanic_2009./mapVars.Pop_2009;


mapVars.Pop_2014 = GeoData_Joined.Pop_2014;
mapVars.PopDen_2014 = mapVars.Pop_2014./mapVars.areaLand;
mapVars.Pop_Black_2014 = GeoData_Joined.Pop_Black_2014;
mapVars.Pop_Hispanic_2014 = GeoData_Joined.Pop_WhiteHisp_2014;
mapVars.Pop_WhiteNH_2014 = GeoData_Joined.Pop_WhiteNonHisp_2014;
mapVars.Pop_NonWhite_2014 = mapVars.Pop_2014 - mapVars.Pop_WhiteNH_2014;
mapVars.Perc_NonWhite_2014 = mapVars.Pop_NonWhite_2014./mapVars.Pop_2014;
mapVars.Perc_Black_2014 = mapVars.Pop_Black_2014./mapVars.Pop_2014;
mapVars.Perc_Hispanic_2014 = mapVars.Pop_Hispanic_2014./mapVars.Pop_2014;


mapVars.PopDen_Change = mapVars.PopDen_2014 - mapVars.PopDen_2009;


mapVars.IncMedian_2009 = GeoData_Joined.IncMedian_2009*infFactor;
mapVars.MedianRent_2009 = GeoData_Joined.MedianRent_2009*infFactor;
mapVars.IncMedian_2014 = GeoData_Joined.IncMedian_2014;
mapVars.MedianRent_2014 = GeoData_Joined.MedianRent_2014;
mapVars.IncMedian_2009(mapVars.IncMedian_2009<=5000) = nan;
mapVars.MedianRent_2009(mapVars.MedianRent_2009<=10) = nan;
mapVars.MedianRent_2009(mapVars.MedianRent_2014./mapVars.MedianRent_2009 > 2.5) = nan;
mapVars.MedianRent_2009(mapVars.MedianRent_2009./mapVars.MedianRent_2014 > 2.5) = nan;
nRentBurdened_2009 = GeoData_Joined.RenterHouseholds_Count_2009 - ...
    (GeoData_Joined.RentIncPer_LT_10_2009 + GeoData_Joined.RentIncPer_10_15_2009 + ...
    GeoData_Joined.RentIncPer_15_20_2009 + GeoData_Joined.RentIncPer_20_25_2009 + GeoData_Joined.RentIncPer_25_30_2009);
mapVars.Perc_RentBurdened_2009 = nRentBurdened_2009./GeoData_Joined.RenterHouseholds_Count_2009;
nRentBurdened_2014 = GeoData_Joined.RenterHouseholds_Count_2014 - ...
    (GeoData_Joined.RentIncPer_LT_10_2014 + GeoData_Joined.RentIncPer_10_15_2014 + ...
    GeoData_Joined.RentIncPer_15_20_2014 + GeoData_Joined.RentIncPer_20_25_2014 + GeoData_Joined.RentIncPer_25_30_2014);
mapVars.Perc_RentBurdened_2014 = nRentBurdened_2014./GeoData_Joined.RenterHouseholds_Count_2014;
mapVars.Perc_RentBurdened_Change = mapVars.Perc_RentBurdened_2014 - mapVars.Perc_RentBurdened_2009;

mapVars.HousingUnits_2009 = GeoData_Joined.HousingUnits_2009;
mapVars.OwnedUnits_2009 = GeoData_Joined.Owner_2009;
mapVars.RentedUnits_2009 = GeoData_Joined.Renter_2009;
mapVars.Perc_UnitsOwned_2009 = mapVars.OwnedUnits_2009./mapVars.HousingUnits_2009;

mapVars.HousingUnits_2014 = GeoData_Joined.HousingUnits_2014;
mapVars.OwnedUnits_2014 = GeoData_Joined.Owner_2014;
mapVars.RentedUnits_2014 = GeoData_Joined.Renter_2014;
mapVars.Perc_UnitsOwned_2014 = mapVars.OwnedUnits_2014./mapVars.HousingUnits_2014;

mapVars.NewArrivalOwner_2014 = GeoData_Joined.Owner_10_14_2014;
mapVars.DisplacedOwner_2014 = GeoData_Joined.Owner_2009 - (GeoData_Joined.Owner_2014 - GeoData_Joined.Owner_10_14_2014);
mapVars.NewArrivalRenter_2014 = GeoData_Joined.Renter_10_14_2014;
mapVars.DisplacedRenter_2014 = GeoData_Joined.Renter_2009 - (GeoData_Joined.Renter_2014 - GeoData_Joined.Renter_10_14_2014);
mapVars.Displaced_2014 = mapVars.DisplacedRenter_2014 + mapVars.DisplacedOwner_2014;
mapVars.NewArrival_2014 = mapVars.NewArrivalRenter_2014 + mapVars.NewArrivalOwner_2014;
mapVars.Displaced_Density_2014 = mapVars.Displaced_2014./mapVars.areaLand;
mapVars.NewArrival_Density_2014 = mapVars.NewArrival_2014./mapVars.areaLand;

mapVars.Perc_OwnerDisplaced = mapVars.DisplacedOwner_2014./GeoData_Joined.Owner_2009;
mapVars.Perc_RenterDisplaced = mapVars.DisplacedRenter_2014./GeoData_Joined.Renter_2009;
mapVars.Perc_OwnerNewArrival = mapVars.NewArrivalOwner_2014./GeoData_Joined.Owner_2014;
mapVars.Perc_RenterNewArrival = mapVars.NewArrivalRenter_2014./GeoData_Joined.Renter_2014;
mapVars.Perc_Displaced = mapVars.Displaced_2014./GeoData_Joined.HousingUnits_2009;
mapVars.Perc_NewArrival = mapVars.NewArrival_2014./mapVars.HousingUnits_2014;

mapVars.IncMedianAbsChange = mapVars.IncMedian_2014 - mapVars.IncMedian_2009;
mapVars.RentMedianAbsChange = mapVars.MedianRent_2014 - mapVars.MedianRent_2009;
mapVars.IncMedianPercChange = (mapVars.IncMedian_2014 - mapVars.IncMedian_2009)./mapVars.IncMedian_2009;
mapVars.RentMedianPercChange = (mapVars.MedianRent_2014 - mapVars.MedianRent_2009)./mapVars.MedianRent_2009;

mapVars.Pop_NonWhite_Change = mapVars.Pop_NonWhite_2014 - mapVars.Pop_NonWhite_2009;
mapVars.Perc_NonWhite_Change = mapVars.Perc_NonWhite_2014 - mapVars.Perc_NonWhite_2009;
mapVars.Perc_Displaced(mapVars.Perc_Displaced < 0) = 0;
mapVars.Perc_NonWhite_Change(mapVars.Perc_NonWhite_Change < -0.5) = nan;
mapVars.PopDen_Change(mapVars.PopDen_Change < -1e4) = nan;
mapVars.Perc_OwnerDisplaced(mapVars.Perc_OwnerDisplaced < 0) = 0;
mapVars.Perc_RenterDisplaced(mapVars.Perc_RenterDisplaced < 0) = 0;

writetable(mapVars,'ACS_Map_Data.csv');
%%
mdl = fitlm(mapVars,'Perc_Displaced~Perc_NonWhite_2009^2+Perc_NonWhite_2009:IncMedian_2009+Perc_UnitsOwned_2009^2 +Perc_UnitsOwned_2009:Perc_NonWhite_2009 +Perc_RentBurdened_2009^2+IncMedian_2009^2 + PopDen_2009' ...
    ,'Weights',mapVars.HousingUnits_2009)
%%
mdl2 = fitlm(mapVars,'Perc_Displaced~Perc_NonWhite_2009^2+Perc_UnitsOwned_2009+ MedianRent_2009 + PopDen_2009*Perc_NonWhite_2009' ...
    ,'Weights',mapVars.HousingUnits_2009)

%%
mdl2 = fitlm(mapVars,'Perc_Displaced~1+Perc_NonWhite_Change + Perc_Black_2009+Perc_Hispanic_2009 + MedianRent_2009 + Perc_UnitsOwned_2009 + PopDen_2009' ...
,'Weights',mapVars.HousingUnits_2009)

%%
mdl2 = fitlm(mapVars,'Perc_NonWhite_Change~1 +PopDen_Change+ IncMedianPercChange+RentMedianPercChange + Perc_UnitsOwned_2009 + Perc_RentBurdened_2009 + MedianRent_2009 + IncMedian_2009+ PopDen_2009' ...
,'Weights',mapVars.HousingUnits_2009)