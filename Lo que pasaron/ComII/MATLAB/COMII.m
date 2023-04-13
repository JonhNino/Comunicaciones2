
A=[0.2 0.4 0.1 0.3;0.1 0.2 0.6 0.1;0.2 0.1 0.4 0.3;0.3 0.1 0.2 0.4]
B=A^70

A=[0.8 0.2 0 0 0 0 0 0 ; 0 0 0.3 0.7 0 0 0 0 ; 0 0 0 0 0.6 0.4 0 0 ; 0 0 0 0 0 0 0.1 0.9 ; 0.7 0.3 0 0 0 0 0 0 ; 0 0 0.9 0.1 0 0 0 0 ; 0 0 0 0 0.8 0.2 0 0 ; 0 0 0 0 0 0 0.6 0.4]


%%

pskModulator = comm.PSKModulator;
modData = pskModulator(randi([0 7],2000,1));
channel = comm.AWGNChannel('EbNo',20,'BitsPerSymbol',3);
channelOutput = channel(modData);
scatterplot(modData)

scatterplot(channelOutput)

channel.EbNo = 10;
channelOutput = channel(modData);
scatterplot(channelOutput)

%%

EbNo = (0:50)';
M = 16; % De orden de modulación

berQ = berawgn (EbNo, 'psk' , M, 'nondiff' );

berD = berawgn (EbNo, 'dpsk' , M);
berF = berawgn (EbNo, 'fsk' , M, 'coherente' );

semilogy (EbNo, [berQ berD berF])
xlabel ( 'Eb / No (dB)' )
ylabel ( 'BER' )
legend ( 'QPSK' , 'DPSK' , 'FSK' )
title ( 'Tasa teorica de errores de bits' )
grid


%berTheory = berawgn(ebnoVec,'psk',16,'nondiff');
%berTheory = berawgn(ebnoVec,'psk',16,'nondiff');










