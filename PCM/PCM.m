clear;
clf;
td = 0.002;
t = 0:td:1.;
xsig = sin(2*pi*t)-sin(6*pi*t);
Lsig = length(xsig);
Lfft = 2 ^ ceil ( log2 ( Lsig) + 1 ) ;
Xsig = fftshift ( fft (xsig , Lfft ) );
Fmax= 1 / ( 2 * td) ; 
%Faxis = linspace( -Fmax , Fmax , Lfft ) ;
ts = 0.02;
Nfact=ts / td;
[s_out , sq_out , sqh_out1 , Delta , SQNR] =sampandquant ( xsig , 16 , td , ts );
figure (1) ; 
subplot (2,1,1) ; sfig1 = plot(t, xsig , 'k' , t , sqh_out1(1:Lsig ) , ' b ');
set(sfig1,'Linewidth',2);
title ( ' Signal g(t) and its 16 level PCM signal ')
xlabel ( ' time in sec) ' );
[ s_out , sq__out , sqh_out2 , Delta , SQNR] = sampandquant ( xsig, 4,td , ts ) ;
subplot (2,1,2) ; sfig2 = plot (t,xsig , 'k' , t , sqh_out2(1:Lsig) , ' b ' ) ;
set (sfig2 ,'Linewidth' ,2);
title ( ' Signal g(t) and its 4 level PCM signal ')
xlabel ( ' time in sec' );

Lfft=2 ^ ceil ( log2 ( Lsig) +1) ;
Fmax= 1/ ( 2 * td ) ;
Faxis=linspace ( -Fmax , Fmax , Lfft ) ; 
SQHl = fftshift ( fft ( sqh_out1 , Lfft) ); 
SQH2 = fftshift ( fft ( sqh_out2 , Lfft) );
BW=10 ;
H_lpf=zeros (1, Lfft ) ; H_lpf ( Lfft/2-BW : Lfft/2+BW- 1 ) = 1;
Sl_recv = SQHl.*H_lpf ;
s_recv1=real ( ifft ( fftshift( Sl_recv) ));
s_recv1 = s_recv1 (1:Lsig) ; 
S2_recv= SQH2.*H_lpf; 
s_recv2 =real ( ifft ( fftshift ( S2_recv) ) );
s_recv2 = s_recv2 (1:Lsig) ;
figure (2) 
subplot (2,1,1); sfig3 = plot (t,xsig, ' b-' , t , s_recv1 , ' b-. '); 
legend ( ' original ', ' recovered ') 
set ( sfig3 , 'Linewidth' ,2) ; 
title ( ' Signal g(t) and filtered 16- level PCM signal ') 
xlabel ( ' time in sec ' ) ; 
subplot (2,1,2) ; sfig4 = plot (t,xsig , ' b-' , t , s_recv2 (1:Lsig) , ' b-. ' ) ; 
legend ( ' original ', ' recovered ') 
set ( sfig4 , 'Linewidth' ,2) ; 
title ( ' Signal { \ it g } ( { \ it t } ) and filtered 4-level PCM signal ') 
xlabel ( ' t ime ( sec . ) ' ) ; 