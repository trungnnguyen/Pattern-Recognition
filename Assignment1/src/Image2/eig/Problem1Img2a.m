clear;
clc;
I= imread('25.jpg');
[row,column,dim]=size(I);
I=double(I);
Ir=I(:,:,1);
Ir=Ir'*Ir;
Ir=sqrt(Ir/length(Ir));
Ib=I(:,:,2);
Ib=Ib'*Ib;
Ib=sqrt(Ib/length(Ib));
Ig=I(:,:,3);
Ig=Ig'*Ig;
Ig=sqrt(Ig/length(Ig));

[Ur,Dr]=eig(Ir);
[Dr,w]=sort(diag(Dr),'descend');
Dr=diag(Dr);
Ur=Ur(:,w);

[Ub,Db]=eig(Ib);
[Db,w]=sort(diag(Db),'descend');
Db=diag(Db);
Ub=Ub(:,w);

[Ug,Dg]=eig(Ig);
[Dg,w]=sort(diag(Dg),'descend');
Dg=diag(Dg);
Ug=Ug(:,w);

Ir1=I(:,:,1);
Ir1=Ir1*Ir1';
Ir1=sqrt(Ir1/length(Ir1));
Ib1=I(:,:,2);
Ib1=Ib1*Ib1';
Ib1=sqrt(Ib1/length(Ib1));
Ig1=I(:,:,3);
Ig1=Ig1*Ig1';
Ig1=sqrt(Ig1/length(Ig1));
[Vr1,Dr1]=eig(Ir1);
[Dr1,w]=sort(diag(Dr1),'descend');
Dr1=diag(Dr1);
Vr1=Vr1(:,w);

[Vb1,Db1]=eig(Ib1);
[Db1,w]=sort(diag(Db1),'descend');
Db1=diag(Db1);
Vb1=Vb1(:,w);

[Vg1,Dg1]=eig(Ig1);
[Dg1,w]=sort(diag(Dg1),'descend');
Dg1=diag(Dg1);
Vg1=Vg1(:,w);

error=zeros(min(row,column),1);


for k=1:25%min(row,column)-25:min(row,column)

    Imr=Vr1(:,1:k)*Dr(1:k,1:k)*Ur(:,1:k)';
    Imb=Vb1(:,1:k)*Db(1:k,1:k)*Ub(:,1:k)';
    Img=Vg1(:,1:k)*Dg(1:k,1:k)*Ug(:,1:k)';
    
    
    Im=zeros(row,column,3);
    Im(:,:,1)=Imr;
    Im(:,:,2)=Imb;
    Im(:,:,3)=Img;
    h=uint8(Im);
    imwrite(h,strcat(num2str(k),'image.jpg'));
    err=I-Im;
    imwrite(err,strcat(num2str(k),'err.jpg'));
    for i=1:row
        for j=1:column
            for t=1:3
                error(k)=error(k)+err(i,j,t)^2;
            end
        end
    end
    error(k)=sqrt(error(k)/(row*column*3));
end
%imshow(uint8(Im));
plot(1:25,error(801:825));%min(row,column)-25:min(row,column)-1));
xlabel('number of eigen values');
ylabel('Error');
title('Error for different Singular Values');
