function yf=lpf_fft(y,ts,f_cut)
l=length(y);
df=f_cut/100;
[Y,df1]=fftseq(y,ts,df);
fx=(0:length(Y)-1)*df1-1/(2*ts);
% N=length(Y);
% ssf=(ceil(-N/2):ceil(N/2)-1)/(ts*N);
% subplot(311);plot(ssf,abs(Y));
lpf=zeros(1,length(fx));
% subplot(312);plot(ssf,fx);
lpf(find(abs(fx)<f_cut))=1;
% subplot(313);plot(lpf);
yf=real(ifft(fftshift(fftshift(Y).*lpf)));
yf=yf(1:l);