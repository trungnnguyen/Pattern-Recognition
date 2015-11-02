K=32;

filecount=101;
system('rm -rf class1full.txt');
for i=1:filecount
   path = strcat(' input/class1/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class1full.txt');
   system(path);
end
dataset=importdata('class1full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class1.txt');
fileclass=fopen('class1.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class1/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);


filecount=100;
system('rm -rf class2full.txt');
for i=1:filecount
   path = strcat(' input/class2/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class2full.txt');
   system(path);
end
dataset=importdata('class2full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class2.txt');
fileclass=fopen('class2.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class2/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);


filecount=97;
system('rm -rf class3full.txt');
for i=1:filecount
   path = strcat(' input/class3/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class3full.txt');
   system(path);
end
dataset=importdata('class3full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class3.txt');
fileclass=fopen('class3.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class3/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);



filecount=100;
system('rm -rf class4full.txt');
for i=1:filecount
   path = strcat(' input/class4/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class4full.txt');
   system(path);
end
dataset=importdata('class4full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class4.txt');
fileclass=fopen('class4.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class4/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);

filecount=99;
system('rm -rf class5full.txt');
for i=1:filecount
   path = strcat(' input/class5/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class5full.txt');
   system(path);
end
dataset=importdata('class5full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class5.txt');
fileclass=fopen('class5.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class5/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);


filecount=98;
system('rm -rf class6full.txt');
for i=1:filecount
   path = strcat(' input/class6/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class6full.txt');
   system(path);
end
dataset=importdata('class6full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class6.txt');
fileclass=fopen('class6.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class6/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);



filecount=98;
system('rm -rf class7full.txt');
for i=1:filecount
   path = strcat(' input/class7/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class7full.txt');
   system(path);
end
dataset=importdata('class7full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class7.txt');
fileclass=fopen('class7.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class7/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);


filecount=99;
system('rm -rf class8full.txt');
for i=1:filecount
   path = strcat(' input/class8/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> class8full.txt');
   system(path);
end
dataset=importdata('class8full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class8.txt');
fileclass=fopen('class8.txt','w');
clsno=1;
for i=1:filecount
    filename = strcat('input/class8/',strcat(int2str(i),'.txt'))
    fileData=importdata(filename);
    l=length(fileData)
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);


