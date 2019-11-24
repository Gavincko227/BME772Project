clear sample;
for i=1:2 
    figure;
    file = ['Data', num2str(i), '.csv']
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
    for j = 0:3 
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
        electrode_mean(i,j+1) = mean(sample(:,j+1))
        electrode_std(i,j+1) = std(sample(:,j+1))
        da = [1, -1] %denom
        db = [1, -0.995] %numerator
        %filtered 
        derivativeeeg = filter(da, db, sample(:,j+1));
        variance_of_der(i,j+1) = std(derivativeeeg);
        mobility(i,j+1) = variance_of_der(i,j+1)/electrode_std(i,j+1);
%         derivative_mobility(i,j+1) = filter(da,db, mobility(i,j+1));
        deriv_dersig = filter(da, db, derivativeeeg);
        mobility_dersig(i, j+1) = (std(deriv_dersig))/variance_of_der(i, j+1);
        formfactor (i,j+1) = (mobility_dersig(i,j+1))/(mobility(i,j+1)) 
%         
        approxEnt(i,j+1) = approximateEntropy(sample(:, j+1));
        energy(i, j+1) = 0;
        entropy(i, j+1) =0;
        for f=1:256
            energy(i, j+1) =  energy(i, j+1)+ (sample(f, j+2)^2);
            entropy(i, j+1) = entropy(i, j+1) + ((sample(f, j+2).^2) * log((sample(f, j+2).^2)));
        end
    end
    
    extractwave(1, 4, sample, "Delta");
    extractwave(4, 7, sample, "Theta");
    extractwave(8, 12, sample, "Alpha");
    extractwave(12, 30, sample, "Beta");
    extractwave(30, 100, sample, "Gamma");
end




