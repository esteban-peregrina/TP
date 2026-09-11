clear all;

%% Parametres
 K = [300 ; 100 ; 50] % K0, k1, k2 en N/m
 B = [30  ; 40  ; 8 ] % b0, b1, b2 en Ns/m
 M = [1   ; 1   ; 4 ] % m1, m2, m3 en kg

 %% transfer functions
 F1 = [K(1)+K(2); B(0)+B(1); M(0)]
 F2 = -[K(1)];
 .