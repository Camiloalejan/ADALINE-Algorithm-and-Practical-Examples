clc; clear; close; 

% a = arduino('COM3','Uno'); configurePin(a,'A0'); configurePin(a,'A5'); %Configuración del pin de Arduino
eta = .01; m = 10000; n = 6;%Valor de aprendizaje, iteraciones, pruebas.
v1 = zeros(1,n); v2 = zeros(1,n); dv = zeros(1,n); % Primer y segundo voltaje con diferentes muestras y la diferencia de ambos
w = rand(2,1); % Pesos iniciales

% Inicialización de voltajes de muestra
% for i = 1:n
%     for j = 1:100
%         I(j) = readVoltage(a, 'A0');
%         J(j) = readVoltage(a, 'A5');
%     end
%     v1(i) = mean(I) % Promedio de 100 muestras
%     v2(i) = mean(J)
%     dv(i) = v1(i)-v2(i)
%     pause()
% end

% Valores previamente medidos
v1 = [4.9723 4.9621 4.9701 4.9727 4.9902 4.9946];
v2 = [0.6025 1.2263 1.4572 2.1365 2.7817 3.4740];
dv = [4.3698 3.7358 3.5130 2.8362 2.2085 1.5206];

d = [0.04 0.035, 0.033, 0.025, 0.02, 0.014];

%Rutina ADALINE
for j=1:m
    for i = 1:n
        est = [1, dv(i)];
        y = est*w;
        e = d(i)-y;
        w = w + eta*est'*e;
     end
end

w=[-5.961855040107100e-04, 0.009379263009409]; % Pesos finales del entrenamiento
xp = linspace(0,5,1000);
yp = (w(2)*xp)+w(1); % Regresión lineal
hold on
plot(dv,d,'b*','lineWidth',1) % Puntos de las muestras (Voltaje, contra Amperaje)
plot(xp,yp,'g') % Mapeo de la regresión
xlabel('voltaje')
ylabel('Amperaje')

