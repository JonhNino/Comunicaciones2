%%
clc;
clear all;
close all;

x=[1 1 0 1 0 1 0 0 1 0 1 0 1 1 0 0 0 1 0 1 0 1 0 0 1 0 1 0 1 1];    %Definimos el vector: señal de entrada binaria 
bp=.1;                                                    %este va a ser el ancho que va a trabajar cada bit
disp('Informacion de cadena a transmitir :');   
disp(x)
bit=[];                                         %Variable donde vamos a guardar el tren de pulsos para cada bit
for n=1:1:length(x);                            %Se diseña un ciclo for que recorrer el vector de la señla binaria
    if x(n)==1;                                 %sabiendo cada uno de estos se genera un tren de pulsos del mismo valor
        se=ones(1,100);                         
    else x(n)==0;
        se=zeros(1,100);
    end
    bit=[bit se];                               %se generan 100 pulsos para cada valor 
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'lineWidth',3.5);
grid on;
axis([ 0 bp*length(x) -.2 1.2]);
ylabel('amplitude(volt)');
xlabel('secuencia digital a transmitir');
title('SEÑAL A TRANSMITIR');

%Modulacion Binaria 
A=5;
br=1/bp;
f1=br;
f2=br*4;
t2=bp/99:bp/99:bp;

ss=length(t2);

m=[];

for(i=1:1:length(x));
    
    if (x(i)==1);
        y=A*cos(2*pi*(f1)*t2);
    else 
        y=A*cos(2*pi*(f2)*t2);
    end
    m=[m y];
end

t3=bp/99:bp/99:bp*length(x);
subplot(3,1,2);
plot(t3,m);

ylabel('Amplitud(volt)');
xlabel('Tiempo');
title('Modulacion FSK');

%Demodulacion

mn=[];

for n=ss:ss:length(m);
    t=bp/99:bp/99:bp;
    y1=A*cos(2*pi*(f1)*t2);
    y2=A*cos(2*pi*(f2)*t2);
    mm=y1.*m((n-(ss-1)):n);
    mmm=y2.*m((n-(ss-1)):n);
    t4=bp/99:bp/99:bp;
    z1=trapz(t4,mm);
    z2=trapz(t4,mmm);
    zz1=round(2*z1/bp);
    zz2=round(2*z2/bp);
    if(zz1>A/2);
        a=1;
    else(zz2>A/2);
        a=0;
    end
    mn=[mn a];%señal de modulacion
end

disp('Informacion de Cadena recibida');
disp(mn);
bit1=[];



for c=1:1:length(mn);                            %Se diseña un ciclo for que recorrer el vector de la señla binaria
    if mn(c)==1;                                 %sabiendo cada uno de estos se genera un tren de pulsos del mismo valor
        se=ones(1,100);                         
    else mn(c)==0;
        se=zeros(1,100);
    end
    bit1=[bit];                               %se generan 100 pulsos para cada valor 
end

t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3);
plot(t4,bit1);
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel('RECEPCION de modulacion FSK');