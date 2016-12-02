function [ data2000_Rectified ] = rectifyCensus( tractChanges, data2000, data2010, count, perc )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

GeoID_2000 = categorical(data2000.GEOid2);
GeoID_2010 = categorical(data2010.GEOid2);

ChangeID2000 = categorical(tractChanges.GEOID00);
ChangeID2010 = categorical(tractChanges.GEOID10);

midArrayCount = zeros(height(tractChanges),length(count));
midArrayPerc = zeros(height(tractChanges),length(perc));
areaLand     = zeros(height(data2010),1);
areaWater     = zeros(height(data2010),1);

outArrayCount = zeros(height(data2010),length(count));
outArrayPerc = zeros(height(data2010),length(perc));

inArrayCount_2000 = data2000{:,count};
inArrayPerc_2000 = data2000{:,perc};

for ii = 1:height(data2000)
    movedTo = find(ChangeID2000 == GeoID_2000(ii));
    pops = tractChanges.POPPCT00(movedTo)/100;
    for jj = 1:length(movedTo)
        midArrayCount(movedTo(jj),:) = inArrayCount_2000(ii,:)*pops(jj);
        %inArrayPerc_2000(ii,:)
        %midArrayPerc(movedTo(jj),:)
        midArrayPerc(movedTo(jj),:) = inArrayPerc_2000(ii,:);
    end
end

for ii = 1:height(data2010)
    movedTo = find(ChangeID2010 == GeoID_2010(ii));
    pops = tractChanges.POPPCT10(movedTo)/100;
    outArrayCount(ii,:) = nansum(midArrayCount(movedTo,:),1);
    areaLand(ii) = nansum(tractChanges.AREALAND10(movedTo));
    areaWater(ii) = nansum(tractChanges.AREA10(movedTo) - tractChanges.AREALAND10(movedTo));
    for jj = 1:length(movedTo)
        if ~isnan( midArrayPerc(movedTo(jj),:)*pops(jj));
            outArrayPerc(ii,:) = outArrayPerc(ii,:) + midArrayPerc(movedTo(jj),:)*pops(jj);
        end
    end
end

data2000_Rectified = data2010;
data2000_Rectified.Properties.VariableNames = data2000.Properties.VariableNames;
data2000_Rectified{:,count} = outArrayCount;
data2000_Rectified{:,perc} = outArrayPerc;
data2000_Rectified.areaLand = areaLand;
data2000_Rectified.areaWater = areaWater;

end

