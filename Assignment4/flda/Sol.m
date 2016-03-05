load('AllData')
%TestData=[coastTest;forestTest];
Traindata=[coastTrain;forestTrain;highwayTrain;insidecityTrain;mountainTrain;opencountryTrain;streetTrain;tallbuildingTrain];
%Traindata=[coastTrain;forestTrain];
ClassTrain=[1*ones(size(coastTrain(:,1)),1);2*ones(size(forestTrain(:,1)),1);3*ones(size(highwayTrain(:,1)),1);4*ones(size(insidecityTrain(:,1)),1);5*ones(size(mountainTrain(:,1)),1);6*ones(size(opencountryTrain(:,1)),1);7*ones(size(streetTrain(:,1)),1);8*ones(size(tallbuildingTrain(:,1)),1)];
%ClassTrain=[1*ones(size(coastTrain(:,1)),1);2*ones(size(forestTrain(:,1)),1)];
n=8;
%n=2;
alpha=0.6;
ClassTest=[1*ones(size(coastTest(:,1)),1);2*ones(size(forestTest(:,1)),1);3*ones(size(highwayTest(:,1)),1);4*ones(size(insidecityTest(:,1)),1);5*ones(size(mountainTest(:,1)),1);6*ones(size(opencountryTest(:,1)),1);7*ones(size(streetTest(:,1)),1);8*ones(size(tallbuildingTest(:,1)),1)];
%ClassTest=[1*ones(size(coastTest(:,1)),1);2*ones(size(forestTest(:,1)),1)];
[TrainSize,d]=size(Traindata);
[TestSize,d]=size(TestData);

for i = 1:n
    classPos = find(ClassTrain(:,1)==i);
    [classSize(i), ~] = size(classPos);
    Data = Traindata(classPos,:);
    meanClass(:,i) = mean(Data);
end

meanAll = mean(Traindata);

Sw = zeros(d);
for i = 1:n
    classPos = find(ClassTrain(:,1)==i);
    Data = Traindata(classPos,:);
    for j =1:classSize(i)
        temp = (Data(j,:)'-meanClass(:,i)) * (Data(j,:)'-meanClass(:,i))';
        Sw = Sw + temp;
    end
end

Sb = zeros(d,d);
for i = 1:n
    t=classSize(i) * (meanClass(:,i) - meanAll') * (meanClass(:,i) - meanAll')';
    Sb = Sb + t;
end

[E D] = eig(pinv(Sw) * Sb);
[D,I] = sort(diag(D), 'descend');
E = E(:,I);
E = E(:,1:n-1);

YTrain = Traindata *E;
YTest = TestData *E;

for i = 1:n
    classPos = find(ClassTrain(:,1)==i);
    Data = YTrain(classPos,:);
    meanYClass(:,i) = mean(Data);
end

testPos = find(ClassTest(:,1)==1);
[YclassSize(1), ~] = size(testPos);
classExp = ones (YclassSize(1), 1);
for i = 2:n
    testPos = find(ClassTest(:,1)==i);
    [YclassSize(i), ~] = size(testPos);
    temp = i *ones (YclassSize(i), 1);
    classExp = [classExp; temp];
end

[sizeYTest, ~] = size(YTest);
dist = zeros(sizeYTest, n);
for j = 1:sizeYTest
    for i = 1:n
        dist(j,i) = norm(YTest(j,:)'-meanYClass(:,i));
    end
end
[~, MinDist] = min(dist, [], 2);

confusionMatrix = confusionmat (classExp, MinDist);
accuracy = ( trace(confusionMatrix) / (sum(sum(confusionMatrix))) ) *100
save('All');