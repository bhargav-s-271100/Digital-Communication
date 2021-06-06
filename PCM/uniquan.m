function [ q_out , Delta , SQNR] = uniquan( sig_in , L )
sig_pmax=max ( sig_in ) ; 

sig_nmax = min ( sig_in ) ; % finding the negative peak 
Delta= ( sig_pmax- sig_nmax ) /L; % quantization interval
q_level = sig_nmax + Delta/2 : Delta : sig_pmax-Delta / 2 ;
%L_sig = length ( sig_in ) ;
sigp= ( sig_in- sig_nmax ) / Delta + 1/2 ;
qindex = round ( sigp ) ;
qindex = min ( qindex , L ) ;
q_out = q_level ( qindex ) ;
SQNR = 20 * log10( norm(sig_in ) /norm ( sig_in-q_out ));
end