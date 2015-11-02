function TestSol()
clear
clc

[xTestclass1,Fmeanclass1,Fpiclass1,FCclass1]=GMMclass1();
save('class1');
[xTestclass2,Fmeanclass2,Fpiclass2,FCclass2]=GMMclass2();
save('class2');
[xTestclass3,Fmeanclass3,Fpiclass3,FCclass3]=GMMclass3();
save('class3');
[xTestclass4,Fmeanclass4,Fpiclass4,FCclass4]=GMMclass4();
save('class4');
[xTestclass5,Fmeanclass5,Fpiclass5,FCclass5]=GMMclass5();
save('class5');
[xTestclass6,Fmeanclass6,Fpiclass6,FCclass6]=GMMclass6();
save('class6');
[xTestclass7,Fmeanclass7,Fpiclass7,FCclass7]=GMMclass7();
save('class7');
[xTestclass8,Fmeanclass8,Fpiclass8,FCclass8]=GMMclass8();
save('class8');

save('FinalInputs');

xTest=[xTestclass1;xTestclass2;xTestclass3,xTestclass4,xTestclass5,xTestclass6,xTestclass7,xTestclass8];
[D,N]=size(xTest);
ClassGiven=class1s(D,1);
for i=1:D
    if(xTest(i)==xTestclass1(i))
        ClassGiven(i)=1;
    end
    if(xTest(i)==xTestclass2(i))
        ClassGiven(i)=2;
    end
    if(xTest(i)==xTestclass3(i))
        ClassGiven(i)=3;
    end
	if(xTest(i)==xTestclass4(i))
		ClassGiven(i)=4;
	end
	if(xTest(i)==xTestclass5(i))
		ClassGiven(i)=5;
    end
    if(xTest(i)==xTestclass6(i))
        ClassGiven(i)=6;
    end
    if(xTest(i)==xTestclass7(i))
        ClassGiven(i)=7;
    end
    if(xTest(i)==xTestclass8(i))
        ClassGiven(i)=8;
	end
end

g1=class1s(D,1);
g2=class1s(D,1);
g3=class1s(D,1);
g4=class1s(D,1);
g5=class1s(D,1);
g6=class1s(D,1);
g7=class1s(D,1);
g8=class1s(D,1);

ClassExp=g1;
for i=1:D
    for j=1:K
    Norm1=Norms(xTest(i,:),Fmeanclass1(j,:),FCclass1{j});
    g1(i)=g1(i)+Fpiclass1(j)*Norm1;
    
    Norm2=Norms(xTest(i,:),Fmeanclass2(j,:),FCclass2{j});
    g2(i)=g2(i)+Fpiclass2(j)*Norm2;
    
    Norm3=Norms(xTest(i,:),Fmeanclass3(j,:),FCclass3{j});
    g3(i)=g3(i)+Fpiclass3(j)*Norm3;
	
	Norm4=Norms(xTest(i,:),Fmeanclass4(j,:),FCclass4{j});
    g4(i)=g4(i)+Fpiclass4(j)*Norm4;
	
	Norm5=Norms(xTest(i,:),Fmeanclass5(j,:),FCclass5{j});
    g5(i)=g5(i)+Fpiclass5(j)*Norm5;
    
    Norm6=Norms(xTest(i,:),Fmeanclass6(j,:),FCclass6{j});
    g6(i)=g6(i)+Fpiclass6(j)*Norm6;
    
    Norm7=Norms(xTest(i,:),Fmeanclass7(j,:),FCclass7{j});
    g7(i)=g7(i)+Fpiclass7(j)*Norm7;
    
    Norm8=Norms(xTest(i,:),Fmeanclass8(j,:),FCclass8{j});
    g8(i)=g8(i)+Fpiclass8(j)*Norm8;
    
    end
    if(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g1(i))
        ClassExp(i)=1;
    elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g2(i))
        ClassExp(i)=2;
    elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g3(i))
        ClassExp(i)=3;
	elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g4(i))
        ClassExp(i)=4;
	elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g5(i))
        ClassExp(i)=5;
    elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g6(i))
        ClassExp(i)=6;
    elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g7(i))
        ClassExp(i)=7;
    elseif(max(g1(i),g2(i),g3(i),g4(i),g5(i),g6(i),g7(i),g(8))==g8(i))
        ClassExp(i)=8;
    end
end

accuracy=(sum(ClassExp==ClassGiven)/D)*100;

save('FinalOutputs');
end


function [Norm]=Norms(xn,meank,ck)
    %xn=1;meank=0;ck=1;
    %Norm=mvnpdf(xn,meank,ck)
    [n,m]=size(ck);
    Norm=(exp(-0.5*(xn-meank)*pinv(ck)*(xn-meank)'))/(((2*pi)^(n/2))*(det(ck)^0.5));
    
end

