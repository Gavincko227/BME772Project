clear sample;

M30 = cell(30,1);
for i=21:50;
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
    
    M30{i-20} = features;
end

%%
j=1;
figure;
for i=1:10
    alcohalic = cell2mat(M(i));
    control = cell2mat(M(i+10));
    %figure
    i
    %for j=53:54
        
    for n=2:3:15
        
        scatter(alcohalic(54,n),alcohalic(54,n+1),'+g');hold on
        scatter(control(54,n),control(54,n+1),'.r');
        %X((i*2)-1:(i*2), 1:2) = [alcohalic(54,n) alcohalic(54,n+1)
        X(j,1:2) =  [alcohalic(54,n) alcohalic(54,n+1)];
        Y(j, 1:2) = [control(54,n) control(54,n+1)];
        j = j+1;
    end
    %end 
%   scatter(sample(:,1),alcohalic(:,3), '+g')
%    scatter(saple(:,1),control(:,3), '.r');
    xlabel('Form Factor')
    ylabel('Entropy')
    %legend('Alcohalics','Control')
    title('Data for classification')
    %hold off
    
    

 hold on;  
end
%%



% opts = statset('Display','final');
% [idx,C] = kmeans(X,2);
% % ,'Distance','cityblock',...
% %     'Replicates',5,'Options',opts)
% 
% 
% figure;
% 
% plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
% 
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% % legend('Cluster 1','Cluster 2','Centroids',...
% %        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off
% 
% 
% electrodeC2A(i, 1:2) = [alcohalic(54,2) alcohalic(54,3);...
%     alcohalic(54,5) alcohalic(54,6); alcohalic(54,8) alcohalic(54,9);...
%     alcohalic(54,11) alcohalic(54,12); alcohalic(54,14) alcohalic(54,15)]
% electrodeC2C(i, 1:10) = [control(54,2) control(54,3)...
%     control(54,5) control(54,6) control(54,8) control(54,9)...
%     control(54,11) control(54,12) control(54,14) control(54,15)]


%classify(i, :) = [alcohalic(54,2) alcohalic(54,3) control(54,2) control(54,3)];



% %%
%  Mdl = fitrsvm(electrodeC2A(:,2), electrodeC2C(:,2), 'Standardize',true);
%  MdlLin = fitrsvm(electrodeC2A(:,2), electrodeC2C(:,2) ,'Standardize',true,'KFold',5)
%  Mdl.ConvergenceInfo.Converged
%  MdlLin.Trained
%  
%  mseLin = kfoldLoss(MdlLin)
%  classify = table(classify);
% [label,score] = predict(MdlLin, classify(1,:))
 %%
 
% X = [electrodeC2A; electrodeC2C]
% 
% opts = statset('Display','final');
[idx,Cx] = kmeans(X(1:40, 1:2),1);
[idy,Cy] = kmeans(Y(1:40, 1:2),1);
% ,'Distance','cityblock',...
%     'Replicates',5,'Options',opts)



% figure;
% plot(X(:,1),X(:,2),'+g');hold on;
% plot(Y(:,1),Y(:,2), '.r');
figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(Y(idy==1,1),Y(idy==1,2),'b.','MarkerSize',12)
plot(Cx(:,1), Cx(:,2), 'kx',...
     'MarkerSize',15,'LineWidth',3);hold on;plot(Cy(:,1), Cy(:,2), 'kx', ...
     'MarkerSize',15,'LineWidth',3);hold on;
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off


N = [X ; Y]
N = array2table(N);
%Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1)
for i=1:10
    N(i,3) = table("Alcohalic");
    N(i+10,3) = table("Control");
    
end    

knearest = fitcknn(N, 'Var3','NumNeighbors',5,'Standardize',1);

%%
CVKNNMdl = crossval(knearest);
classError = kfoldLoss(CVKNNMdl);

C = [Cx ; Cy];

newdata = [X(41:50, 1:2) ; Y(41:50, 1:2)];
[a, b] = knnsearch(C, newdata)  %find the closest in C that new data is closest to.



    