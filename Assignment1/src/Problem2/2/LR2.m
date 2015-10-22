M=dlmread('Data_2_r0_s25.txt');

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
%figure();
%scatter(TrainStart:TrainLimit,tTrain);
%hold on;
%plot(TrainStart:TrainLimit,yTrain);
%axis([-10 10 -10 10])
%figure();
%scatter(ValidStart:ValidEnd,tValid);
%hold on;
%plot(ValidStart:ValidEnd,yValid);
%axis([-10 10 -10 10])

errorTrain=sqrt(sum((tTrain-yTrain).^2)/(0.7*length));
errorValid=sqrt(sum((tValid-yValid).^2)/(0.2*length));


yTest=x(TestStart:TestEnd,:)*Ans;
tTest=t(TestStart:TestEnd);
%h=polyfit(yTest,tTest,1)

errorTest=sqrt(sum((tTest-yTest).^2)/(0.1*length));

figure();
%axis=[min(x(:,2)) min(x(:,3)) min(t) max(x(:,2)) max(x(:,3) max(t)];
scatter3(x(TrainStart:TrainLimit,2),x(TrainStart:TrainLimit,3),tTrain);
hold on;
scatter3(x(TrainStart:TrainLimit,2),x(TrainStart:TrainLimit,3),yTrain,'+');
xlabel('Train: Independent Variable');
ylabel('Train: Independent Variable');
zlabel('Train: Dependent Variable');
error1=strcat('Error: ',num2str(errorTrain));
legend(error1);
title('Training Data');

figure();
%axis=[min(x(:,2)) min(x(:,3)) min(t) max(x(:,2)) max(x(:,3) max(t)];
scatter3(x(ValidStart:ValidEnd,2),x(ValidStart:ValidEnd,3),tValid);
hold on;
scatter3(x(ValidStart:ValidEnd,2),x(ValidStart:ValidEnd,3),yValid,'+');
xlabel('Validate: Independent Variable');
zlabel('Validate: Dependent Variable');
ylabel('Validate: Independent Variable');
error1=strcat('Error: ',num2str(errorValid));
legend(error1);
title('Validation Data');

figure();
%axis=[min(x(:,2)) min(x(:,3)) min(t) max(x(:,2)) max(x(:,3) max(t)];
scatter3(x(TestStart:TestEnd,2),x(TestStart:TestEnd,3),tTest);
hold on;
scatter3(x(TestStart:TestEnd,2),x(TestStart:TestEnd,3),yTest,'+');
xlabel('Test: Independent Variable');
zlabel('Test: Dependent Variable');
ylabel('Test: independent Variable');
error1=strcat('Error: ',num2str(errorTest));
legend(error1);

figure();
%axis=[min(x(:,2)) min(x(:,3)) min(t) max(x(:,2)) max(x(:,3) max(t)];
scatter(yTest,tTest);
%hold on;
%plot(TestStart:TestEnd,yTest);
xlabel('Test: Predicted Values');
ylabel('Test: Given Values');
%error1=strcat('Error: ',num2str(errorTest));
%legend(error1);

title('Results Comparison');





