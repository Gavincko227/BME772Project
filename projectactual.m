clear sample;
for i=1:2 
    figure;
    file = ['Data', num2str(i), '.csv']
%file = 'Data1.csv';    
    file = readtable(file);
    structarray = table2struct(file);
    sample = [(0:1:255) ; zeros(1,256)]';
    % electrode = zeros(255,2);    
    %sample = [zeros(1,256)]';
    freq = zeros(129,1);
%     figure;
    for j = 0:3 
        j
%         [sample, freq(:,j+1)] = electrodeplot(j, structarray, sample);
        [sample, freq(:,j+1)] = electrodeplot(j, structarray, sample);
        
        
        electrode_mean(i,j+1) = mean(sample(:,j+1));
        electrode_var(i,j+1) = std(sample(:,j+1));



    end
    
    extractwave(1, 4, sample, "Delta");
    extractwave(4, 7, sample, "Theta");
    extractwave(8, 12, sample, "Alpha");
    extractwave(12, 30, sample, "Beta");
    extractwave(30, 100, sample, "Gamma");
end