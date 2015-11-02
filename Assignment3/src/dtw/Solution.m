function [DTW1] = Solution(TrainData,TestData)
[trainD,~]=size(TrainData);
[testD,~]=size(TestData);
DTW1=0;
for i=1:testD
    for j=1:trainD
        DTW1=DTW1+DTWDistance(TestData(i,:),TrainData(j,:));
    end
    
end



end

function [DTWfinal] = DTWDistance(x,y)
[~,mx]=size(x);
[~,my]=size(y);
DTW=zeros(mx+1,my+1);

DTW(2:mx+1,1)=inf(mx,1);
DTW(1,2:my+1)=inf(1,my);
DTW(1,1)=0;

for i=2:mx+1
    for j=2:my+1
        cost=abs(x(i-1)-y(j-1));
        DTW(i,j)=cost+min([DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)]);
    end
end
DTWfinal = DTW(mx+1,my+1);

    

end
