%% FIT DATA
%  Fit spheroid data to mathematical model.

% Load models
addpath("models");

% Choose a model
modelname = 'logistic';  
model = eval(sprintf('@(p,t) %s(p,t)',modelname));

% Load and plot data
data = readtable('data_WM983b_5000.csv');

%% PLOT DATA
figure; hold on;
scatter(data.day,data.radius);
xlabel("Time [d]");
ylabel("Radius [um]");

%% FIT MODEL

% Create initial guess based on data
guess(1) = 3 * range(log(data.radius)) / range(data.day);
guess(2) = max(data.radius);
guess(3) = min(data.radius);

% Fit model using nlinfit
[beta,R,J,CovB,MSE] = nlinfit(data.day,data.radius,model,guess);

% Obtain model predictions
tplot = linspace(min(data.day),max(data.day),200);
[rpred,delta] = nlpredci(model,tplot,beta,R,'Covar',CovB);
plot(tplot,rpred,'k','LineWidth',2)
plot(tplot,rpred - delta,'r:','LineWidth',2);
plot(tplot,rpred + delta,'r:','LineWidth',2);

% Save and display results
VarName = ["lambda","K","r0"]';
Estimates = beta';
SE = sqrt(diag(CovB));
CI = nlparci(beta,R,'Jacobian',J);
CI_Lower = CI(:,1);
CI_Upper = CI(:,2);
VarDescription = ["Volumetric growth rate","Limiting radius","Initial radius"]';

results = table(VarName,Estimates,SE,CI_Lower,CI_Upper,VarDescription);
display(results);