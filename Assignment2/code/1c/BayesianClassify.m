function [classLabels] = BayesianClassify(model, testData)

m = size(testData, 1); % number of examples
n = size(testData, 2); % number of feature dimension
k = size(model, 1); % number of classes
classLabels  = zeros(m,1);
term1=1/sqrt((2*pi)^n);

for j=1:k
        xmu=testData-(bsxfun(@times,ones(m,2),model{j,1}));
        termdenom=1/sqrt(det(model{j,2}));
        for i=1:m
        g(i,j)= term1*(exp(-0.5*(xmu(i,:))*pinv(model{j,2})*(xmu(i,:))'))*termdenom;
        end
        lng(:,j)=log(g(:,j));
end
%maxvalue=max(lng');
%maxvalue=max(g');
[x,y]=max(lng');
classLabels=y';

% for i=1:m
%     %[x,y]=ind2sub(size(lng),find(lng==maxvalue(i)));
%     [x,y]=ind2sub(size(g),find(lng(i,1:k)==maxvalue(i)));
%     %[x,y]=ind2sub(size(g),find(g(i,1:k)==maxvalue(i)));
%     
%     classLabels(i)=y;
% end
x=testData(:,1);
y=testData(:,2);
z1=g(:,1);
z2=g(:,2);
z3=g(:,3);

figure();
F1=TriScatteredInterp(x,y,z1);
F2=TriScatteredInterp(x,y,z2);
F3=TriScatteredInterp(x,y,z3);
qx = linspace(min(x),max(x),100); % define your grid here
qy = linspace(min(y),max(y),100);
[qx,qy] = meshgrid(qx,qy);

qz1 = F1(qx,qy);
qz2 = F2(qx,qy);
qz3 = F3(qx,qy);
hold on;
h1 = surf(qx,qy,qz1,'LineStyle','none');
h2 = surf(qx,qy,qz2,'LineStyle','none');
h3 = surf(qx,qy,qz3,'LineStyle','none');
figure();
hold on;
c1 = contour(qx,qy,qz1);
c2 = contour(qx,qy,qz2);
c3 = contour(qx,qy,qz3);
%hold on;
%plot3(x,y,z1,'k.')

end
