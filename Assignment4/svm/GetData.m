function [classTrain labelTrain classTest labelTest] = GetData(classCount, path,testLimit)

% %test
% classCount=8;
% path ='imageClass';
% testLimit = 0.8;

classTrain=[]; labelTrain=[];
classTest=[]; labelTest=[];
for i=1:classCount
    str =strcat(path,'/class');
    str =strcat(str, int2str(i));
    class = importdata(str);
 
    [sizeClass, ~] = size(class);
    randNum = unique(randi(sizeClass,2*sizeClass,1));
    trainIndices = randNum(1:floor(testLimit*sizeClass),:);
    classTrainTemp = class(trainIndices,:);
    temp = class;
    temp (trainIndices,:) = [];
    classTestTemp = temp;
    classTrain = [classTrain; classTrainTemp];
    [r c] =size(classTrainTemp);
    labelTrain = [labelTrain; i*ones(r,1)];
    classTest = [classTest; classTestTemp];
    [r c] =size(classTestTemp);
    labelTest = [labelTest; i*ones(r,1)];
end


