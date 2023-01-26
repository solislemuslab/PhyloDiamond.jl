--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN1212.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN1212.m2 | M2 &> K4_allN1212_out.txt
-- For K = 4 are 57 equations but we only consider here 24
-- a's = a7,a8,a9,a13,a14,a15,a16,a17,a18,a22,a23,a24,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39
-- z's = z0,z1,z11,z12


R = QQ[gam,a7,a8,a9,a13,a14,a15,a16,a17,a18,a22,a23,a24,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,z0,z1,z11,z12]
                    
I = ideal(
1-(2/3)*z11-a7,
(1/3)*z11-a8,
(1/3)*z11-a9,
1-(2/3)*z1*z12-a13,
(1/3)*z1*z12-a14,
(1/3)*z1*z12-a15,
1-(2/3)*z11*z1*z12-a16,
(1/3)*z11*z1*z12-a17,
(1/3)*z11*z1*z12-a18,
(1-gam)*(1-(2/3)*z11)+gam*(1-(2/3)*z0*z11)-a22,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a23,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a24,
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)*(1-(2/3)*z1*z11)+gam*(1-(2/3)*z11)-a31,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a32,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a33,
(1-gam)*(1-(2/3)*z12)+gam*(1-(2/3)*z0*z1*z12)-a34,
(1-gam)*(1/3)*z12+gam*(1/3)*z0*z1*z12-a35,
(1-gam)*(1/3)*z12+gam*(1/3)*z0*z1*z12-a36,
(1-gam)*(1-(2/3)*z12)+gam*(1-(2/3)*z1*z12)-a37,
(1-gam)*(1/3)*z12+gam*(1/3)*z1*z12-a38,
(1-gam)*(1/3)*z12+gam*(1/3)*z1*z12-a39
);

G = eliminate(I,{gam,z0,z1,z11,z12})
dim G 
