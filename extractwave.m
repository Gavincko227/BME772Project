function [Wave, features] = extractwave(f1,f2, sample, titleg,i)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %figure;
    for j=0:63
        bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
        'CutoffFrequency1',f1,'CutoffFrequency2',f2, ...
        'SampleRate',256);
        %fvtool(bpFilt);
        
        [b,a] = tf(bpFilt);
        %.,?freqz(b, a, 255, 256);title("Band Pass Filter");

        

        
        Wave(:,j+1) = filter(b,a, sample(:, j+2));
%         subplot(4,1,j+1);
%         plot(sample(:,1), Wave(:,j+1));xlabel("Samples");title(titleg);
        
        electrode_mean(i,j+1) = mean(Wave(:,j+1))
        electrode_std(i,j+1) = std(Wave(:,j+1))
        da = [1, -1] %denom
        db = [1, -0.995] %numerator
        %filtered 
        derivativeeeg = filter(da, db, Wave(:,j+1));
        variance_of_der(i,j+1) = std(derivativeeeg);
        mobility(i,j+1) = variance_of_der(i,j+1)/electrode_std(i,j+1);
%         derivative_mobility(i,j+1) = filter(da,db, mobility(i,j+1));
        deriv_dersig = filter(da, db, derivativeeeg);
        mobility_dersig(i, j+1) = (std(deriv_dersig))/variance_of_der(i, j+1);
        formfactor (i,j+1) = (mobility_dersig(i,j+1))/(mobility(i,j+1)) 
%         
        approxEnt(i,j+1) = approximateEntropy(Wave(:, j+1));
        energy(i, j+1) = 0;
        entropy(i, j+1) =0;
        for f=1:256
            energy(i, j+1) =  energy(i, j+1)+ (sample(f, j+2)^2);
            entropy(i, j+1) = entropy(i, j+1) + ((sample(f, j+2).^2) * log((sample(f, j+2).^2)));
        end
        
        features(j+1, 1:3) = [electrode_mean(i,j+1) formfactor(i,j+1) entropy(i, j+1)];
    
    end
    
 
    
    
end

