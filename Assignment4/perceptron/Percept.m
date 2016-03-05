load('AllData')
Traindata=[coastTrain;forestTrain;highwayTrain;insidecityTrain;mountainTrain;opencountryTrain;streetTrain;tallbuildingTrain];
ClassTrain=[1*ones(size(coastTrain(:,1)),1);2*ones(size(forestTrain(:,1)),1);3*ones(size(highwayTrain(:,1)),1);4*ones(size(insidecityTrain(:,1)),1);5*ones(size(mountainTrain(:,1)),1);6*ones(size(opencountryTrain(:,1)),1);7*ones(size(streetTrain(:,1)),1);8*ones(size(tallbuildingTrain(:,1)),1)];
n=8;
alpha=0.6;
ClassTest=[1*ones(size(coastTest(:,1)),1);2*ones(size(forestTest(:,1)),1);3*ones(size(highwayTest(:,1)),1);4*ones(size(insidecityTest(:,1)),1);5*ones(size(mountainTest(:,1)),1);6*ones(size(opencountryTest(:,1)),1);7*ones(size(streetTest(:,1)),1);8*ones(size(tallbuildingTest(:,1)),1)];
[TrainSize,d]=size(Traindata);
[TestSize,d]=size(TestData);
a = rand(d+1, n);
y = ones(TrainSize,n);
counter=1;

for i = 1: n
    classPos = find(ClassTrain(:,1)==i);
    [classSize(i), ~] = size(classPos);
    Data = Traindata(classPos,:);
    y(counter:(classSize(i)+counter-1), i) = 1;
    counter = counter+classSize(i);
end

iter=2000;



for i = 1:n
    for k = 1:iter
        allSum = zeros(d+1, 1);
        for j = 1:TrainSize
            temp = Traindata(j,:)';
            z = [1; temp];
            value = y(j,i)*a(:,i)'*z;
            if(value<0)
                allSum=allSum+y(j,i)*z;
            end
        end
        a(:,i) = a(:,i)+alpha*allSum;
    end
end
finalValues = zeros(TestSize, n);
for j = 1:TestSize
    temp = TestData(j,:)';
    z = [1; temp];
    for i = 1:n
        finalValues(j,i)=a(:,i)'*z;
    end
end
[~, classified] = max(finalValues, [], 2);
confusionMatrix = confusionmat(ClassTest, classified);
accuracy = (trace(confusionMatrix)/(sum(sum(confusionMatrix))))*100
save('All')