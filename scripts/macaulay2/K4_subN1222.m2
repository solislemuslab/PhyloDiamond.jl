--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_subN1222.m2
-- K = 4
-- How many equations: _sub
-- Date of creation: Thu May 14 10:46:34 2020
-- To run in console: cat K4_subN1222.m2 | M2 &> K4_subN1222_out.txt
-- For K = 4 are 57 equations but we only consider here 14
-- a's = a2,a5,a8,a11,a14,a17,a20,a23,a26,a29,a30,a32,a35,a38
-- z's = z0,z1,z10,z11,z12


R = QQ[gam,a2,a5,a8,a11,a14,a17,a20,a23,a26,a29,a30,a32,a35,a38,z0,z1,z10,z11,z12]
                    
I = ideal(
(1/3)*z10*z0*z11-a2,
(1/3)*z0*z10-a5,
(1/3)*z11-a8,
(1/3)*z10*z0*z1*z12-a11,
(1/3)*z1*z12-a14,
(1/3)*z11*z1*z12-a17,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a20,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a23,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a26,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a32,
(1-gam)*(1/3)*z12+gam*(1/3)*z0*z1*z12-a35,
(1-gam)*(1/3)*z12+gam*(1/3)*z1*z12-a38
);

G = eliminate(I,{gam,z0,z1,z10,z11,z12})
dim G 
