function [sample,xsing] = electrodeplot(j,structarray, sample) 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    %sample = [(0:1:255) ; zeros(1,256)]';
    Fs = 256;
    f = Fs*(0:(256/2))/256;
    sum = ((j + 1) * 2) -1;
    sum2 = (j+1) * 2; 
    % sum2 = sum+1;
    for n=1:16384             
        if structarray(n).channel == j                      
            for i=1:1:256
                if structarray(n).sampleNum == i-1
                    sample(i, j+2) = structarray(n).sensorValue;
                end
            end
            subplot(4, 2, sum)
%             figure;
            plot(sample(:,1),sample(:,j+2));
            axis tight
            ylabel (j);
            title ('A');
%             figure;
%             subplot(5,1,sum)
%             plot(fft(sample(:,2)))
            x = abs(fft(sample(:,j+2))/255);
            xsing = x(1:(256/2+1));
            subplot(4,2,sum2);
            plot(f,xsing);
%             x=1;
%             plot(x);
%             axis tight
%             ylabel (j);
%             title ('B')
            
        end    
%         end
%          sample = [(0:1:255) ; zeros(1,256)]'
    end 
end

