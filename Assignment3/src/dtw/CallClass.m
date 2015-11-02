tic; 

% your code goes here


for i=1:60
    traindata1=load(strcat(int2str(i),'.txt'));
    for j=1:60
        traindata2=load(strcat(int2str(j),'.txt'));
        DTW1(i,j)=Solution(traindata1,traindata2);
    end
    DTWsum(i)=sum(DTW1(i,:));
end
for l=1:5
[~,n]=min(DTWsum)
filen(l)=n;
DTWsum(n)=inf;
end

save('TrainOutPut9','filen');
TimeSpent = toc;