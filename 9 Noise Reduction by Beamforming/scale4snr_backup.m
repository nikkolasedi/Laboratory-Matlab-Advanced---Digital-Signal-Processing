function [a] = scale4snr(s,vr,snr)

%a = sum(sum((s.*s)'))./((sum(sum((vr.*vr)'))).*10.^(snr./2));
a = sum((s(:,1).*s(:,1)))./(sum((vr(:,1).*vr(:,1))).*10.^(snr./2));
end
