--------------------------------------------------------
-- Parameters identifiability for the general network --
--------------------------------------------------------
-- file name = K4_allN2111.m2
-- K = 4
-- How many equations: _all
-- Date of creation: Tue May 19 12:02:28 2020
-- To run in console: cat K4_allN2111.m2 | M2 &> K4_allN2111_out.txt
-- For K = 4 are 57 equations but we only consider here 12
-- a's = a28,a29,a30,a43,a44,a45,a49,a50,a51,a52,a53,a54
-- z's = z0,z1,z2,z3,z13


R = QQ[gam,a28,a29,a30,a43,a44,a45,a49,a50,a51,a52,a53,a54,z0,z1,z2,z3,z13]
                    
I = ideal(
(1-gam)*(1-(2/3)*z1)+gam*(1/3)*z0-a28,
(1-gam)*(1/3)*z1+gam*(1-(2/3)*z0)-a29,
(1-gam)*(1/3)*z1+gam*(1/3)*z0-a30,
(1-gam)^2*(1-(2/3)*z13*z1*z2)+2*gam*(1-gam)*(1-z13+(1/3)*z13*z0)+gam^2*(1-(2/3)*z13*z3)-a43,
(1-gam)^2*(1/3)*z13*z1*z2+gam*(1-gam)*z13*(1-(1/3)*z0)+gam^2*(1/3)*z13*z3-a44,
(1-gam)^2*(1/3)*z13*z1*z2+gam*(1-gam)*z13*(1-(1/3)*z0)+gam^2*(1/3)*z13*z3-a45,
(1-gam)^2*(1-(2/3)*z13*z2)+2*gam*(1-gam)*(1-z13+(1/3)*z13*z0*z1)+gam^2*(1-(2/3)*z13*z3)-a49,
(1-gam)^2*(1/3)*z13*z2+gam*(1-gam)*z13*(1-(1/3)*z0*z1)+gam^2*(1/3)*z13*z3-a50,
(1-gam)^2*(1/3)*z13*z2+gam*(1-gam)*z13*(1-(1/3)*z0*z1)+gam^2*(1/3)*z13*z3-a51,
(1-gam)^2*(1-(2/3)*z13*z2)+2*gam*(1-gam)*(1-z13+(1/3)*z13*z1)+gam^2*(1-(2/3)*z13*z3*z0)-a52,
(1-gam)^2*(1/3)*z13*z2+gam*(1-gam)*z13*(1-(1/3)*z1)+gam^2*(1/3)*z13*z3*z0-a53,
(1-gam)^2*(1/3)*z13*z2+gam*(1-gam)*z13*(1-(1/3)*z1)+gam^2*(1/3)*z13*z3*z0-a54
);

G = eliminate(I,{gam,z0,z1,z2,z3,z13})
dim G 
