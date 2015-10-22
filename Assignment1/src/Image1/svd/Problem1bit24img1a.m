I = imread('25.jpg');
I=double(I);
I24=zeros(256,256,1);
I24(:,:,1)=I(:,:,1)*2^16+I(:,:,2)*2^8+I(:,:,3);

[Ur,Sr,Vr]=svd(I24);
error=zeros(256,1);
for k=1:256
    
    Imr=Ur(:,1:k)*Sr(1:k,1:k)*Vr(:,1:k)';
    Im=zeros(256,256,3);
    ImB=rem(Imr,2^8);
    ImG=rem(Imr./(2^8),2^8);
    ImR=Imr./(2^16);
    
    Im(:,:,1)=ImR;
    Im(:,:,2)=ImG;
    Im(:,:,3)=ImB;
    h=uint8(Im);
    imwrite(h,strcat(num2str(k),'image.jpg'))
    err=I-Im;
    imwrite(err,strcat(num2str(k),'err.jpg'));
    for i=1:256
        for j=1:256
            for t=1:1
                error(k)=error(k)+err(i,j,t)^2;
            end
        end
    end
    error(k)=sqrt(error(k)/(256*256*1));
end
%imshow(uint8(Im));
plot(1:256,error);
xlabel('number of singular values');
ylabel('Error');
title('24-bit: Error for Top Singular Values');