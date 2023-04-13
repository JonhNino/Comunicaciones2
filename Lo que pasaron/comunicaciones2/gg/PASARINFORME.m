clc;
clear all;
close all; 
x = input('Ingrese el mensaje codificado binario :');
bp = input('Ingrese el periodo de cada bit:'); 
A = 5;                           % amplitud de las señales
bit=[]; 

for n=1:1:length(x)              %length(X) Devuelve el tamaño de la dimensión más larga de X.
     if x(n)==1;
       se=ones(1,100);           %Crear un arreglo de unos
    else x(n)==0;
        se=zeros(1,100);         %Crear un arreglo de ceros
    end
     bit=[bit se];

end

t1=bp/100:bp/100:100*length(x)*(bp/100);


%%MOSTRAR GRAFICA DEL MENSAJE CODIFICADO EN BINARIO

subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);    
ylabel('Amplitud(V)');
xlabel(' Tiempo(segundos)');
title('Mensaje codificado Binario');



%XXXXXXXXXXXXXXXXXXXXXXX MODULACION  Binary-FSK  XXXXXXXXXXXXXXXXXXXXXXXXXXX%
br=1/bp;                           % br= es la frecuencia de cada bit                      
f1=br*8;                           % f1=la frecuencia para informacion '1' que va ser mayor 0 menor a la frecuencia de cada bit establecida
f2=br*2;                           % f2=la frecuencia para informacion '0'  que va ser mayor o menor a la frecuencia de cada bit establecida
t2=bp/99:bp/99:bp;                 % PARA DECLARA UN VECTOR
ss=length(t2);                     %DEVUELVE EL TAMAO DE LA DIMENSION
m=[];                              %CREAR UNA MATRIZ VACIA
for (i=1:1:length(x))
    if (x(i)==1)
        y=A*cos(2*pi*f1*t2);      %SEÑAL DE PORTADORA DE LA INFORMACION 1
    else
        y=A*cos(2*pi*f2*t2);      %SEÑAL DE PORTADORA DE LA INFORMACION 0
    end
    m=[m y];
end

%%forma de onda de la modulacion FSK
t3=bp/99:bp/99:bp*length(x);
subplot(3,1,2);
plot(t3,m);
ylabel('Amplitud(V)');
xlabel(' Tiempo(segundos)');
title('Forma de onda para modulación FSK');




%XXXXXXXXXXXXXXXXXXXX DEMODULACION BINARIA FSK  XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
mn=[];
for n=ss:ss:length(m)
  t=bp/99:bp/99:bp;
  y1=cos(2*pi*f1*t);                    % carrier siignal for information 1
  y2=cos(2*pi*f2*t);                    % carrier siignal for information 0
  mm=y1.*m((n-(ss-1)):n);
  mmm=y2.*m((n-(ss-1)):n);
  t4=bp/99:bp/99:bp;
  z1=trapz(t4,mm)                                             % intregation 
  z2=trapz(t4,mmm)                                            % intregation 
  zz1=round(2*z1/bp)
  zz2= round(2*z2/bp)                 %Redondear al decimal o entero más cercano
  if(zz1>A/2)      % logic lavel= (0+A)/2 or (A+0)/2 or 2.5 ( in this case)
    a=1;
  else(zz2>A/2)
    a=0;
  end
  mn=[mn a];
end
disp(' Binary information at Reciver :');
disp(mn);


%%----------------------------------------------------------%%
bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=ones(1,100);
    else mn(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];

end
t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3)
plot(t4,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('amplitud(V)');
xlabel(' tiempo(segundos)');
title('Demodulacion de la señal binaria');%recived information as digital signal after binary FSK demodulation


