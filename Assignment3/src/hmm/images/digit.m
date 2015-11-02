K=8;


dataset=importdata('./class1full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',1000);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class1.txt');
fileclass=fopen('class1.txt','w');
clsno=1;
for i=1:260
%     dirpath = strcat('/home/batman/Desktop/PR/A3/test1/input/class3/',strcat(int2str(i),'/'));
%     D = dir([dirpath, '*.jpg']);
%     l = length(D(not([D.isdir])));
    l=36;
%     l=l-1
    newfullclust=fullclust(clsno:clsno+l-1);
        clsno=clsno+l;
    %ma(i)=length(newfullclust);
    count=fprintf(fileclass,'%d ',newfullclust);
    fprintf(fileclass,'\n');

end
fclose(fileclass);

dataset=importdata('./class2full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',1000);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class2.txt');
fileclass=fopen('class2.txt','w');
clsno=1;
for i=1:374
%     dirpath = strcat('/home/batman/Desktop/PR/A3/test1/input/class3/',strcat(int2str(i),'/'));
%     D = dir([dirpath, '*.jpg']);
%     l = length(D(not([D.isdir])));
    l=36;
%     l=l-1
    newfullclust=fullclust(clsno:clsno+l-1);
        clsno=clsno+l;
    %ma(i)=length(newfullclust);
    count=fprintf(fileclass,'%d ',newfullclust);
    fprintf(fileclass,'\n');

end
fclose(fileclass);

dataset=importdata('./class3full.txt');
[N, D] = size(dataset);
[fullclust, c]=kmeans(dataset,K,'MaxIter',1000);
fullclust=fullclust-ones(length(fullclust),1);
system('rm -rf class3.txt');
fileclass=fopen('class3.txt','w');
clsno=1;
for i=1:410
%     dirpath = strcat('/home/batman/Desktop/PR/A3/test1/input/class3/',strcat(int2str(i),'/'));
%     D = dir([dirpath, '*.jpg']);
%     l = length(D(not([D.isdir])));
    l=36;
%     l=l-1
    newfullclust=fullclust(clsno:clsno+l-1);
        clsno=clsno+l;
    %ma(i)=length(newfullclust);
    count=fprintf(fileclass,'%d ',newfullclust);
    fprintf(fileclass,'\n');

end
fclose(fileclass);

