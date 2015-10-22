clear;
clc;
fileID1 = fopen('Class1.txt','r');
sizeA1=[2 inf];
A1 = fscanf(fileID1,'%f %f', sizeA1);
A1=A1';

fileID2 = fopen('Class2.txt','r');
sizeA2=[2 inf];
A2 = fscanf(fileID2,'%f %f', sizeA2);
A2=A2';

fileID3 = fopen('Class3.txt','r');
sizeA3=[2 inf];
A3 = fscanf(fileID3,'%f %f', sizeA3);
A3=A3';

[row1,column1]=size(A1);
[row2,column2]=size(A2);
[row3,column3]=size(A3);
row=[int16(row1),int16(row2),int16(row3)];
A=[A1; A2; A3];
A(:,1)=(A(:,1)-mean(A(:,1)))/sqrt(cov(A(:,1)));
A(:,2)=(A(:,2)-mean(A(:,2)))/sqrt(cov(A(:,2)));
N=3;
%N=row/500;
trainRemove=[int16(0.3*row1), int16(0.3*row2),int16(0.3*row3)];
trainData=[];
testData=[];
for i=1:N
    class=ones(int16(0.7*row(i)),1)*i;
    classTest=ones(int16(0.3*row(i)),1)*i;
    B{i,1}=[A(i*row(i)-(row(i)-1):i*row(i) -trainRemove(i),1:2) class]; %#ok<SAGROW>
    trainData=vertcat(trainData,B{i,1}); %#ok<AGROW>
    BTest{i,1}=[A(i*row(i)-trainRemove(i)+1:i*row(i),1:2) classTest];
    testData=vertcat(testData,BTest{i,1});
end
m={5,2};
for caseNumber=1:5
model = BuildBaysianModel(trainData, caseNumber);
classLabels = BayesianClassify(model, testData(:,1:2));
m{caseNumber,1}=(sum(classLabels==testData(:,3))/length(testData(:,3)))*100;
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
