clc;
clear all;
close all;

system('rm -rf MyBigFat.txt');
for i=1:160
   path = strcat(' /tts/arun/PR/A3/hmm/input/zero/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> MyBigFat.txt');
   system(path);
end
for i=1:160
   path = strcat(' /tts/arun/PR/A3/hmm/input/six/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> MyBigFat.txt');
   system(path);
end
for i=1:160
   path = strcat(' /tts/arun/PR/A3/hmm/input/nine/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> MyBigFat.txt');
   system(path);
end
for i=1:160
   path = strcat(' /tts/arun/PR/A3/hmm/input/one/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> MyBigFat.txt');
   system(path);
end
for i=1:160
   path = strcat(' /tts/arun/PR/A3/hmm/input/two/',strcat(int2str(i),'.txt'));
   path = strcat(strcat('cat ',path),' >> MyBigFat.txt');
   system(path);
end

dataset=importdata('/tts/arun/PR/A3/hmm/MyBigFat.txt');
[N D] = size(dataset);
K=64;
[cluster codebook]=kmeans(dataset,K);
cluster=cluster-ones(length(cluster),1);

system('rm -rf class*.txt');
% for class1
fid=fopen('class1.txt','a');
j=1;
for i=1:160
    filename = strcat('/tts/arun/PR/A3/hmm/input/zero/',strcat(int2str(i),'.txt'));
    fileData=importdata(filename);
    l=length(fileData);
    newcluster=cluster(j:j+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fid,'%d ',newcluster);
    fprintf(fid,'\n');
    j=j+l;
end
fclose(fid);
%[i1 ma1]=max(ma);

% for class2
fid=fopen('class2.txt','a');
j=1;
for i=1:160
    filename = strcat('/tts/arun/PR/A3/hmm/input/six/',strcat(int2str(i),'.txt'));
    fileData=importdata(filename);
    l=length(fileData);
    newcluster=cluster(j:j+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fid,'%d ',newcluster);
    fprintf(fid,'\n');
    j=j+l;
end
fclose(fid);
%[i1 ma1]=max(ma);

% for class3
fid=fopen('class3.txt','a');
j=1;
for i=1:160
    filename = strcat('/tts/arun/PR/A3/hmm/input/nine/',strcat(int2str(i),'.txt'));
    fileData=importdata(filename);
    l=length(fileData);
    newcluster=cluster(j:j+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fid,'%d ',newcluster);
    fprintf(fid,'\n');
    j=j+l;
end
fclose(fid);
%[i1 ma1]=max(ma);

% for class4
fid=fopen('class4.txt','a');
j=1;
for i=1:160
    filename = strcat('/tts/arun/PR/A3/hmm/input/one/',strcat(int2str(i),'.txt'));
    fileData=importdata(filename);
    l=length(fileData);
    newcluster=cluster(j:j+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fid,'%d ',newcluster);
    fprintf(fid,'\n');
    j=j+l;
end
fclose(fid);
%[i1 ma1]=max(ma);

% for class5
fid=fopen('class5.txt','a');
j=1;
for i=1:160
    filename = strcat('/tts/arun/PR/A3/hmm/input/two/',strcat(int2str(i),'.txt'));
    fileData=importdata(filename);
    l=length(fileData);
    newcluster=cluster(j:j+l-1);
    %ma(i)=length(newcluster);
    count=fprintf(fid,'%d ',newcluster);
    fprintf(fid,'\n');
    j=j+l;
end
fclose(fid);
%[i1 ma1]=max(ma);


