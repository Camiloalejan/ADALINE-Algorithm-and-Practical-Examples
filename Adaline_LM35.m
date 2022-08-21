clc; clear; close; 

% a = arduino('COM3','Uno'); configurePin(a,'A0'); 
eta = 0.01; n = 3000; p = 10; m = 1; k = p+1; u = 0.1;
x = zeros(1,n); xn = zeros(1,n); 
w = zeros(k,1); 
w(1) = u;
% 
% for i = 1:p
%     x(i) = readVoltage(a,'A0');
% end

count = 1;
while k < n
    for i = 1:m
        est = [1, x(count:1:k-1)];
        y = est*w;
        x(k) = readVoltage(a,'A0');
        e = x(k)-y;
        w = w + eta*est'*e;
    end
    xn(k) = y;
    k = k+1;
    count = count+1;
    plot(1:k-1, x(1:k-1)*100, 1:k-1, xn(1:k-1)*100, 'linewidth',1)
    ylabel('Temperatura en Grados Célsius')
    xlabel('Muestras')
    legend('Señal','Filtro')
    pause(0.0001)
end
% 
% plot(1:k, x(1:k)*100, 1:k, xn(1:k)*100)
% ylabel('Temperatura en Grados Célsius')
% xlabel('Muestras') 
% legend('Señal','Filtro')