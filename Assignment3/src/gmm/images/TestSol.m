function TestSol()
clear
clc
[xTestHW,FmeanHW,FpiHW,FCHW]=GMMHighWay();
[xTestM,FmeanM,FpiM,FCM]=GMMMountains();
[xTestOC,FmeanOC,FpiOC,FCOC]=GMMOpenCountry();
save('FinalInputs');

xTest=[xTestHW;xTestM;xTestOC];
[D,N]=size(xTest);
ClassGiven=zeros(D,1);
for i=1:D
    if(xTest(i)==xTestHW(i))
        ClassGiven(i)=1;
    end
    if(xTest(i)==xTestM(i))
        ClassGiven(i)=2;
    end
    if(xTest(i)==xTestOC(i))
        ClassGiven(i)=3;
    end
end

gHW=zeros(D,1);
gM=zeros(D,1);
gOC=zeros(D,1);
ClassExp=gHW;
for i=1:D
    for j=1:K
    NormHW=Norms(xTest(i,:),FmeanHW(j,:),FCHW{j});
    gHW(i)=gHW(i)+FpiHW(j)*NormHW;
    
    NormM=Norms(xTest(i,:),FmeanM(j,:),FCM{j});
    gM(i)=gM(i)+FpiM(j)*NormM;
    
    NormOC=Norms(xTest(i,:),FmeanOC(j,:),FCOC{j});
    gOC(i)=gOC(i)+FpiOC(j)*NormOC;
    end
    if(max(gHW(i),gM(i),gOC(i))==gHW(i))
        ClassExp(i)=1;
    elseif(max(gHW(i),gM(i),gOC(i))==gM(i))
        ClassExp(i)=2;
    elseif(max(gHW(i),gM(i),gOC(i))==gOC(i))
        ClassExp(i)=3;
    end
end

accuracy=(sum(ClassExp==ClassGiven)/D)*100;

end


function [Norm]=Norms(xn,meank,ck)
    
    %Norm=mvnpdf(xn,meank,ck);
    [n,m]=size(ck);
    Norm=(exp(-0.5*(xn-meank)*pinv(ck)*(xn-meank)'))/(((2*pi)^(n/2))*(det(ck)^0.5));
    
end
