%% Load Race Data

load('ACS_Race_2009.mat')
load('ACS_Race_2014.mat')

ACS095YRB02001withann.Properties.VariableNames{4} = 'Pop_2009';
ACS095YRB02001withann(:,'HD02_VD01') = [];
ACS095YRB02001withann.Properties.VariableNames{5} = 'Pop_White_2009';
ACS095YRB02001withann(:,'HD02_VD02') = [];
ACS095YRB02001withann.Properties.VariableNames{6} = 'Pop_Black_2009';
ACS095YRB02001withann(:,'HD02_VD03') = [];
ACS095YRB02001withann.Properties.VariableNames{7} = 'Pop_AmInd_2009';
ACS095YRB02001withann(:,'HD02_VD04') = [];
ACS095YRB02001withann.Properties.VariableNames{8} = 'Pop_Asian_2009';
ACS095YRB02001withann(:,'HD02_VD05') = [];
ACS095YRB02001withann(:,{'HD01_VD06','HD02_VD06','HD01_VD07','HD02_VD07','HD01_VD08','HD02_VD08','HD01_VD09','HD02_VD09','HD01_VD10','HD02_VD10'}) = [];
Race_2009 = ACS095YRB02001withann;


ACS145YRB02001withann.Properties.VariableNames{4} = 'Pop_2014';
ACS145YRB02001withann(:,'HD02_VD01') = [];
ACS145YRB02001withann.Properties.VariableNames{5} = 'Pop_White_2014';
ACS145YRB02001withann(:,'HD02_VD02') = [];
ACS145YRB02001withann.Properties.VariableNames{6} = 'Pop_Black_2014';
ACS145YRB02001withann(:,'HD02_VD03') = [];
ACS145YRB02001withann.Properties.VariableNames{7} = 'Pop_AmInd_2014';
ACS145YRB02001withann(:,'HD02_VD04') = [];
ACS145YRB02001withann.Properties.VariableNames{8} = 'Pop_Asian_2014';
ACS145YRB02001withann(:,'HD02_VD05') = [];
ACS145YRB02001withann(:,{'HD01_VD06','HD02_VD06','HD01_VD07','HD02_VD07','HD01_VD08','HD02_VD08','HD01_VD09','HD02_VD09','HD01_VD10','HD02_VD10'}) = [];
Race_2014 = ACS145YRB02001withann;


load('ACS_Hisp_2009.mat')
load('ACS_Hisp_2014.mat')

ACS095YRB03002withann(:,{'HD01_VD01','HD02_VD01'}) = [];
ACS095YRB03002withann(:,{'HD01_VD02','HD02_VD02'}) = [];
ACS095YRB03002withann.Properties.VariableNames{4} = 'Pop_WhiteNonHisp_2009';
ACS095YRB03002withann(:,{'HD02_VD03','HD01_VD04','HD02_VD04','HD01_VD05','HD02_VD05','HD01_VD06','HD02_VD06','HD01_VD07','HD02_VD07','HD01_VD08','HD02_VD08','HD01_VD09','HD02_VD09','HD01_VD10','HD02_VD10','HD01_VD11','HD02_VD11','HD01_VD12','HD02_VD12'}) = [];
ACS095YRB03002withann.Properties.VariableNames{5} = 'Pop_WhiteHisp_2009';
ACS095YRB03002withann(:,{'HD02_VD13','HD01_VD14','HD02_VD14','HD01_VD15','HD02_VD15','HD01_VD16','HD02_VD16','HD01_VD17','HD02_VD17','HD01_VD18','HD02_VD18','HD01_VD19','HD02_VD19','HD01_VD20','HD02_VD20','HD01_VD21','HD02_VD21'}) = [];


ACS145YRB03002withann(:,{'HD01_VD01','HD02_VD01'}) = [];
ACS145YRB03002withann(:,{'HD01_VD02','HD02_VD02'}) = [];
ACS145YRB03002withann.Properties.VariableNames{4} = 'Pop_WhiteNonHisp_2014';
ACS145YRB03002withann(:,{'HD02_VD03','HD01_VD04','HD02_VD04','HD01_VD05','HD02_VD05','HD01_VD06','HD02_VD06','HD01_VD07','HD02_VD07','HD01_VD08','HD02_VD08','HD01_VD09','HD02_VD09','HD01_VD10','HD02_VD10','HD01_VD11','HD02_VD11','HD01_VD12','HD02_VD12'}) = [];
ACS145YRB03002withann.Properties.VariableNames{5} = 'Pop_WhiteHisp_2014';
ACS145YRB03002withann(:,{'HD02_VD13','HD01_VD14','HD02_VD14','HD01_VD15','HD02_VD15','HD01_VD16','HD02_VD16','HD01_VD17','HD02_VD17','HD01_VD18','HD02_VD18','HD01_VD19','HD02_VD19','HD01_VD20','HD02_VD20','HD01_VD21','HD02_VD21'}) = [];

Hisp_2009 = ACS095YRB03002withann;
Hisp_2014 = ACS145YRB03002withann;

Race_2009 = join(Race_2009,Hisp_2009);
Race_2014 = join(Race_2014,Hisp_2014);
save('Race_2009.mat','Race_2009')
save('Race_2014.mat','Race_2014')

%% Load Income

load('ACS_19001_2009.mat')
load('ACS_19001_2014.mat')

ACS095YRB19001withann.Properties.VariableNames{4} = 'HouseholdsInc_Count_2009';
ACS095YRB19001withann(:,'HD02_VD01') = [];
ACS095YRB19001withann.Properties.VariableNames{5} = 'Inc_LT_10k_2009';
ACS095YRB19001withann(:,'HD02_VD02') = [];
ACS095YRB19001withann.Properties.VariableNames{6} = 'Inc_10k_15k_2009';
ACS095YRB19001withann(:,'HD02_VD03') = [];
ACS095YRB19001withann.Properties.VariableNames{7} = 'Inc_15k_20k_2009';
ACS095YRB19001withann(:,'HD02_VD04') = [];
ACS095YRB19001withann.Properties.VariableNames{8} = 'Inc_20k_25k_2009';
ACS095YRB19001withann(:,'HD02_VD05') = [];
ACS095YRB19001withann.Properties.VariableNames{9} = 'Inc_25k_30k_2009';
ACS095YRB19001withann(:,'HD02_VD06') = [];
ACS095YRB19001withann.Properties.VariableNames{10} = 'Inc_30k_35k_2009';
ACS095YRB19001withann(:,'HD02_VD07') = [];
ACS095YRB19001withann.Properties.VariableNames{11} = 'Inc_35k_40k_2009';
ACS095YRB19001withann(:,'HD02_VD08') = [];
ACS095YRB19001withann.Properties.VariableNames{12} = 'Inc_40k_45k_2009';
ACS095YRB19001withann(:,'HD02_VD09') = [];
ACS095YRB19001withann.Properties.VariableNames{13} = 'Inc_45k_50k_2009';
ACS095YRB19001withann(:,'HD02_VD10') = [];
ACS095YRB19001withann.Properties.VariableNames{14} = 'Inc_50k_60k_2009';
ACS095YRB19001withann(:,'HD02_VD11') = [];
ACS095YRB19001withann.Properties.VariableNames{15} = 'Inc_60k_75k_2009';
ACS095YRB19001withann(:,'HD02_VD12') = [];
ACS095YRB19001withann.Properties.VariableNames{16} = 'Inc_75k_100k_2009';
ACS095YRB19001withann(:,'HD02_VD13') = [];
ACS095YRB19001withann.Properties.VariableNames{17} = 'Inc_100k_125k_2009';
ACS095YRB19001withann(:,'HD02_VD14') = [];
ACS095YRB19001withann.Properties.VariableNames{18} = 'Inc_125k_150k_2009';
ACS095YRB19001withann(:,'HD02_VD15') = [];
ACS095YRB19001withann.Properties.VariableNames{19} = 'Inc_150k_200k_2009';
ACS095YRB19001withann(:,'HD02_VD16') = [];
ACS095YRB19001withann.Properties.VariableNames{20} = 'Inc_200k_GT_2009';
ACS095YRB19001withann(:,'HD02_VD17') = [];

ACS145YRB19001withann.Properties.VariableNames{4} = 'HouseholdsInc_Count_2014';
ACS145YRB19001withann(:,'HD02_VD01') = [];
ACS145YRB19001withann.Properties.VariableNames{5} = 'Inc_LT_10k_2014';
ACS145YRB19001withann(:,'HD02_VD02') = [];
ACS145YRB19001withann.Properties.VariableNames{6} = 'Inc_10k_15k_2014';
ACS145YRB19001withann(:,'HD02_VD03') = [];
ACS145YRB19001withann.Properties.VariableNames{7} = 'Inc_15k_20k_2014';
ACS145YRB19001withann(:,'HD02_VD04') = [];
ACS145YRB19001withann.Properties.VariableNames{8} = 'Inc_20k_25k_2014';
ACS145YRB19001withann(:,'HD02_VD05') = [];
ACS145YRB19001withann.Properties.VariableNames{9} = 'Inc_25k_30k_2014';
ACS145YRB19001withann(:,'HD02_VD06') = [];
ACS145YRB19001withann.Properties.VariableNames{10} = 'Inc_30k_35k_2014';
ACS145YRB19001withann(:,'HD02_VD07') = [];
ACS145YRB19001withann.Properties.VariableNames{11} = 'Inc_35k_40k_2014';
ACS145YRB19001withann(:,'HD02_VD08') = [];
ACS145YRB19001withann.Properties.VariableNames{12} = 'Inc_40k_45k_2014';
ACS145YRB19001withann(:,'HD02_VD09') = [];
ACS145YRB19001withann.Properties.VariableNames{13} = 'Inc_45k_50k_2014';
ACS145YRB19001withann(:,'HD02_VD10') = [];
ACS145YRB19001withann.Properties.VariableNames{14} = 'Inc_50k_60k_2014';
ACS145YRB19001withann(:,'HD02_VD11') = [];
ACS145YRB19001withann.Properties.VariableNames{15} = 'Inc_60k_75k_2014';
ACS145YRB19001withann(:,'HD02_VD12') = [];
ACS145YRB19001withann.Properties.VariableNames{16} = 'Inc_75k_100k_2014';
ACS145YRB19001withann(:,'HD02_VD13') = [];
ACS145YRB19001withann.Properties.VariableNames{17} = 'Inc_100k_125k_2014';
ACS145YRB19001withann(:,'HD02_VD14') = [];
ACS145YRB19001withann.Properties.VariableNames{18} = 'Inc_125k_150k_2014';
ACS145YRB19001withann(:,'HD02_VD15') = [];
ACS145YRB19001withann.Properties.VariableNames{19} = 'Inc_150k_200k_2014';
ACS145YRB19001withann(:,'HD02_VD16') = [];
ACS145YRB19001withann.Properties.VariableNames{20} = 'Inc_200k_GT_2014';
ACS145YRB19001withann(:,'HD02_VD17') = [];

IncDist_2009 = ACS095YRB19001withann;
IncDist_2014 = ACS145YRB19001withann;

load('ACS_19013_2009.mat')
load('ACS_19013_2014.mat')

% ACS095YRB19013withann.Properties.VariableNames{4} = 'IncMedian_2009';
% ACS095YRB19013withann(:,'HD02_VD01') = [];
 IncMedian_2009 = ACS095YRB19013withann;
% ACS145YRB19013withann.Properties.VariableNames{4} = 'IncMedian_2014';
% ACS145YRB19013withann(:,'HD02_VD01') = [];
 IncMedian_2014 = ACS145YRB19013withann;

load('ACS_25070_2009.mat')
load('ACS_25070_2014.mat')


ACS095YRB25070withann.Properties.VariableNames{4} = 'RenterHouseholds_Count_2009';
ACS095YRB25070withann(:,'HD02_VD01') = [];
ACS095YRB25070withann.Properties.VariableNames{5} = 'RentIncPer_LT_10_2009';
ACS095YRB25070withann(:,'HD02_VD02') = [];
ACS095YRB25070withann.Properties.VariableNames{6} = 'RentIncPer_10_15_2009';
ACS095YRB25070withann(:,'HD02_VD03') = [];
ACS095YRB25070withann.Properties.VariableNames{7} = 'RentIncPer_15_20_2009';
ACS095YRB25070withann(:,'HD02_VD04') = [];
ACS095YRB25070withann.Properties.VariableNames{8} = 'RentIncPer_20_25_2009';
ACS095YRB25070withann(:,'HD02_VD05') = [];
ACS095YRB25070withann.Properties.VariableNames{9} = 'RentIncPer_25_30_2009';
ACS095YRB25070withann(:,'HD02_VD06') = [];
ACS095YRB25070withann.Properties.VariableNames{10} = 'RentIncPer_30_35_2009';
ACS095YRB25070withann(:,'HD02_VD07') = [];
ACS095YRB25070withann.Properties.VariableNames{11} = 'RentIncPer_35_40_2009';
ACS095YRB25070withann(:,'HD02_VD08') = [];
ACS095YRB25070withann.Properties.VariableNames{12} = 'RentIncPer_40_50_2009';
ACS095YRB25070withann(:,'HD02_VD09') = [];
ACS095YRB25070withann.Properties.VariableNames{13} = 'RentIncPer_50_GT_2009';
ACS095YRB25070withann(:,'HD02_VD10') = [];
ACS095YRB25070withann.Properties.VariableNames{14} = 'RentIncPer_NA_NA_2009';
ACS095YRB25070withann(:,'HD02_VD11') = [];

ACS145YRB25070withann.Properties.VariableNames{4} = 'RenterHouseholds_Count_2014';
ACS145YRB25070withann(:,'HD02_VD01') = [];
ACS145YRB25070withann.Properties.VariableNames{5} = 'RentIncPer_LT_10_2014';
ACS145YRB25070withann(:,'HD02_VD02') = [];
ACS145YRB25070withann.Properties.VariableNames{6} = 'RentIncPer_10_15_2014';
ACS145YRB25070withann(:,'HD02_VD03') = [];
ACS145YRB25070withann.Properties.VariableNames{7} = 'RentIncPer_15_20_2014';
ACS145YRB25070withann(:,'HD02_VD04') = [];
ACS145YRB25070withann.Properties.VariableNames{8} = 'RentIncPer_20_25_2014';
ACS145YRB25070withann(:,'HD02_VD05') = [];
ACS145YRB25070withann.Properties.VariableNames{9} = 'RentIncPer_25_30_2014';
ACS145YRB25070withann(:,'HD02_VD06') = [];
ACS145YRB25070withann.Properties.VariableNames{10} = 'RentIncPer_30_35_2014';
ACS145YRB25070withann(:,'HD02_VD07') = [];
ACS145YRB25070withann.Properties.VariableNames{11} = 'RentIncPer_35_40_2014';
ACS145YRB25070withann(:,'HD02_VD08') = [];
ACS145YRB25070withann.Properties.VariableNames{12} = 'RentIncPer_40_50_2014';
ACS145YRB25070withann(:,'HD02_VD09') = [];
ACS145YRB25070withann.Properties.VariableNames{13} = 'RentIncPer_50_GT_2014';
ACS145YRB25070withann(:,'HD02_VD10') = [];
ACS145YRB25070withann.Properties.VariableNames{14} = 'RentIncPer_NA_NA_2014';
ACS145YRB25070withann(:,'HD02_VD11') = [];

RentIncPer_2014 = ACS145YRB25070withann;
RentIncPer_2009 = ACS095YRB25070withann;

load('ACS_25071_2009.mat')
load('ACS_25071_2014.mat')

ACS095YRB25071withann.Properties.VariableNames{4} = 'RentIncPerMean_2009';
ACS095YRB25071withann(:,'HD02_VD01') = [];

ACS145YRB25071withann.Properties.VariableNames{4} = 'RentIncPerMean_2014';
ACS145YRB25071withann(:,'HD02_VD01') = [];

RentIncPerMean_2014 = ACS145YRB25071withann;
RentIncPerMean_2009 = ACS095YRB25071withann;


%%

load('ACS_25063_2009.mat')

ACS095YRB25063withann(:,'HD02_VD01') = [];
ACS095YRB25063withann.Properties.VariableNames{4} = 'Rental_Units_2009';
ACS095YRB25063withann.Properties.VariableNames{5} = 'Rental_Units_Cash_2009';
ACS095YRB25063withann(:,'HD02_VD02') = [];
ACS095YRB25063withann.Properties.VariableNames{6} = 'Rent_LT_100_2009';
ACS095YRB25063withann(:,'HD02_VD03') = [];
ACS095YRB25063withann.Properties.VariableNames{7} = 'Rent_100_150_2009';
ACS095YRB25063withann(:,'HD02_VD04') = [];
ACS095YRB25063withann.Properties.VariableNames{8} = 'Rent_150_200_2009';
ACS095YRB25063withann(:,'HD02_VD05') = [];
ACS095YRB25063withann.Properties.VariableNames{9} = 'Rent_200_250_2009';
ACS095YRB25063withann(:,'HD02_VD06') = [];
ACS095YRB25063withann.Properties.VariableNames{10} = 'Rent_250_300_2009';
ACS095YRB25063withann(:,'HD02_VD07') = [];
ACS095YRB25063withann.Properties.VariableNames{11} = 'Rent_300_350_2009';
ACS095YRB25063withann(:,'HD02_VD08') = [];
ACS095YRB25063withann.Properties.VariableNames{12} = 'Rent_350_400_2009';
ACS095YRB25063withann(:,'HD02_VD09') = [];
ACS095YRB25063withann.Properties.VariableNames{13} = 'Rent_400_450_2009';
ACS095YRB25063withann(:,'HD02_VD10') = [];
ACS095YRB25063withann.Properties.VariableNames{14} = 'Rent_440_500_2009';
ACS095YRB25063withann(:,'HD02_VD11') = [];
ACS095YRB25063withann.Properties.VariableNames{15} = 'Rent_500_550_2009';
ACS095YRB25063withann(:,'HD02_VD12') = [];
ACS095YRB25063withann.Properties.VariableNames{16} = 'Rent_550_600_2009';
ACS095YRB25063withann(:,'HD02_VD13') = [];
ACS095YRB25063withann.Properties.VariableNames{17} = 'Rent_600_650_2009';
ACS095YRB25063withann(:,'HD02_VD14') = [];
ACS095YRB25063withann.Properties.VariableNames{18} = 'Rent_650_700_2009';
ACS095YRB25063withann(:,'HD02_VD15') = [];
ACS095YRB25063withann.Properties.VariableNames{19} = 'Rent_700_750_2009';
ACS095YRB25063withann(:,'HD02_VD16') = [];
ACS095YRB25063withann.Properties.VariableNames{20} = 'Rent_750_800_2009';
ACS095YRB25063withann(:,'HD02_VD17') = [];
ACS095YRB25063withann.Properties.VariableNames{21} = 'Rent_800_900_2009';
ACS095YRB25063withann(:,'HD02_VD18') = [];
ACS095YRB25063withann.Properties.VariableNames{22} = 'Rent_900_1000_2009';
ACS095YRB25063withann(:,'HD02_VD19') = [];
ACS095YRB25063withann.Properties.VariableNames{23} = 'Rent_1000_1250_2009';
ACS095YRB25063withann(:,'HD02_VD20') = [];
ACS095YRB25063withann.Properties.VariableNames{24} = 'Rent_1250_1500_2009';
ACS095YRB25063withann(:,'HD02_VD21') = [];
ACS095YRB25063withann.Properties.VariableNames{25} = 'Rent_1500_2000_2009';
ACS095YRB25063withann(:,'HD02_VD22') = [];
ACS095YRB25063withann.Properties.VariableNames{26} = 'Rent_2000_GT_2009';
ACS095YRB25063withann(:,'HD02_VD23') = [];
ACS095YRB25063withann.Properties.VariableNames{27} = 'Rent_NA_NA_2009';
ACS095YRB25063withann(:,'HD02_VD24') = [];


load('ACS_25063_2014.mat')

ACS145YRB25063withann(:,'HD02_VD01') = [];
ACS145YRB25063withann.Properties.VariableNames{4} = 'Rental_Units_2014';
ACS145YRB25063withann.Properties.VariableNames{5} = 'Rental_Units_Cash_2014';
ACS145YRB25063withann(:,'HD02_VD02') = [];
ACS145YRB25063withann.Properties.VariableNames{6} = 'Rent_LT_100_2014';
ACS145YRB25063withann(:,'HD02_VD03') = [];
ACS145YRB25063withann.Properties.VariableNames{7} = 'Rent_100_150_2014';
ACS145YRB25063withann(:,'HD02_VD04') = [];
ACS145YRB25063withann.Properties.VariableNames{8} = 'Rent_150_200_2014';
ACS145YRB25063withann(:,'HD02_VD05') = [];
ACS145YRB25063withann.Properties.VariableNames{9} = 'Rent_200_250_2014';
ACS145YRB25063withann(:,'HD02_VD06') = [];
ACS145YRB25063withann.Properties.VariableNames{10} = 'Rent_250_300_2014';
ACS145YRB25063withann(:,'HD02_VD07') = [];
ACS145YRB25063withann.Properties.VariableNames{11} = 'Rent_300_350_2014';
ACS145YRB25063withann(:,'HD02_VD08') = [];
ACS145YRB25063withann.Properties.VariableNames{12} = 'Rent_350_400_2014';
ACS145YRB25063withann(:,'HD02_VD09') = [];
ACS145YRB25063withann.Properties.VariableNames{13} = 'Rent_400_450_2014';
ACS145YRB25063withann(:,'HD02_VD10') = [];
ACS145YRB25063withann.Properties.VariableNames{14} = 'Rent_440_500_2014';
ACS145YRB25063withann(:,'HD02_VD11') = [];
ACS145YRB25063withann.Properties.VariableNames{15} = 'Rent_500_550_2014';
ACS145YRB25063withann(:,'HD02_VD12') = [];
ACS145YRB25063withann.Properties.VariableNames{16} = 'Rent_550_600_2014';
ACS145YRB25063withann(:,'HD02_VD13') = [];
ACS145YRB25063withann.Properties.VariableNames{17} = 'Rent_600_650_2014';
ACS145YRB25063withann(:,'HD02_VD14') = [];
ACS145YRB25063withann.Properties.VariableNames{18} = 'Rent_650_700_2014';
ACS145YRB25063withann(:,'HD02_VD15') = [];
ACS145YRB25063withann.Properties.VariableNames{19} = 'Rent_700_750_2014';
ACS145YRB25063withann(:,'HD02_VD16') = [];
ACS145YRB25063withann.Properties.VariableNames{20} = 'Rent_750_800_2014';
ACS145YRB25063withann(:,'HD02_VD17') = [];
ACS145YRB25063withann.Properties.VariableNames{21} = 'Rent_800_900_2014';
ACS145YRB25063withann(:,'HD02_VD18') = [];
ACS145YRB25063withann.Properties.VariableNames{22} = 'Rent_900_1000_2014';
ACS145YRB25063withann(:,'HD02_VD19') = [];
ACS145YRB25063withann.Properties.VariableNames{23} = 'Rent_1000_1250_2014';
ACS145YRB25063withann(:,'HD02_VD20') = [];
ACS145YRB25063withann.Properties.VariableNames{24} = 'Rent_1250_1500_2014';
ACS145YRB25063withann(:,'HD02_VD21') = [];
ACS145YRB25063withann.Properties.VariableNames{25} = 'Rent_1500_2000_2014';
ACS145YRB25063withann(:,'HD02_VD22') = [];
ACS145YRB25063withann.Properties.VariableNames{26} = 'Rent_2000_GT_2014';
ACS145YRB25063withann(:,'HD02_VD23') = [];
ACS145YRB25063withann.Properties.VariableNames{27} = 'Rent_NA_NA_2014';
ACS145YRB25063withann(:,'HD02_VD24') = [];

RentDist_2009 = ACS095YRB25063withann;
RentDist_2014 = ACS145YRB25063withann;

%%

load('ACS_25064_2009.mat')
load('ACS_25064_2014.mat')

ACS095YRB25064withann.Properties.VariableNames{4} = 'MedianRent_2009';
ACS095YRB25064withann(:,'HD02_VD01') = [];

ACS145YRB25064withann.Properties.VariableNames{4} = 'MedianRent_2014';
ACS145YRB25064withann(:,'HD02_VD01') = [];

MedianRent_2009 = ACS095YRB25064withann;
MedianRent_2014 = ACS145YRB25064withann;

%%

load('ACS_25003_2009.mat')
load('ACS_25003_2014.mat')

ACS095YRB25003withann.Properties.VariableNames{4} = 'HousingUnits_2009';
ACS095YRB25003withann(:,'HD02_VD01') = [];
ACS095YRB25003withann.Properties.VariableNames{5} = 'OwnerOccupied_2009';
ACS095YRB25003withann(:,'HD02_VD02') = [];
ACS095YRB25003withann.Properties.VariableNames{6} = 'RenterOccupied_2009';
ACS095YRB25003withann(:,'HD02_VD03') = [];

ACS145YRB25003withann.Properties.VariableNames{4} = 'HousingUnits_2014';
ACS145YRB25003withann(:,'HD02_VD01') = [];
ACS145YRB25003withann.Properties.VariableNames{5} = 'OwnerOccupied_2014';
ACS145YRB25003withann(:,'HD02_VD02') = [];
ACS145YRB25003withann.Properties.VariableNames{6} = 'RenterOccupied_2014';
ACS145YRB25003withann(:,'HD02_VD03') = [];

Ownership_2009 = ACS095YRB25003withann;
Ownership_2014 = ACS145YRB25003withann;
%%
load('ACS_25038_2009.mat')
load('ACS_25038_2014.mat')

ACS095YRB25038withann.Properties.VariableNames{4} = 'HousingUnits_2009';
ACS095YRB25038withann(:,'HD02_VD01') = [];
ACS095YRB25038withann.Properties.VariableNames{5} = 'Owner_2009';
ACS095YRB25038withann(:,'HD02_VD02') = [];
ACS095YRB25038withann.Properties.VariableNames{6} = 'Owner_05_09_2009';
ACS095YRB25038withann(:,'HD02_VD03') = [];
ACS095YRB25038withann.Properties.VariableNames{7} = 'Owner_00_04_2009';
ACS095YRB25038withann(:,'HD02_VD04') = [];
ACS095YRB25038withann.Properties.VariableNames{8} = 'Owner_90_99_2009';
ACS095YRB25038withann(:,'HD02_VD05') = [];
ACS095YRB25038withann.Properties.VariableNames{9} = 'Owner_80_89_2009';
ACS095YRB25038withann(:,'HD02_VD06') = [];
ACS095YRB25038withann.Properties.VariableNames{10} = 'Owner_70_79_2009';
ACS095YRB25038withann(:,'HD02_VD07') = [];
ACS095YRB25038withann.Properties.VariableNames{11} = 'Owner_LT_69_2009';
ACS095YRB25038withann(:,'HD02_VD08') = [];
ACS095YRB25038withann.Properties.VariableNames{12} = 'Renter_2009';
ACS095YRB25038withann(:,'HD02_VD09') = [];
ACS095YRB25038withann.Properties.VariableNames{13} = 'Renter_05_09_2009';
ACS095YRB25038withann(:,'HD02_VD10') = [];
ACS095YRB25038withann.Properties.VariableNames{14} = 'Renter_00_04_2009';
ACS095YRB25038withann(:,'HD02_VD11') = [];
ACS095YRB25038withann.Properties.VariableNames{15} = 'Renter_90_99_2009';
ACS095YRB25038withann(:,'HD02_VD12') = [];
ACS095YRB25038withann.Properties.VariableNames{16} = 'Renter_80_89_2009';
ACS095YRB25038withann(:,'HD02_VD13') = [];
ACS095YRB25038withann.Properties.VariableNames{17} = 'Renter_70_79_2009';
ACS095YRB25038withann(:,'HD02_VD14') = [];
ACS095YRB25038withann.Properties.VariableNames{18} = 'Renter_LT_69_2009';
ACS095YRB25038withann(:,'HD02_VD15') = [];
ACS095YRB25038withann.Owner_00_09_2009 = ACS095YRB25038withann.Owner_00_04_2009 + ACS095YRB25038withann.Owner_05_09_2009;
ACS095YRB25038withann(:,'Owner_00_04_2009') = [];
ACS095YRB25038withann(:,'Owner_05_09_2009') = [];
ACS095YRB25038withann.Renter_00_09_2009 = ACS095YRB25038withann.Renter_00_04_2009 + ACS095YRB25038withann.Renter_05_09_2009;
ACS095YRB25038withann(:,'Renter_00_04_2009') = [];
ACS095YRB25038withann(:,'Renter_05_09_2009') = [];
ACS095YRB25038withann.Renter_10_14_2009 = zeros(size(ACS095YRB25038withann.Renter_00_09_2009));
ACS095YRB25038withann.Owner_10_14_2009 = zeros(size(ACS095YRB25038withann.Owner_00_09_2009));

ACS145YRB25038withann.Properties.VariableNames{4} = 'HousingUnits_2014';
ACS145YRB25038withann(:,'HD02_VD01') = [];
ACS145YRB25038withann.Properties.VariableNames{5} = 'Owner_2014';
ACS145YRB25038withann(:,'HD02_VD02') = [];
ACS145YRB25038withann.Properties.VariableNames{6} = 'Owner_10_14_2014';
ACS145YRB25038withann(:,'HD02_VD03') = [];
ACS145YRB25038withann.Properties.VariableNames{7} = 'Owner_00_09_2014';
ACS145YRB25038withann(:,'HD02_VD04') = [];
ACS145YRB25038withann.Properties.VariableNames{8} = 'Owner_90_99_2014';
ACS145YRB25038withann(:,'HD02_VD05') = [];
ACS145YRB25038withann.Properties.VariableNames{9} = 'Owner_80_89_2014';
ACS145YRB25038withann(:,'HD02_VD06') = [];
ACS145YRB25038withann.Properties.VariableNames{10} = 'Owner_70_79_2014';
ACS145YRB25038withann(:,'HD02_VD07') = [];
ACS145YRB25038withann.Properties.VariableNames{11} = 'Owner_LT_69_2014';
ACS145YRB25038withann(:,'HD02_VD08') = [];
ACS145YRB25038withann.Properties.VariableNames{12} = 'Renter_2014';
ACS145YRB25038withann(:,'HD02_VD09') = [];
ACS145YRB25038withann.Properties.VariableNames{13} = 'Renter_10_14_2014';
ACS145YRB25038withann(:,'HD02_VD10') = [];
ACS145YRB25038withann.Properties.VariableNames{14} = 'Renter_00_09_2014';
ACS145YRB25038withann(:,'HD02_VD11') = [];
ACS145YRB25038withann.Properties.VariableNames{15} = 'Renter_90_99_2014';
ACS145YRB25038withann(:,'HD02_VD12') = [];
ACS145YRB25038withann.Properties.VariableNames{16} = 'Renter_80_89_2014';
ACS145YRB25038withann(:,'HD02_VD13') = [];
ACS145YRB25038withann.Properties.VariableNames{17} = 'Renter_70_79_2014';
ACS145YRB25038withann(:,'HD02_VD14') = [];
ACS145YRB25038withann.Properties.VariableNames{18} = 'Renter_LT_69_2014';
ACS145YRB25038withann(:,'HD02_VD15') = [];

Tenure_2009 = ACS095YRB25038withann;
Tenure_2014 = ACS145YRB25038withann;
%%
Rent_2009 = join(MedianRent_2009,RentDist_2009);
Rent_2014 = join(MedianRent_2014,RentDist_2014);
Income_2009 = join(IncDist_2009,RentIncPer_2009);
Income_2009 = join(Income_2009,RentIncPerMean_2009);
Income_2009 = join(Income_2009,IncMedian_2009);
Income_2014 = join(IncDist_2014,RentIncPer_2014);
Income_2014 = join(Income_2014,RentIncPerMean_2014);
Income_2014 = join(Income_2014,IncMedian_2014);
GeoData_2009 = join(Income_2009,Race_2009);
GeoData_2009 = join(GeoData_2009,Rent_2009);
GeoData_2009 = join(GeoData_2009,Tenure_2009);
GeoData_2014 = join(Income_2014,Race_2014);
GeoData_2014 = join(GeoData_2014,Rent_2014);
GeoData_2014 = join(GeoData_2014,Tenure_2014);
save('GeoData.mat','GeoData_2009','GeoData_2014')