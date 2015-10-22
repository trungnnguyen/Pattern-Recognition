I = imread('25.jpg');
[row,column,dim]=size(I);
I=double(I);
Ir=I(:,:,1);
Ib=I(:,:,2);
Ig=I(:,:,3);
[Ur,Sr,Vr]=svd(Ir);
[Ub,Sb,Vb]=svd(Ib);
[Ug,Sg,Vg]=svd(Ig);
%imshow(uint8(I));
error=zeros(min(row,column),1);
MaxBit=min(row,column);
for k=1:25%min(row,column)
    
    Imr=Ur(:,k:MaxBit)*Sr(k:MaxBit,k:MaxBit)*Vr(:,k:MaxBit)';
    Imb=Ub(:,k:MaxBit)*Sb(k:MaxBit,k:MaxBit)*Vb(:,k:MaxBit)';
    Img=Ug(:,k:MaxBit)*Sg(k:MaxBit,k:MaxBit)*Vg(:,k:MaxBit)';
    Im=zeros(row,column,3);
    Im(:,:,1)=Imr;
    Im(:,:,2)=Imb;
    Im(:,:,3)=Img;
    h=uint8(Im);
    imwrite(h,strcat(num2str(k),'image.jpg'))
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
%plot(1:min(row,column),error(min(row,column):-1:1));
plot(1:25,error(1:25));
xlabel('number of singular values');
ylabel('Error');
title('Error for Bottom Singular Values');