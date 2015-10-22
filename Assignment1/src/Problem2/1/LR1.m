M=dlmread('Data_1_r0_s25.txt');

[length,k]=size(M);
TrainStart=1;
TrainLimit=0.7*length;
ValidStart=TrainLimit+1;
ValidEnd=TrainLimit+0.2*length;
TestStart=ValidEnd+1;
TestEnd=length;
x(:,1)=ones(1:length,1);
for i=1:k-1
    x(1:length,i+1)=M(:,i);
end
t(:,1)=M(:,k);

Ans=pinv(x(TrainStart:TrainLimit,:)'*x(TrainStart:TrainLimit,:))*x(TrainStart:TrainLimit,:)'*t(TrainStart:TrainLimit,1);

yTrain=x(TrainStart:TrainLimit,:)*Ans;%   Ans(1)*x(TrainStart:TrainLimit,1)+Ans(2)*x(TrainStart:TrainLimit,2);
yValid=x(ValidStart:ValidEnd,:)*Ans;%   Ans(1)*x(ValidStart:ValidEnd,1)+Ans(2)*x(ValidStart:ValidEnd,2);

tTrain=t(TrainStart:TrainLimit);
tValid=t(ValidStart:ValidEnd);


yTest=x(TestStart:TestEnd,:)*Ans;
tTest=t(TestStart:TestEnd);
%h=polyfit(yTest,tTest,1)




errorTrain=sqrt(sum((tTrain-yTrain).^2)/(0.7*length));
errorValid=sqrt(sum((tValid-yValid).^2)/(0.2*length));
errorTest=sqrt(sum((tTest-yTest).^2)/(0.1*length));


figure();
axis=[min(x(:,2)) min(t) max(x(:,2)) max(t)];
scatter(x(TrainStart:TrainLimit,2),tTrain);
hold on;
plot(x(TrainStart:TrainLimit,2),yTrain);
xlabel('Train: Independent Variable');
ylabel('Train: Dependent Variable');
error1=strcat('Error: ',num2str(errorTrain));
legend(error1);
title('Training Data');

figure();
axis=[min(x(:,2)) min(t) max(x(:,2)) max(t)];
scatter(x(ValidStart:ValidEnd,2),tValid);
hold on;
plot(x(ValidStart:ValidEnd,2),yValid);
xlabel('Validate: Independent Variable');
ylabel('Validate: Dependent Variable');
error1=strcat('Error: ',num2str(errorValid));
legend(error1);
title('Validation Data');

figure();
axis=[min(x(:,2)) min(t) max(x(:,2)) max(t)];
scatter(x(TestStart:TestEnd,2),tTest);
hold on;
plot(x(TestStart:TestEnd,2),yTest);
xlabel('Test: Independent Variable');
ylabel('Test: Dependent Variable');
error1=strcat('Error: ',num2str(errorTest));
legend(error1);

figure();
axis=[min(yTest) min(t) max(yTest) max(t)];
scatter(yTest,tTest);
%hold on;
%plot(TestStart:TestEnd,yTest);
xlabel('Test: Predicted Values');
ylabel('Test: Given Values');
%error1=strcat('Error: ',num2str(errorTest));
%legend(error1);

title('Results Comparison');



