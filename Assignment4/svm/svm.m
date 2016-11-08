%matlabpool('open',2);
clc;
clear all;
close all;

% Obtain input data - both train and test
[classTrain labelTrain classTest labelTest] = GetData(8,'imageClass',0.8);

% labels = classTrain(:,1);
% classTrain = classTrain(:,2:end);
% labelsTest = classTest(:,1);
% classTest = classTest(:,2:end);

%model = svmtrain(labels, classTrain, '-t 2 -c 250 -g 0.001');
% model = svmtrain(labelTrain, classTrain, '-t 0 -c 8 -q');
model = svmtrain(labelTrain, classTrain, '-t 1 -s 0 -c 100 -b 1 -g 32');
[predicted_label, accuracy, decision_values] = svmpredict(labelTest, classTest, model ,'-b 1');

confusionMatrix = confusionmat(labelTest, predicted_label);

plotmatrix =diag(1./sum(confusionMatrix,2))*confusionMatrix;
% plotmatrix = confusionMatrix / max(confusionMatrix);












% 
% 
% 
% 
% mat = confusionMatrix;
% imagesc(mat);            %# Create a colored plot of the matrix values
% colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
%                          %#   black and lower values are white)
% 
% textStrings = num2str(mat(:));  %# Create strings from the matrix values
% textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
% [x,y] = meshgrid(1:8);   %# Create x and y coordinates for the strings
% hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
%                 'HorizontalAlignment','center');
% midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
% textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
%                                              %#   text color of the strings so
%                                              %#   they can be easily seen over
%                                              %#   the background color
% set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors
% 
% set(gca,'XTick',1:8,...                         %# Change the axes tick marks
%         'XTickLabel',{'A','B','C','D','E','F','G','H'},...  %#   and tick labels
%         'YTick',1:8,...
%         'YTickLabel',{'A','B','C','D','E','F','G','H'},...
%         'TickLength',[0 0]);
%     
% 
