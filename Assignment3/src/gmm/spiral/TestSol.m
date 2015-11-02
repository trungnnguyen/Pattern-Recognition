function TestSol()
clear
clc
%[xTestZero,FmeanZero,FpiZero,FCZero]=GMMzero();
%[xTestOne,FmeanOne,FpiOne,FCOne]=GMMone();
%[xTestTwo,FmeanTwo,FpiTwo,FCTwo]=GMMTwo();
%[xTestSix,FmeanSix,FpiSix,FCSix]=GMMSix();
%[xTestNine,FmeanNine,FpiNine,FCNine]=GMMNine();

%save('FinalInputs');
load('FinalInputs.mat');
[K,~]=size(FmeanOne);
xTest=[xTestZero;xTestOne];%;xTestTwo,xTestSix,xTestNine];
[D,N]=size(xTest);
[d0,~]=size(xTestZero);
[d1,~]=size(xTestOne);
ClassGiven=zeros(D,1);
for i=1:D
    if(i<=d0)
        if(xTest(i)==xTestZero(i))
            ClassGiven(i)=0;
        end
    end
    if(i<=d0+d1 && i>d0)
        if(xTest(i)==xTestOne(i-d0))
            ClassGiven(i)=1;
        end
    end
%     if(xTest(i)==xTestTwo(i))
%         ClassGiven(i)=2;
%     end
% 	if(xTest(i)==xTestSix(i))
% 		ClassGiven(i)=6;
% 	end
% 	if(xTest(i)==xTestNine(i))
% 		ClassGiven(i)=9;
% 	end
end

g0=zeros(D,1);
g1=zeros(D,1);
%g2=zeros(D,1);
%g6=zeros(D,1);
%g9=zeros(D,1);
ClassExp=g0;
for i=1:D
    for j=1:K
    Norm0=Norms(xTest(i,:),FmeanZero(j,:),FCZero{j});
    g0(i)=g0(i)+FpiZero(j)*Norm0;
    
    Norm1=Norms(xTest(i,:),FmeanOne(j,:),FCOne{j});
    g1(i)=g1(i)+FpiOne(j)*Norm1;
    
%     Norm2=Norms(xTest(i,:),FmeanTwo(j,:),FCTwo{j});
%     g2(i)=g2(i)+FpiTwo(j)*Norm2;
% 	
% 	Norm6=Norms(xTest(i,:),FmeanSix(j,:),FCSix{j});
%     g6(i)=g6(i)+FpiSix(j)*Norm6;
% 	
% 	Norm9=Norms(xTest(i,:),FmeanNine(j,:),FCNine{j});
%     g9(i)=g2(i)+FpiNine(j)*Norm2;
    end
    if(max(g0(i),g1(i))==g0(i))
        ClassExp(i)=0;
    elseif(max(g0(i),g1(i))==g1(i))
        ClassExp(i)=1;
    
    end
end

accuracy=(sum(ClassExp==ClassGiven)/D)*100
save('results')

load('results')


end


function [Norm]=Norms(xn,meank,ck)
    
    %Norm=mvnpdf(xn,meank,ck);
    [n,m]=size(ck);
    Norm=(exp(-0.5*(xn-meank)*pinv(ck)*(xn-meank)'))/(((2*pi)^n/2)*(det(ck)^0.5));
    
end
