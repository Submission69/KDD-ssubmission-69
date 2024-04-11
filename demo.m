clear all;
addpath([pwd, '/funs']);
addpath([pwd, '/datasets']);

%% load data
dataname='MSRC';
load(strcat(dataname,'.mat'));

nv = length(X);
nc = length(unique(Y));

%% Data pre-processing A
disp('------Data preprocessing------');
tic
for v = 1:nv
    a = max(X{v}(:));
    X{v} = double(X{v}./a);
end
toc


%% setting
% anchor_rate = 0.1:0.1:1;
% p = 0.1:0.1:1;
% lambda1= [1e0,10,50,100,500,1000,5000,10000];
% lambda2 = [1e0,10,50,100,500,1000,5000,10000];
anchor_rate = 0.5;
p = 0.6;
lambda1= 10;
lambda2 = 10;



%% main
IterMax = 150;
filename=['result-' dataname '.txt'];
fid = fopen(filename,'a');
for num1 = 1:length(anchor_rate)
    for num2 = 1:length(p)
        for num3 = 1:length(lambda1)
           for num4 = 1: length(lambda2)
                   [final_result,label] = main(X,Y,nv,nc,anchor_rate(num1),p(num2),lambda1(num3),lambda2(num4),IterMax);
                   for n_result = 1:length(final_result)
                        fprintf(fid, '%f ' ,final_result(n_result));
                        fprintf('%f ' ,final_result(n_result));
                   end
                   fprintf('\n');
                   fprintf('anchor_rate=%f_p=%f_lambda1=%f_lambda2=%f\n', anchor_rate(num1),p(num2),lambda1(num3),lambda2(num4));
                   fprintf(fid, 'anchor_rate=%f_p=%f_lambda1=%f_lambda2=%f\n', anchor_rate(num1),p(num2),lambda1(num3),lambda2(num4));
           end
        end 
    end
end

