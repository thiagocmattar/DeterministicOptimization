%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autores:
%   Jaime A. Ramírez
%   Lucas S. Batista
%
% Atualização: 16/04/2013
%
% Nota:
%   Aproxima o ponto de ótimo (minimização) de um problema irrestrito
%   usando o Algoritmo do Gradiente (VERSÃO SIMPLES - MERAMENTE ILUSTRATIVA).
% =========================================================================


function newtonMethod (fun, x, e, xlimites)

%
% Sintaxe
% gradienteMethod(fun, x, e, xlimites)
% fun     : função objetivo
% x       : vetor solução inicial [x1 x2 ... xn]
% e       : precisão adotada pelo usuário
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%
% Exemplo
% newtonMethod(@fobj1, [+3.0 +3.0], 0.01, [0 4 0 4])
% newtonMethod(@fobj2, [-1.0 +1.5], 0.01, [-1.5 1.5 -1.0 1.5])
%


% Contador de iterações do método
k = 0;

% Garante que x seja um vetor coluna
x = x(:);

% Garante que x respeite as restrições de caixa
x = boxConstraints(x, xlimites);

g = gradienteVector(fun, x);  % Estima o grandiente da função no ponto x
h = hessiana(fun,x);          % Estima a hessiana da funçao no ponto x
d = -inv(h)*g;                % Determina a direção de busca

% Estima o valor de 'alpha^*' usando o Algoritmo da Seção Áurea
alpha = unidimensionalOptimization(fun, x, d);

% Armazena o caminho percorrido em direção ao ótimo
caminho(k+1,:) = [x' feval(fun, x)];

% Imprime o resultado da busca encontrado até a iteração k
output(fun, caminho, k, xlimites); 


% Critério de parada: condição necessária de primeira ordem (||g|| = 0)
while (norm(g) >= e)            
    x = x + alpha*d;                 % Determina a nova solução  
    x = boxConstraints(x, xlimites); % Verifica a restrição de caixa
    g = gradienteVector(fun, x);% Calcula o grandiente da função no ponto x
    h = hessiana(fun,x);          % Estima a hessiana da funçao no ponto x
    d = -inv(h)*g;                     % Determina a direção de busca    
    k = k + 1;                  % Atualiza o contador
    
    % Estima um novo valor para 'alpha^*'
    alpha = unidimensionalOptimization(fun, x, d); 
    
    % Armazena o caminho percorrido em direção ao ótimo
    caminho(k+1,:) = [x' feval(fun, x)];
    
    % Atualiza o percusso em direção ao ótimo
    output(fun, caminho, k, xlimites);    
end
fprintf('\n')

figure
plot(0:k,caminho(:,end),'k-','linewidth',2)
xlabel('Número de iterações')
ylabel('Valor da função objectivo')
