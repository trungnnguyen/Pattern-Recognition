I = imread('25.jpg');
I=double(I);
Ir=I(:,:,1);

Ib=I(:,:,2);
Ig=I(:,:,3);
[Ur,Sr,Vr]=svd(Ir);
[Ub,Sb,Vb]=svd(Ib);
[Ug,Sg,Vg]=svd(Ig);
%imshow(uint8(I));
error=zeros(256,1);
for k=1:255
    [Ur,Sr,Vr]=svd(Ir);
    [Ub,Sb,Vb]=svd(Ib);
    [Ug,Sg,Vg]=svd(Ig);
    for s=1:k
        d=randi([1 256-s],1,1);
        Ur(:,d)=[];
        Sr(:,d)=[];
        Sr(d,:)=[];
        Vr(:,d)=[];
        Ub(:,d)=[];
        Sb(:,d)=[];
        Sb(d,:)=[];
        Vb(:,d)=[];
        Ug(:,d)=[];
        Sg(d,:)=[];
        Sg(:,d)=[];
        Vg(:,d)=[];     
    end    
    Imr=Ur(:,:)*Sr(:,:)*Vr(:,:)';
    Imb=Ub(:,:)*Sb(:,:)*Vb(:,:)';
    Img=Ug(:,:)*Sg(:,:)*Vg(:,:)';
    Im=zeros(256,256,3);
    Im(:,:,1)=Imr;
    Im(:,:,2)=Imb;
    Im(:,:,3)=Img;
    h=uint8(Im);
    imwrite(h,strcat(num2str(256-k),'image.jpg'))
    err=I-Im;
    for i=1:256
        for j=1:256
            for t=1:3
                error(k)=error(k)+err(i,j,t)^2;
            end
        end
    end
    error(k)=sqrt(error(k)/(256*256*3));
end
%imshow(uint8(Im));
plot(1:256,error(256:-1:1));
xlabel('number of singular values');
ylabel('Error');
title('Error for Random Singular Values');