--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN1122.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN1122.m2 | M2 &> K4_allN1122_out.txt
-- For K = 4 are 57 equations but we only consider here 24
-- a's = a1,a2,a3,a4,a5,a6,a7,a8,a9,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33
-- z's = z0,z1,z10,z11


R = QQ[gam,a1,a2,a3,a4,a5,a6,a7,a8,a9,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,z0,z1,z10,z11]
                    
I = ideal(
1-(2/3)*z10*z0*z11-a1,
(1/3)*z10*z0*z11-a2,
(1/3)*z10*z0*z11-a3,
1-(2/3)*z0*z10-a4,
(1/3)*z0*z10-a5,
(1/3)*z0*z10-a6,
1-(2/3)*z11-a7,
(1/3)*z11-a8,
(1/3)*z11-a9,
(1-gam)*(1-(2/3)*z0*z10)+gam*(1-(2/3)*z10)-a19,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a20,
(1-gam)*(1/3)*z0*z10+gam*(1/3)*z10-a21,
(1-gam)*(1-(2/3)*z11)+gam*(1-(2/3)*z0*z11)-a22,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a23,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a24,
(1-gam)*(1-(2/3)*z1*z0*z10)+gam*(1-(2/3)*z10)-a25,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a26,
(1-gam)*(1/3)*z1*z0*z10+gam*(1/3)*z10-a27,
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)*(1-(2/3)*z1*z11)+gam*(1-(2/3)*z11)-a31,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a32,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a33
);

G = eliminate(I,{gam,z0,z1,z10,z11})
dim G 
