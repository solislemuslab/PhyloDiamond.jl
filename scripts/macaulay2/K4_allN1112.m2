--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN1112.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN1112.m2 | M2 &> K4_allN1112_out.txt
-- For K = 4 are 57 equations but we only consider here 12
-- a's = a7,a8,a9,a22,a23,a24,a28,a29,a30,a31,a32,a33
-- z's = z0,z1,z11


R = QQ[gam,a7,a8,a9,a22,a23,a24,a28,a29,a30,a31,a32,a33,z0,z1,z11]
                    
I = ideal(
1-(2/3)*z11-a7,
(1/3)*z11-a8,
(1/3)*z11-a9,
(1-gam)*(1-(2/3)*z11)+gam*(1-(2/3)*z0*z11)-a22,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a23,
(1-gam)*(1/3)*z11+gam*(1/3)*z0*z11-a24,
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)*(1-(2/3)*z1*z11)+gam*(1-(2/3)*z11)-a31,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a32,
(1-gam)*(1/3)*z1*z11+gam*(1/3)*z11-a33
);

G = eliminate(I,{gam,z0,z1,z11})
dim G 
