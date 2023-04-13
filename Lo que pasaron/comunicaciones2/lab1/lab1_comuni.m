custMap = [0 2 4 6 8 10 12 14 15 13 11 9 7 5 3 1];
hMod=comm.PSKModulator(16,'BitInput',true,'SymbolMapping','Custom','CustomSymbolMapping',custMap);
hDemod=comm.PSKDemodulator(16,'BitOutput',true,'SymbolMapping','Custom','CustomSymbolMapping',custMap);
constellation(hMod)
hChan = comm.AWGNChannel('BitsPerSymbol',log2(16));
hErr = comm.ErrorRate;
ebnoVec = 6:18; 
ber = zeros(size(ebnoVec));

for k = 1:length(ebnoVec) 
  
    reset(hErr) 
    errVec = [0 0 0]; 
    hChan.EbNo = ebnoVec(k); 
  
    while errVec(2) < 200 && errVec(3) < 1e7 
        data = randi([0 1],4000,1); 
        modData = step(hMod,data); 
        rxSig = step(hChan,modData); 
        rxData = step(hDemod,rxSig); 
        errVec = step(hErr,data,rxData); 
    end 
    ber(k) = errVec(1); 
end 

figure 
semilogy(ebnoVec,[ber]) 
xlabel('Eb/No (dB)') 
ylabel('BER') 
grid 
legend('Simulation','Theory','location','ne')

%%
c=[2 3 1+1i 2+2i 2i 3i -2 -3 -1+1i -2+2i -2i -3i -1-1i -2-2i 1-1i 2-2i];
M=length(c);
data = randi([0 M-1],2000,1);
modData = genqammod(data,c);
rxSig = awgn(modData,50,'measured')

h = scatterplot(rxSig); 
hold on 
scatterplot(c,[],[],'r*',h) 
grid

z = genqamdemod(rxSig,c)
[numErrors,ser] = symerr(data,z)


%%
c=[];
M=length(c);
data = randi([0 M-1],2000,1);
modData = genqammod(data,c);
rxSig = awgn(modData,50,'measured')

ebnoVec = 6:18; 
ber = zeros(size(ebnoVec));

 
h = scatterplot(rxSig); 
hold on 
scatterplot(c,[],[],'r*',h) 
grid

z = genqamdemod(rxSig,c)
[numErrors,ser] = symerr(data,z)

%%

