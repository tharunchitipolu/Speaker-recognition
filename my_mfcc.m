function mfcc_final=my_mfcc(y,fs)

%sound(y)
% figure(1)
% plot(y)

%% PRE EMPHASIS
filcoeff=[1 -0.95];
y1=filter(filcoeff,1,y);



%% FRAME BLOCKING

data=zeros(99,fs*0.02);
Y1=reshape(y1,1,fs);
for i=1:99
    yframe=Y1((fs/100)*i-((fs/100)-1):(fs/100)*i+(fs/100));
    data(i,:)=yframe;
end



%% HAMMING WINDOW
hamming=zeros(1,fs*0.02);
for i=0:fs*0.02-1
    hamming(1,i+1)=0.54-(0.46*cos(2*pi*i/(fs*0.02-1)));
end

new_data=zeros(99,fs*0.02);
for i=1:99
    new_data(i,:)=data(i,:).*hamming;
end


%% FAST FOURIER TRANSFORM
fft_data=zeros(99,fs*0.02);
for i=1:99
    fft_data(i,:)=abs(fft(new_data(i,:)));
end    
fft_freq=(0:(fs*0.02)-1)*(fs/(fs*0.02));



%% MEL FILTER BANK
    
f_low=0;
f_high=fs/2;
filt_num=40;

%computing band in mel-scale
mel_low=1127*log(1+(f_low/700));
mel_high=1127*log(1+(f_high/700));
%creating the mel-scaled vector
Mel = linspace(mel_low,mel_high,filt_num+2);
%computing frequencies of the Mel vector
melc=floor((700*exp(Mel/1127))-700);

%convert frequencies to nearest bins
H=zeros(40,fs*0.02);
freq=linspace(0,fs/2,fs*0.02);
for i=1:40
     for j=1:fs*0.02
         if(freq(1,j)<melc(1,i))
             H(i,j)=0;
         elseif(freq(1,j)<melc(1,i+1)&&freq(1,j)>melc(1,i))
             H(i,j)=2*(freq(1,j)-melc(1,i))/((melc(1,i+2)-melc(1,i))*(melc(1,i+1)-melc(1,i)));
         elseif(freq(1,j)<melc(1,i+2)&&freq(1,j)>melc(1,i+1))
             H(i,j)=2*(freq(1,j)-melc(1,i+2))/((melc(1,i+2)-melc(1,i))*(melc(1,i+1)-melc(1,i+2)));
         elseif(freq(1,j)>melc(1,i+2))
             H(i,j)=0;
         end
     end
end

% If u want to check the mel filter bank plot uncomment the below code part
% fft_freq=(0:(fs*0.02)-1)*(fs/(fs*0.02));
% figure(3)
% hold on 
% for i=1:40
%     plot(fft_freq,H(i,:));
% end
% hold off


mel_final=zeros(99,fs*0.02);
for i=1:99
    for j=1:40
        mel_final(i,:)=mel_final(i,:)+fft_data(i,:).*H(j,:);
    end
end




%% DCT

final=zeros(99,fs*0.02);
for i=1:99
    final(i,:)=dct2(mel_final(i,:));
end
mfcc_final=final(:,1:14);
%comment the below part if u dont want any final mfcc plot
figure(2)
hold on 
for i=1:99
    plot((mfcc_final(i,1:14)));
end
hold off

end
