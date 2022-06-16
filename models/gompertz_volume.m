%% LOGISTIC_MODEL
%  Solve logistic model in the spheroid radius.
function r = gompertz_volume(p,t)
    lambda = p(1); K = p(2); r0 = p(3);
    v0 = 4*pi / 3 * r0^3;
    vK = 4*pi / 3 * K^3;
    v = vK * exp(log(v0 / vK) * exp(-lambda * t));
    r = (3 / (4 * pi) * v).^(1/3);
end