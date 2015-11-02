function TestSol()
clear
clc

% [xTestZero,FmeanZero,FpiZero,FCZero]=GMMzero();
% save('zero');
% 
% [xTestOne,FmeanOne,FpiOne,FCOne]=GMMone();
% save('one');
% [xTestTwo,FmeanTwo,FpiTwo,FCTwo]=GMMtwo();
% save('two');
% [xTestSix,FmeanSix,FpiSix,FCSix]=GMMsix();
% save('six');
% [xTestNine,FmeanNine,FpiNine,FCNine]=GMMnine();
% 
% save('FinalInputs');
load('FinalInputs');
xTest=[xTestZero;xTestOne;xTestTwo;xTestSix;xTestNine];
[D,N]=size(xTest);
[d0,~]=size(xTestZero);
[d1,~]=size(xTestOne);
[d2,~]=size(xTestTwo);
[d6,~]=size(xTestSix);
[d9,~]=size(xTestNine);
ClassGiven=zeros(D,1);
for i=1:D
    if(i<=d0)
        if(xTest(i)==xTestZero(i))
            ClassGiven(i)=0;
        end
    end
    if(i>d0 && i<=d0+d1)
        if(xTest(i)==xTestOne(i-d0))
        ClassGiven(i)=1;
        end
    end
    if(i>d0+d1 && i<=d0+d1+d2)
        if(xTest(i)==xTestTwo(i-d0-d1))
            ClassGiven(i)=2;
        end
    end
    if(i>d0+d1+d2 && i<=d0+d1+d2+d6)
        if(xTest(i)==xTestSix(i-d0-d1-d2))
            ClassGiven(i)=6;
        end
    end
    if(i>d0+d1+d2+d6 && i<=d0+d1+d2+d6+d9)
        if(xTest(i)==xTestNine(i-d0-d1-d2-d6))
		ClassGiven(i)=9;
        end
    end
end
K=60;
g0=zeros(D,1);
g1=zeros(D,1);
g2=zeros(D,1);
g6=zeros(D,1);
g9=zeros(D,1);
ClassExp=g0;
for i=1:D
    for j=1:K
    Norm0=Norms(xTest(i,:),FmeanZero(j,:),FCZero{j});
    g0(i)=g0(i)+FpiZero(j)*Norm0;
    
    Norm1=Norms(xTest(i,:),FmeanOne(j,:),FCOne{j});
    g1(i)=g1(i)+FpiOne(j)*Norm1; 
	
	Norm6=Norms(xTest(i,:),FmeanSix(j,:),FCSix{j});
    g6(i)=g6(i)+FpiSix(j)*Norm6;
	
	Norm9=Norms(xTest(i,:),FmeanNine(j,:),FCNine{j});
    g9(i)=g9(i)+FpiNine(j)*Norm9;
    end
    for l=1:10
     Norm2=Norms(xTest(i,:),FmeanTwo(l,:),FCTwo{l});
    g2(i)=g2(i)+FpiTwo(l)*Norm2;
    end
    if(max([g0(i),g1(i),g2(i),g6(i),g9(i)])==g0(i))
        ClassExp(i)=0;
    elseif(max([g0(i),g1(i),g2(i),g6(i),g9(i)])==g1(i))
        ClassExp(i)=1;
    elseif(max([g0(i),g1(i),g2(i),g6(i),g9(i)])==g2(i))
        ClassExp(i)=2;
	elseif(max([g0(i),g1(i),g2(i),g6(i),g9(i)])==g6(i))
        ClassExp(i)=6;
	elseif(max([g0(i),g1(i),g2(i),g6(i),g9(i)])==g9(i))
        ClassExp(i)=9;
    end
end

accuracy = (sum(ClassExp==ClassGiven)/D)*100;
save('filanOutputs');

end

load('filanOutputs');
function [Norm]=Norms(xn,meank,ck)
    %xn=1;meank=0;ck=1;
    %Norm=mvnpdf(xn,meank,ck)
    [n,m]=size(ck);
    Norm=(exp(-0.5*(xn-meank)*pinv(ck)*(xn-meank)'))/(((2*pi)^(n/2))*(det(ck)^0.5));
    
end

