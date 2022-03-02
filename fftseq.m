function [M,df]=fftseq(m,ts,df)
fs=1/ts;
if nargin==2
    n1=0;
else
    n1=fs/df;
end
n2=length(m);
n=2^(max(nextpow2(n1),nextpow2(n2)));
M=fft(m,n);
df=fs/n;