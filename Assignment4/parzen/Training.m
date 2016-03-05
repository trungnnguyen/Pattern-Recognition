function Training()
clear;
clc;
% coast=importdata('Classes/coastClass.txt');
% forest=importdata('Classes/forestClass.txt');
% highway=importdata('Classes/highwayClass.txt');
% insidecity=importdata('Classes/insidecityClass.txt');
% mountain=importdata('Classes/mountainClass.txt');
% opencountry=importdata('Classes/opencountryClass.txt');
% street=importdata('Classes/streetClass.txt');
% tallbuilding=importdata('Classes/tallbuildingClass.txt');
% 
% coastTrain=coast(1:round(0.7*size(coast)),:);
% coastTest=coast(round(0.7*size(coast))+1:size(coast),:);
% 
% forestTrain=forest(1:round(0.7*size(forest)),:);
% forestTest=forest(round(0.7*size(forest))+1:size(forest),:);
% 
% highwayTrain=highway(1:round(0.7*size(highway)),:);
% highwayTest=highway(round(0.7*size(highway))+1:size(highway),:);
% 
% insidecityTrain=insidecity(1:round(0.7*size(insidecity)),:);
% insidecityTest=insidecity(round(0.7*size(insidecity))+1:size(insidecity),:);
% 
% mountainTrain=mountain(1:round(0.7*size(mountain)),:);
% mountainTest=mountain(round(0.7*size(mountain))+1:size(mountain),:);
% 
% opencountryTrain=opencountry(1:round(0.7*size(opencountry)),:);
% opencountryTest=opencountry(round(0.7*size(opencountry))+1:size(opencountry),:);
% 
% streetTrain=street(1:round(0.7*size(street)),:);
% streetTest=street(round(0.7*size(street))+1:size(street),:);
% 
% tallbuildingTrain=tallbuilding(1:round(0.7*size(tallbuilding)),:);
% tallbuildingTest=tallbuilding(round(0.7*size(tallbuilding))+1:size(tallbuilding),:);
% 
% TestData=[coastTest;forestTest;highwayTest;insidecityTest;mountainTest;opencountryTest;streetTest;tallbuildingTest];
% save('AllData');

load('AllData');

outputcoast=Classes(coastTrain,TestData);
outputforest=Classes(forestTrain,TestData);
outputhighway=Classes(highwayTrain,TestData);
outputinsidecity=Classes(insidecityTrain,TestData);
outputmountain=Classes(mountainTrain,TestData);
outputopencountry=Classes(opencountryTrain,TestData);
outputstreet=Classes(streetTrain,TestData);
outputtallbuilding=Classes(tallbuildingTrain,TestData);
Output=[outputcoast,outputforest,outputhighway,outputinsidecity,outputmountain,outputopencountry,outputstreet,outputtallbuilding];
save('OutPut','Output');
end

function [px]= Classes(Training, Test)
    
[TestSize,d]=size(Test);
[TrainingSize,~] = size(Training);
px=zeros(1,TestSize);
h=1;
parfor i=1:TestSize
    for j=1:TrainingSize
        
        Kern=Kernel(Test(i,:),Training(j,:),h);
        px(i)=px(i)+Kern;
    end
    px(i)=px(i)/(TrainingSize*(h^d));
end
end




function [Kern]=Kernel(x,xi,h)
t=sum(abs(x-xi))/h;
if(t>0.5)
    Kern=1;
else
    Kern=0;
end
end

