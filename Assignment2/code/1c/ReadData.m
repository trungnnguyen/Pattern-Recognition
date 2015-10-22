clear;
clc;
fileID = fopen('od_group8.txt','r');
sizeA=[2 inf];
A = fscanf(fileID,'%f %f', sizeA);
A=A';
A(:,1)=(A(:,1)-mean(A(:,1)))/sqrt(cov(A(:,1)));
A(:,2)=(A(:,2)-mean(A(:,2)))/sqrt(cov(A(:,2)));
[row,column]=size(A);
N=row/500;
trainRemove=0.3*500;
trainData=[];
testData=[];
for i=1:N
    class=ones(350,1)*i;
    classTest=ones(150,1)*i;
    B{i,1}=[A(i*500-499:i*500 -trainRemove,1:2) class]; %#ok<SAGROW>
    trainData=vertcat(trainData,B{i,1}); %#ok<AGROW>
    BTest{i,1}=[A(i*500-trainRemove+1:i*500,1:2) classTest];
    testData=vertcat(testData,BTest{i,1});
end
m={5,2};
for caseNumber=1:5
model = BuildBaysianModel(trainData, caseNumber);
classLabels = BayesianClassify(model, testData(:,1:2));
m{caseNumber,1}=(sum(classLabels==testData(:,3))/length(testData(:,3)))*100;
%(sum(classLabels==testData(:,3))/length(testData(:,3)))*100
trainRemove=[0.3*500,0.3*500,0.3*500];
ma(1,1)=sum(classLabels(1:trainRemove(1))==1*ones(trainRemove(1),1));
ma(1,2)=sum(classLabels(1:trainRemove(1))==2*ones(trainRemove(1),1));
ma(1,3)=sum(classLabels(1:trainRemove(1))==3*ones(trainRemove(1),1));

ma(2,1)=sum(classLabels(trainRemove(1)+1:trainRemove(1)+trainRemove(2))==1*ones(trainRemove(2),1));
ma(2,2)=sum(classLabels(trainRemove(1)+1:trainRemove(1)+trainRemove(2))==2*ones(trainRemove(2),1));
ma(2,3)=sum(classLabels(trainRemove(1)+1:trainRemove(1)+trainRemove(2))==3*ones(trainRemove(2),1));

ma(3,1)=sum(classLabels(trainRemove(1)+1+trainRemove(2):trainRemove(1)+trainRemove(2)+trainRemove(3))==1*ones(trainRemove(3),1));
ma(3,2)=sum(classLabels(trainRemove(1)+1+trainRemove(2):trainRemove(1)+trainRemove(2)+trainRemove(3))==2*ones(trainRemove(3),1));
ma(3,3)=sum(classLabels(trainRemove(1)+1+trainRemove(2):trainRemove(1)+trainRemove(2)+trainRemove(3))==3*ones(trainRemove(3),1));
m{caseNumber,2}=ma;
TruePositive(caseNumber)=ma(1,1)/sum(ma(1,:));
TrueNegative(caseNumber)=(ma(2,2)+ma(3,3))/(sum(ma(2,:))+sum(ma(3,:)));
FalseNegative(caseNumber)=(ma(1,2)+ma(1,3))/sum(ma(1,:));
FalsePositive(caseNumber)=(ma(2,1)+ma(3,1))/(sum(ma(2,:))+sum(ma(3,:)));
end
