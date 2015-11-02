%I= importdata('out.txt');
I =[ClassExp ClassGiven];
[sizex sizey] = size(I);

%cnfusion
msize=5;
M = zeros(msize,msize);
D = zeros(sizex,msize);
for i=1:sizex
    M(int8(I(i,1))+1,int8(I(i,2))+1)= M(int8(I(i,1))+1,int8(I(i,2))+1)+1;
    D(i,int8(I(i,2))+1)=1;
end

%roc
%figure1=figure;
%plotroc(I(25:49,1)',I(25:49,2)')
figure(1),

[X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','0');
plot(X,Y);
xlabel('False positive rate');
ylabel('True positive rate');
title('ROC Curve');
hold on;
[X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','1');
plot(X,Y);
hold on;
[X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','2');
plot(X,Y);
hold on;
[X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','3');
plot(X,Y);
hold on;
[X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','4');
plot(X,Y);
% hold on;
% [X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','2');
% plot(Y,X);
% hold on;
% [X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','3');
% plot(Y,X);
% hold on;
% [X,Y,T,AUC] = perfcurve(I(1:25686,1)',I(1:25686,2)','4');
% plot(Y,X);
I1=getframe(1);
imwrite(I1.cdata,'plotROC1.jpg');


%DET

figure(2),
detx=[D(1:150,1);D(151:295,2)]
%dety=[D(25:48,1);D(49:72,1);D(1:24,2);D(49:72,2);D(1:24,3);D(25:48,3)];
dety=[D(151:295,1);D(1:150,2)];
[pmiss pfa] = Compute_DET(detx,dety);

plot(pfa,pmiss);
xlabel('False alarm');
ylabel('Miss rate');
title('DET Curve');

%Plot_DET(pmiss,pfa,'1');
I2=getframe(2);
imwrite(I2.cdata,'plotDET.jpg');


close all;
