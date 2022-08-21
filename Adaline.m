%% Adaline: Stochastic / Mini Badges / Badges
clc; clear all; close all;

alfa = 0.1; %Factor de aprendizaje / learning factor 
G = 500; %Generaciones / Generations
X = [50, 100, 200, 250, 300, 350, 400, 425, 475, 500, 600, 650, 750, 800, 850, 900, 950, 1000]; %Entradas / Inputs
X = X/norm(X); %Datos normalizados / Normalized Data
Y = [0.15, 0.2, 0.225, 0.2, 0.3, 0.375, 0.29, 0.32, 0.4, 0.425, 0.475, 0.45, 0.6, 0.55, 0.75, 0.525, 0.65, 0.675]; %Salidas deseadas / Outputs Desired
L = length(X); 
w = [.01; rand(1)]; %peso inicial aleatorio / random initial weight
wmb = [.01; rand(1)]; % mini badges weights
wb = [.01; rand(1)]; % badges weights
s1 = zeros(1, L); %Salida final de entrenamiento / Training final output
wn = zeros(1,L); %Pesos entrenados / Trained weights

%Estocásticos / Stochastic
for i = 1:G
    for j = 1:L
        X0 = [1, X(j)];
        s1(j) = X0*w;
        e = Y(j)-s1(j);
        w = w+alfa*e.*X0';
        W(:,j) = w;
    end
end

%Mini Lotes / Mini badges
for i = 1:G
    count = 0;
    sum = 0;
    for j=1:length(X)
        s2(j) = [.1, X(j)]*wmb;
        error2 = Y(j) - s2(j);
        sum = sum + (X(j)'*error2);
        if count >= 3
            wmb = wmb+alfa*sum;
            sum = 0; count = 0;
        end
        count = count+1;
    end
end

%Lotes / Badges
for i = 1:G
    sum = 0;
    for j=1:length(X)
        s3(j) = [.1, X(j)]*wb;
        error3 = Y(j) - s3(j);
        sum = sum + (X(j)'*error3);
    end
    wb = wb+alfa*sum;
end

subplot(3,1,1); plot(X,Y,X,s1); title('Estocástico');
subplot(3,1,2); plot(X,Y,X,s2); title('Mini lotes');
subplot(3,1,3); plot(X,Y,X,s3); title('Lotes');
