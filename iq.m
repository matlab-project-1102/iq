clear;clc;
fc=10e3;
theta=-pi/3;
fo=2;
fi=1200;
Ai=1;
fq=400;
Aq=0.5;
Tspan=0.01;
fs=10*fc;
Ts=1/fs;
Tx=0:Ts:Tspan;
f_cut=4500;
Df=0.5;

% Tx signal
Si=Ai*sin(2*pi*fi*Tx);
Sq=Aq*sin(2*pi*fq*Tx);
ca_cos_tx=cos(2*pi*fc*Tx);
ca_sin_tx=sin(2*pi*fc*Tx);

S=Si.*ca_cos_tx-Sq.*ca_sin_tx;
[Sf,Df2]=fftseq(S,Ts,Df);
Sf=fftshift(Sf);
fx=(0:length(Sf)-1)*Df2-fs/2;


% Rx signal with CFO and CPO
% ca_cos_rx_fp=2*cos(2*pi*(fc+fo)*Tx+theta);
% ca_sin_rx_fp=2*sin(2*pi*(fc+fo)*Tx+theta);
% Xip_fp=S.*ca_cos_rx_fp;
% Xqp_fp=-S.*ca_sin_rx_fp;
% Xi_fp=lpf_fft(Xip_fp,Ts,f_cut);
% Xq_fp=lpf_fft(Xqp_fp,Ts,f_cut);
% 
% % Rx signal with CFO
% ca_cos_rx_f=2*cos(2*pi*(fc+fo)*Tx);
% ca_sin_rx_f=2*sin(2*pi*(fc+fo)*Tx);
% Xip_f=S.*ca_cos_rx_f;
% Xqp_f=-S.*ca_sin_rx_f;
% Xi_f=lpf_fft(Xip_f,Ts,f_cut);
% Xq_f=lpf_fft(Xqp_f,Ts,f_cut);

% Rx signal with CPO
ca_cos_rx_p=2*cos(2*pi*fc*Tx+theta);
ca_sin_rx_p=2*sin(2*pi*fc*Tx+theta);
Xip_p=S.*ca_cos_rx_p;
Xqp_p=-S.*ca_sin_rx_p;
Xi_p=lpf_fft(Xip_p,Ts,f_cut);
Xq_p=lpf_fft(Xqp_p,Ts,f_cut);

% r_i=Xip_p.*ca_cos_rx_p;
% rp_i=bpf_fft(r_i,Ts,f_cut);
% plot(Ts,rp_i);
% mu=.003;                                % algorithm stepsize
% po=zeros(1,length(Tx)); po(1)=0;         % 初始theta值
% z=zeros(1,100+1);
% 
% for k=1:length(Tx)-1                     % run algorithm
%     z=[z(2:100+1), Xip_p(k)*sin(4*pi*fc*Tx(k)+2*po(k))];
%     ek=lpf_fft(z,Ts,f_cut);
%     theta(k+1)=theta(k)-mu*ek;
% end


% 
Xc=exp(1i*theta).*(Si+1i*Sq);
Xi_c=real(Xc);
Xq_c=-imag(Xc);


% plotting
% figure(1);clf;
% subplot(211);plot(Tx,S);
% title(['The Tx I/Q modulated signal with f_c=' num2str(fc)]);
% subplot(212);plot(fx,abs(Sf));
% title('Spectrum of Tx signal');
% 
% figure(2);clf;
% subplot(421);plot(Tx,Si);
% title('S_i');
% subplot(422);plot(Tx,Sq);
% title('S_q');
% subplot(423);plot(Tx,Xi_fp);
% title('X_i with CFO and CPO');
% subplot(424);plot(Tx,Xq_fp);
% title('X_q with CFO and CPO');
% subplot(425);plot(Tx,Xi_f);
% title('X_i with CFO');
% subplot(426);plot(Tx,Xq_f);
% title('X_q with CFO');
% subplot(427);plot(Tx,Xi_p);
% title('X_i with CPO');
% subplot(428);plot(Tx,Xq_p);
% title('X_q with CPO');
% 
% figure(3);clf;
% subplot(311);plot(Si,Sq);
% Rm=max(abs(Xc))+0.5;
% axis([-Rm Rm -Rm Rm]);axis('square');
% hold on;
% plot(Xi_fp,Xq_fp,'r');
% title(['Tx versus RxI/Qplots, wuth CPO theta = ' num2str(theta*180/pi) ' degrees and CFO fo = 2hz']);
% grid;
% subplot(312);plot(Si,Sq);
% Rm=max(abs(Xc))+0.5;
% axis([-Rm Rm -Rm Rm]);axis('square');
% hold on;
% plot(Xi_f,Xq_f,'r');
% title(['Tx versus RxI/Qplots, with CFO fo = 2hz']);
% grid;
% subplot(313);plot(Si,Sq);
% Rm=max(abs(Xc))+0.5;
% axis([-Rm Rm -Rm Rm]);axis('square');
% hold on;
% plot(Xi_p,Xq_p,'r');
% title(['Tx versus RxI/Qplots, rotation by theta = ' num2str(theta*180/pi) ' degrees']);
% grid;
