I = imread('25.jpg');
I=double(I);
Ir=I(:,:,1);
Ib=I(:,:,2);
Ig=I(:,:,3);
[Vr,Dr]=eig(Ir);
[Dr,w]=sort(diag(Dr),'descend');
Dr=diag(Dr);
Vr=Vr(:,w);
[Vb,Db]=eig(Ib);
[Db,w]=sort(diag(Db),'descend');
Db=diag(Db);
Vb=Vb(:,w);
[Vg,Dg]=eig(Ig);
[Dg,w]=sort(diag(Dg),'descend');
Dg=diag(Dg);
Vg=Vg(:,w);
%imshow(uint8(I));
error=zeros(256,1);
MaxBit=256;
for k=1:MaxBit
    
    Imr=Vr(:,k:MaxBit)*Dr(k:MaxBit,k:MaxBit)*pinv(Vr(:,k:MaxBit));
    Imb=Vb(:,k:MaxBit)*Db(k:MaxBit,k:MaxBit)*pinv(Vb(:,k:MaxBit));
    Img=Vg(:,k:MaxBit)*Dg(k:MaxBit,k:MaxBit)*pinv(Vg(:,k:MaxBit));
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
xlabel('number of eigen values');
ylabel('Error');
title('Error for Bottom Eigen Values');