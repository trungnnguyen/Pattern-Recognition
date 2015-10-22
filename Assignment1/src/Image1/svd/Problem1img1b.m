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
MaxBit=256;
for k=1:MaxBit
    
    Imr=Ur(:,k:MaxBit)*Sr(k:MaxBit,k:MaxBit)*Vr(:,k:MaxBit)';
    Imb=Ub(:,k:MaxBit)*Sb(k:MaxBit,k:MaxBit)*Vb(:,k:MaxBit)';
    Img=Ug(:,k:MaxBit)*Sg(k:MaxBit,k:MaxBit)*Vg(:,k:MaxBit)';
    Im=zeros(256,256,3);
    Im(:,:,1)=Imr;
    Im(:,:,2)=Imb;
    Im(:,:,3)=Img;
    h=uint8(Im);
    imwrite(h,strcat(num2str(k),'image.jpg'))
    err=I-Im;
    imwrite(err,strcat(num2str(k),'err.jpg'));
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
title('Error for Bottom Singular Values');