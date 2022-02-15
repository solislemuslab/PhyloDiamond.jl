--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN1221.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN1221.m2 | M2 &> K4_allN1221_out.txt
-- For K = 4 are 57 equations but we only consider here 24
-- a's = a4,a5,a6,a10,a11,a12,a13,a14,a15,a19,a20,a21,a25,a26,a27,a28,a29,a30,a34,a35,a36,a37,a38,a39
-- z's = z0,z1,z10,z12


R = QQ[gam,a4,a5,a6,a10,a11,a12,a13,a14,a15,a19,a20,a21,a25,a26,a27,a28,a29,a30,a34,a35,a36,a37,a38,a39,z0,z1,z10,z12]
                    
I = ideal(
1-(2/3)*z0*z10-a4,
(1/3)*z0*z10-a5,
(1/3)*z0*z10-a6,
1-(2/3)*z10*z0*z1*z12-a10,
(1/3)*z10*z0*z1*z12-a11,
(1/3)*z10*z0*z1*z12-a12,
1-(2/3)*z1*z12-a13,
(1/3)*z1*z12-a14,
(1/3)*z1*z12-a15,
(1-gam)*(1-(2/3)*z0*z10)+gam*(1-(2/3)*z10)-a19,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a20,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a21,
(1-gam)*(1-(2/3)*z1*z0*z10)+gam*(1-(2/3)*z10)-a25,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a26,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a27,
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)*(1-(2/3)*z12)+gam*(1-(2/3)*z0*z1*z12)-a34,
(1-gam)*(1/3)*z12+gam*(1/3)*z0*z1*z12-a35,
(1-gam)*(1/3)*z12+gam*(1/3)*z0*z1*z12-a36,
(1-gam)*(1-(2/3)*z12)+gam*(1-(2/3)*z1*z12)-a37,
(1-gam)*(1/3)*z12+gam*(1/3)*z1*z12-a38,
(1-gam)*(1/3)*z12+gam*(1/3)*z1*z12-a39
);

G = eliminate(I,{gam,z0,z1,z10,z12})
dim G 
