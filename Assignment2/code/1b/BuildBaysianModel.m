function [model] = BuildBaysianModel(trainData, caseNumber)

switch caseNumber
    case 1
        model = Case1(trainData);
    case 2
        model = Case2(trainData);
    case 3
        model = Case3(trainData);
    case 4
        model = Case4(trainData);
    case 5
        model = Case5(trainData);
    otherwise 
        warning('Choose 1 to 5');
        exit;
  
end

end

function [model]=Case1(trainData)
m = size(trainData, 1); % number of training examples
n = size(trainData, 2) - 1; % number of feature dimension
k = length(unique(trainData(:, end))); % number of classes
A=trainData;
model = cell(k, 2);
for i=1:k
    sno(i)=sum(i==trainData(:,3));
end
%sno=m/k;
C={};
for i=1:k
    C{i}=cov(A(:,1),A(:,2));
    for j=1:n
    avg(i,j)=mean(A((i-1)*sno(i)+1:i*sno(i),j));
    model{i,1}=[model{i,1} avg(i,j)];
    end
    model{i,2}=[model{i,2} C{i}];
end
end

function [model]=Case2(trainData)
m = size(trainData, 1); % number of training examples
n = size(trainData, 2) - 1; % number of feature dimension
k = length(unique(trainData(:, end))); % number of classes
model = cell(k, 2);
for i=1:k
    sno(i)=sum(i==trainData(:,3));
end

C={};
A=trainData;
for i=1:k
    C{i}=cov(A((i-1)*sno(i)+1:i*sno(i),1),A((i-1)*sno(i)+1:i*sno(i),2));
    for j=1:n
    avg(i,j)=mean(A((i-1)*sno(i)+1:i*sno(i),j));
    model{i,1}=[model{i,1} avg(i,j)];
    end
    model{i,2}=[model{i,2} C{i}];
end
end

function [model]=Case3(trainData)
m = size(trainData, 1); % number of training examples
n = size(trainData, 2) - 1; % number of feature dimension
k = length(unique(trainData(:, end))); % number of classes
A=trainData;
model = cell(k, 2);
for i=1:k
    sno(i)=sum(i==trainData(:,3));
end

C={};
for i=1:k
    CovMat=cov(A(:,1),A(:,2)).*eye(n);
    s=0;
    for l=1:n
        s=s+CovMat(l,l);     
    end
    CovMat=eye(n)*(s/n);
    C{i}=CovMat;
    for j=1:n
    avg(i,j)=mean(A((i-1)*sno(i)+1:i*sno(i),j));
    model{i,1}=[model{i,1} avg(i,j)];
    end
    model{i,2}=[model{i,2} C{i}];
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [model]=Case4(trainData)
m = size(trainData, 1); % number of training examples
n = size(trainData, 2) - 1; % number of feature dimension
k = length(unique(trainData(:, end))); % number of classes
A=trainData;
model = cell(k, 2);
for i=1:k
    sno(i)=sum(i==trainData(:,3));
end

C={};
for i=1:k
    C{i}=cov(A(:,1),A(:,2)).*eye(n);
    for j=1:n
    avg(i,j)=mean(A((i-1)*sno(i)+1:i*sno(i),j));
    model{i,1}=[model{i,1} avg(i,j)];
    end
    model{i,2}=[model{i,2} C{i}];
end
end

function [model]=Case5(trainData)
m = size(trainData, 1); % number of training examples
n = size(trainData, 2) - 1; % number of feature dimension
k = length(unique(trainData(:, end))); % number of classes
model = cell(k, 2);
for i=1:k
    sno(i)=sum(i==trainData(:,3));
end

C={};
A=trainData;
for i=1:k
    C{i}=cov(A((i-1)*sno(i)+1:i*sno(i),1),A((i-1)*sno(i)+1:i*sno(i),2)).*eye(n);
    for j=1:n
    avg(i,j)=mean(A((i-1)*sno(i)+1:i*sno(i),j));
    model{i,1}=[model{i,1} avg(i,j)];
    end
    model{i,2}=[model{i,2} C{i}];
end
end