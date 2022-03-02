function yf=bpf_fft(y,ts,f1,f2)
l=length(y);
df=f2/100;
[Y,df1]=fftseq(y,ts,df);
fx=(0:length(Y)-1)*df1-1/(2*ts);
% subplot(221);plot(fx);
bpf=zeros(1,length(fx));
% subplot(222);plot(bpf);
bpf(find((abs(fx)>f1)&(abs(fx)<f2)))=1;
% subplot(223);plot(bpf);
yf=real(ifft(fftshift(fftshift(Y).*bpf)));
yf=yf(1:l);