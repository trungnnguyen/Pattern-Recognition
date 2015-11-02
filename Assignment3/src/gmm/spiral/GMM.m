function[meanK,piK,CK]= GMM(meanK,piK,C,xTrain)
    [K,n]=size(piK);
    [D,N]=size(xTrain);
    meanK=meanK;
    piK=piK;
    CK=C;
    for i=1:K
       CK{i}=diag(diag(CK{i}+0.0001*eye(N)));
    end

    difflike=10000;
    newlikelihood=0;
    
    for i=1:D
        likelihood=0;
        for j=1:K
            
            Norm=Norms(xTrain(i,:),meanK(j,:),CK{j});
            likelihood=likelihood+piK(j)*Norm;
        end
        newlikelihood=newlikelihood+log(likelihood);
    end

    Gamma=ones(D,K);
    
    while(difflike> 1e-3)
        for i=1:D
            G=0;
            
            for j=1:K
                Norm=Norms(xTrain(i,:),meanK(j,:),CK{j});
                G=G+piK(j)*Norm;
            end
            
            for l=1:K
                Norm= Norms(xTrain(i,:),meanK(l,:),CK{l});   
                Gamma(i,l)=piK(l)*Norm/G;
            end
        
        end
        Nk=ones(K,1);
        for j=1:K
            meanK(j,:)=0;
            Nk(j)=0;
            for i=1:D
                meanK(j,:)=meanK(j,:)+Gamma(i,j)*xTrain(i,:);
                Nk(j)=Nk(j)+Gamma(i,j);
            end
            meanK(j,:)=meanK(j,:)/Nk(j);
        end
        
        for j=1:K
            CK{j}=0;
            for i=1:D
                CK{j}=CK{j}+Gamma(i,j)*((xTrain(i,:)-meanK(j,:))'*(xTrain(i,:)-meanK(j,:)));
            end
            CK{j}=CK{j}/Nk(j);
           
        end
        oldlikelihood=newlikelihood;        
        newlikelihood=0;
        for i=1:D
            likelihood=0;
            for j=1:K
                Norm=Norms(xTrain(i,:),meanK(j,:),CK{j});
                likelihood=likelihood+piK(j)*Norm;
            end
            newlikelihood=newlikelihood+log(likelihood);
        end

        difflike=(newlikelihood-oldlikelihood)/D



    end

    FinalOutPut=cell(K,3);
    for i=1:K
        FinalOutPut{i,1}=meanK(i,:);
        FinalOutPut{i,2}=piK(i,:);
        FinalOutPut{i,3}=CK{i};
    end
   
end

    
function [Norm]=Norms(xn,meank,ck)
    
    %Norm=mvnpdf(xn,meank,ck);
    [n,m]=size(ck);
    Norm=(exp(-0.5*(xn-meank)*pinv(ck)*(xn-meank)'))/(((2*pi)^n/2)*(det(ck)^0.5));
    
end
