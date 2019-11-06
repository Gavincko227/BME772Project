
% xlsread('SMNI_CMI_TRAIN/Data1.csv');
M = readtable('Data1.csv');
%[~,~,data1] = xlsread('SMNI_CMI_TRAIN/Data1.csv');

t = 0:1:(height(M)-1);

structarray = table2struct(M);

sample = [(0:1:255) ; zeros(1,256)]';
for i=1:length(structarray)
    
    for j=1:256
        if structarray(i).sampleNum == (j-1)
            sample(j,2) = sample(j,2) + structarray(i).sensorValue;
        end
    end
end      
%plot(extractfield(structarray,'time'),extractfield(structarray, 'sensorValue'));

plot(sample(:,1),sample(:,2));