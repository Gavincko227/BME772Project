clear sample;

M = cell(10,1);
for i=1:10
    %figure;
    file = ['/Users/gavinckoalagesan/Library/Mobile Documents/com~apple~CloudDocs/Year4/BME 772/LABS/Project/Alcoholics/SMNI_CMI_TRAIN/Data', num2str(i), '.csv']
%file = 'Data1.csv';    
    file = readtable(file);
    structarray = table2struct(file);
    sample = [(0:1:255) ; zeros(1,256)]';
    sample(:,1) = sample(:,1)/256;
%     diff_var = [(0:1:255) ; zeros(1,256)]';
%     mobility = [(0:1:255) ; zeros(1,256)]';
%     diff_mobility = [(0:1:255) ; zeros(1,256)]';
%     formfactor = [(0:1:255) ; zeros(1,256)]';
    % electrode = zeros(255,2);    
    %sample = [zeros(1,256)]';
    freq = zeros(129,1);
%     figure;
    for j = 0:63 
        j
%         [sample, freq(:,j+1)] = electrodeplot(j, structarray, sample);
%         [sample, freq(:,j+1)] = electrodeplot(j, structarray, sample);
%         
%         
%         electrode_mean(i,j+1) = mean(sample(:,j+1));
%         electrode_var(i,j+1) = std(sample(:,j+1));
%         electrode_diff = diff(sample(:,j+1));
%         diff_var(i,j+2) = std(electrode_diff);
%         mobility(i,j+2) = diff_var(i,j+2)/electrode_var(i,j+1);
%         diff_mobility(i,j+2) = diff(mobility(i, j+2);
%         formfactor (i,j+2) = diff_mobility(i,j+2)/(mobility(i,j+2));
%    
        [sample, freq(:,j+1)] = electrodeplot(j, structarray, sample);
%         electrode_mean(i,j+1) = mean(sample(:,j+2))
%         electrode_std(i,j+1) = std(sample(:,j+2))
%         da = [1, -1] %denom
%         db = [1, -0.995] %numerator
%         %filtered 
%         derivativeeeg = filter(da, db, sample(:,j+1));
%         variance_of_der(i,j+1) = std(derivativeeeg);
%         mobility(i,j+1) = variance_of_der(i,j+1)/electrode_std(i,j+1);
% %         derivative_mobility(i,j+1) = filter(da,db, mobility(i,j+1));
%         deriv_dersig = filter(da, db, derivativeeeg);
%         mobility_dersig(i, j+1) = (std(deriv_dersig))/variance_of_der(i, j+1);
%         formfactor (i,j+1) = (mobility_dersig(i,j+1))/(mobility(i,j+1)) 
% %         
%         approxEnt(i,j+1) = approximateEntropy(sample(:, j+1));
%         energy(i, j+1) = 0;
%         entropy(i, j+1) =0;
%         for f=1:256
%             energy(i, j+1) =  energy(i, j+1)+ (sample(f, j+2)^2);
%             entropy(i, j+1) = entropy(i, j+1) + ((sample(f, j+2).^2) * log((sample(f, j+2).^2)));
%         end
    end
    
    features = zeros(64,1);
    
    [deltawave, features(1:64, 1:3)] = extractwave(1, 4, sample, "Delta", i);
    [thetawave, features(1:64, 4:6)] = extractwave(4, 7, sample, "Theta", i);
    [alphawave, features(1:64, 7:9)] = extractwave(8, 12, sample, "Alpha", i);
    [betawave, features(1:64, 10:12)] = extractwave(12, 30, sample, "Beta", i);
    [gammawave, features(1:64, 13:15)] = extractwave(30, 100, sample, "Gamma", i);
    
    M{i} = features;
end

%%

figure;
for i=1:10
    alcohalic = cell2mat(M(i));
    control = cell2mat(M(i+10));
    figure;
    hold on
    scatter(alcohalic(:,2),alcohalic(:,3),'+g')
    scatter(control(:,2),control(:,3),'.r')
    xlabel('Form Factor')
    ylabel('Entropy')
    legend('Alcohalics','Control')
    title('Data for classification')
    hold off
            
end
    
    
    
    