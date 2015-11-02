clear all;
system('rm -rf class3full.txt');
fileclass=fopen('/home/batman/Desktop/PR/A3/test1/class3full.txt','w');
for outer=1:99
     dirpath = strcat('/home/batman/Desktop/PR/A3/test1/input/class3/',strcat(int2str(outer),'/'));
    D = dir([dirpath, '*.jpg']);
    Num = length(D(not([D.isdir])));
    for inner=1:Num
        try
            % Code to be executed goes here.

            I = imread(strcat(dirpath,strcat(strcat(int2str(inner)),'.jpg')));
             cellSize = 16 ;
             hog = vl_hog(single(I), cellSize, 'verbose') ;

             [sizei sizej sizek] = size(hog);
             for i=1:sizei
                 for j=1:sizej
                     count=fprintf(fileclass,'%d ',hog(i,j,:));

                 end
             end
             fprintf(fileclass,'\n');
        catch
        end
    end
end


dataset=importdata('/home/batman/Desktop/PR/A3/test1/class3full.txt');
[N, D] = size(dataset);
K=64;
[fullclust, c]=kmeans(dataset,K,'MaxIter',100);
fullclust=fullclust-ones(length(fullclust),1);

system('rm -rf class3.txt');
fileclass=fopen('class3.txt','w');
clsno=1;
for i=1:99
    dirpath = strcat('/home/batman/Desktop/PR/A3/test1/input/class3/',strcat(int2str(i),'/'));
    D = dir([dirpath, '*.jpg']);
    l = length(D(not([D.isdir])));
    l=l-1
    newfullclust=fullclust(clsno:clsno+l-1);
        clsno=clsno+l;
    %ma(i)=length(newfullclust);
    count=fprintf(fileclass,'%d ',newfullclust);
    fprintf(fileclass,'\n');

end
fclose(fileclass);


