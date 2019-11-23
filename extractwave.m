function [outputArg1,outputArg2] = extractwave(f1,f2, sample, titleg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    figure;
    for n=2:5
        bpFilt = designfilt('bandpassfir','FilterOrder',20, ...
        'CutoffFrequency1',f1,'CutoffFrequency2',f2, ...
        'SampleRate',256);
        %fvtool(bpFilt);

        [b,a] = tf(bpFilt);
        %.,?freqz(b, a, 255, 256);title("Band Pass Filter");

        Wave = filter(b,a, sample(:, n));
        subplot(4,1,n-1);
        plot(sample(:,1), Wave);xlabel("Samples");title(titleg);
    end
    
end

