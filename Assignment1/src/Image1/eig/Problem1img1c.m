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
for k=1:255
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
    for s=1:k
        d=randi([1 256-s],1,1);
        Vr(:,d)=[];
        Dr(:,d)=[];
        Dr(d,:)=[];
        %Vr(:,d)=[];
        Vb(:,d)=[];
        Db(:,d)=[];
        Db(d,:)=[];
        %Vb(:,d)=[];
        Vg(:,d)=[];
        Dg(d,:)=[];
        Dg(:,d)=[];
        %Vg(:,d)=[];     
    end    
    Imr=Vr(:,:)*Dr(:,:)*pinv(Vr(:,:));
    Imb=Vb(:,:)*Db(:,:)*pinv(Vb(:,:));
    Img=Vg(:,:)*Dg(:,:)*pinv(Vg(:,:));
    Im=zeros(256,256,3);
    Im(:,:,1)=Imr;
    Im(:,:,2)=Imb;
    Im(:,:,3)=Img;
    h=uint8(Im);
    imwrite(h,strcat(num2str(256-k),'image.jpg'));
    err=I-Im;
    imwrite(err,strcat(num2str(256-k),'err.jpg'))
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
title('Error for Random eigen Values');