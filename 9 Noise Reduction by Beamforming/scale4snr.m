function[a] = scale4snr(s, v_r, SNR)
SNR_l = 10.^(SNR/10);
a = sqrt(sum(s.^2)./(sum(v_r.^2)*SNR_l));
end