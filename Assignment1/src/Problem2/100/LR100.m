M=dlmread('Data_100_r1_rd_s25.txt');

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
axis=[min(yTest) min(t) max(yTest) max(t)];
scatter(yTest,tTest);
%hold on;
%plot(TestStart:TestEnd,yTest);
xlabel('Test: Predicted Values');
ylabel('Test: Given Values');
%error1=strcat('Error: ',num2str(errorTest));
%legend(error1);

title('Results Comparison');






