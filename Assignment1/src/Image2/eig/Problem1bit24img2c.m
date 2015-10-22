clear;
clc;
I= imread('25.jpg');
[row,column,dim]=size(I);

I=double(I);
I24=zeros(row,column,1);
I24(:,:,1)=I(:,:,1)*2^16+I(:,:,2)*2^8+I(:,:,3);
Im = zeros(row,column,1);
Im=I24;
Im=Im'*Im;
Im=sqrt(Im/length(Im));
[Ur,Dr]=eig(Im);
[Dr,w]=sort(diag(Dr),'descend');
Dr=diag(Dr);
Ur=Ur(:,w);

Ir=I(:,:,1);
Ir=Ir*Ir';
Ir=sqrt(Ir/length(Ir));
[Ur1,Dr1]=eig(Ir);
[Dr1,w]=sort(diag(Dr1),'descend');
Dr1=diag(Dr1);
Ur1=Ur1(:,w);

Imr=zeros(row,column,1);
error=zeros(min(row,column),1);

for k=100:125%min(row,column)-26:min(row,column)-1

	Im=Im'*Im;
	Im=sqrt(Im/length(Im));
	[Ur,Dr]=eig(Im);
	[Dr,w]=sort(diag(Dr),'descend');
	Dr=diag(Dr);
	Ur=Ur(:,w);

	Ir=I(:,:,1);
	Ir=Ir*Ir';
	Ir=sqrt(Ir/length(Ir));
	[Ur1,Dr1]=eig(Ir);
	[Dr1,w]=sort(diag(Dr1),'descend');
	Dr1=diag(Dr1);
	Ur1=Ur1(:,w);

	for s=1:k
        d=randi([1 min(row,column)-s],1,1);
        Vr1(:,d)=[];
        Dr(:,d)=[];
        Dr(d,:)=[];
        Ur(:,d)=[];
        Vb1(:,d)=[];
        Db(:,d)=[];
        Db(d,:)=[];
        Ub(:,d)=[];
        Vg1(:,d)=[];
        Dg(d,:)=[];
        Dg(:,d)=[];
        Ug(:,d)=[];     
    	end    
    
    Imr=Ur1(:,1:k)*Dr(1:k,1:k)*Ur(:,1:k)';
    Im=zeros(row,column,3);
    ImB=rem(Imr,2^8);
    ImG=rem(Imr./(2^8),2^8);
    ImR=Imr./(2^16);
    Im(:,:,1)=ImR;
    Im(:,:,2)=ImG;
    Im(:,:,3)=ImB;
    h=uint8(Im);
    imwrite(h,strcat(num2str(min(row,column)-k),'image.jpg'))
    err=I-Im;
	imwrite(err,strcat(num2str(min(row,column)-k),'err.jpg'))
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
plot(1:25,error(825:-1:801));
xlabel('number of eigen values');
ylabel('Error');
title('Error for 24 bit Eigen Values');
