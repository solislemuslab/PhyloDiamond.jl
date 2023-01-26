--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN1121.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN1121.m2 | M2 &> K4_allN1121_out.txt
-- For K = 4 are 57 equations but we only consider here 12
-- a's = a4,a5,a6,a19,a20,a21,a25,a26,a27,a28,a29,a30
-- z's = z0,z1,z10


R = QQ[gam,a4,a5,a6,a19,a20,a21,a25,a26,a27,a28,a29,a30,z0,z1,z10]
                    
I = ideal(
1-(2/3)*z0*z10-a4,
(1/3)*z0*z10-a5,
(1/3)*z0*z10-a6,
(1-gam)*(1-(2/3)*z0*z10)+gam*(1-(2/3)*z10)-a19,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a20,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a21,
(1-gam)*(1-(2/3)*z1*z0*z10)+gam*(1-(2/3)*z10)-a25,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a26,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a27,
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30
);

G = eliminate(I,{gam,z0,z1,z10})
dim G 
