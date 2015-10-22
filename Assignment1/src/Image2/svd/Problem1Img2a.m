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
for k=1:25%min(row,column)
    
    Imr=Ur(:,1:k)*Sr(1:k,1:k)*Vr(:,1:k)';
    Imb=Ub(:,1:k)*Sb(1:k,1:k)*Vb(:,1:k)';
    Img=Ug(:,1:k)*Sg(1:k,1:k)*Vg(:,1:k)';
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
plot(1:min(row,column),error);
xlabel('number of singular values');
ylabel('Error');
title('Error for different Singular Values');
