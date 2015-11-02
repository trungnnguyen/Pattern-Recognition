
for i=14:14
    traindata1=load(strcat(strcat('ans',int2str(i)),'.txt'));
    for j=14:14
        traindata2=load(strcat(strcat('ans',int2str(j)),'.txt'));
        DTW1(i-13,j-13)=Solution(traindata1,traindata2);
    end
    [~,m]=min(DTW1(i-13,:));
    ClassExp(i-13)=m;
end
%for l=1:40
%    if(ClassExp(l)<=5)
%        ClassExp(l)=0;
%    elseif(ClassExp(l)<=10)
%        ClassExp(l)=1;
%    elseif(ClassExp(l)<=15)
%        ClassExp(l)=2;
%    elseif(ClassExp(l)<=20)
%        ClassExp(l)=6;
%    else
%        ClassExp(l)=9;
%    end
%end

save('ClassExp9','ClassExp');



