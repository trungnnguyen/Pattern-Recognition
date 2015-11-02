K=16;

filecount=500;
dataset=importdata('class2full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class2.txt');
fileclass=fopen('class2.txt','w');
clsno=1;
for i=1:filecount
%    filename = strcat('input/class2/',strcat(int2str(i),'.txt'))
%    fileData=importdata(filename);
%    l=length(fileData)
	l=1
    newcluster=fullclust(clsno:clsno+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fileclass,'%d ',newcluster);
    fprintf(fileclass,'\n');
    clsno=clsno+l;
end
fclose(fileclass);

