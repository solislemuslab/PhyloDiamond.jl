function main()
    latex1112 = macaulay_latex("a32 - a33, a31 + 2a33 - 1, a28 + a29 + a30 - 1, a23 - a24, a22 + 2a24 - 1, a8 - a9, a7 + 2a9 - 1, 3a9*a30 + a9 - a24 - a33, a24*a29 + 2a24*a30 + a29*a33 - a30*a33 - a33, 3a9*a29 - 2a9 + 2a24 - a33", false)
    latex1121 = macaulay_latex("a28 + a29 + a30 - 1, a26 - a27, a25 + 2a27 - 1, a20 - a21, a19 + 2a21 - 1, a5 - a6, a4 + 2a6 - 1, a6*a29 + 2a6*a30 - a6 + a21 - a27", false)
    latex1122 = macaulay_latex("a32 - a33, a31 + 2a33 - 1, a28 + a29 + a30 - 1, a26 - a27, a25 + 2a27 - 1, a23 - a24, a22 + 2a24 - 1, a20 - a21, a19 + 2a21 - 1, a8 - a9, a7 + 2a9 - 1, a5 - a6, a4 + 2a6 - 1, a2 - a3, a1 + 2a3 - 1, 3a9*a30 + a9 - a24 - a33, a24*a29 + 2a24*a30 + a29*a33 - a30*a33 - a33, 3a9*a29 - 2a9 + 2a24 - a33, a6*a29 + 2a6*a30 - a6 + a21 - a27, a3*a29 + 2a3*a30 - 3a6*a33, 3a6*a24 - 3a3*a30 + 3a6*a33 - a3, 3a9*a21 - 3a9*a27 + 3a6*a33 - a3, 3a6*a9 - a3", false)
    latex1211 = macaulay_latex("a38 - a39, a37 + 2a39 - 1, a35 - a36, a34 + 2a36 - 1, a28 + a29 + a30 - 1, a14 - a15, a13 + 2a15 - 1, a15*a29 - a15*a30 + a36 - a39", false)
    latex1212 = macaulay_latex("a38 - a39, a37 + 2a39 - 1, a35 - a36, a34 + 2a36 - 1, a32 - a33, a31 + 2a33 - 1, a28 + a29 + a30 - 1, a23 - a24, a22 + 2a24 - 1, a17 - a18, a16 + 2a18 - 1, a14 - a15, a13 + 2a15 - 1, a8 - a9, a7 + 2a9 - 1, a18*a30 - a15*a33 - a9*a36 + a9*a39, 3a9*a30 + a9 - a24 - a33, a24*a29 + 2a24*a30 + a29*a33 - a30*a33 - a33, a18*a29 - a15*a33 + 2a9*a36 - 2a9*a39, a15*a29 - a15*a30 + a36 - a39, 3a9*a29 - 2a9 + 2a24 - a33, 3a15*a24 - 3a9*a36 + 3a9*a39 - a18, 3a9*a15 - a18", false)
    latex1221 = macaulay_latex("a38 - a39, a37 + 2a39 - 1, a35 - a36, a34 + 2a36 - 1, a28 + a29 + a30 - 1, a26 - a27, a25 + 2a27 - 1, a20 - a21, a19 + 2a21 - 1, a14 - a15, a13 + 2a15 - 1, a11 - a12, a10 + 2a12 - 1, a5 - a6, a4 + 2a6 - 1, a15*a29 - a15*a30 + a36 - a39, a12*a29 - a12*a30 + 3a6*a36 - 3a6*a39, a6*a29 + 2a6*a30 - a6 + a21 - a27, 3a15*a21 - 3a15*a27 + 3a12*a30 - 3a6*a36 + 3a6*a39 - a12, 3a6*a15 - a12, a21*a29*a36 + 2a21*a30*a36 - a27*a29*a39 + a27*a30*a39 - a15*a27 + a12*a30 - a6*a36 - a21*a36 - a27*a36 + 2a21*a39", false)
    latex1222 = macaulay_latex("a38 - a39, a37 + 2a39 - 1, a35 - a36, a34 + 2a36 - 1, a32 - a33, a31 + 2a33 - 1, a28 + a29 + a30 - 1, a26 - a27, a25 + 2a27 - 1, a23 - a24, a22 + 2a24 - 1, a20 - a21, a19 + 2a21 - 1, a17 - a18, a16 + 2a18 - 1, a14 - a15, a13 + 2a15 - 1, a11 - a12, a10 + 2a12 - 1, a8 - a9, a7 + 2a9 - 1, a5 - a6, a4 + 2a6 - 1, a2 - a3, a1 + 2a3 - 1, a18*a30 - a15*a33 - a9*a36 + a9*a39, 3a9*a30 + a9 - a24 - a33, a24*a29 + 2a24*a30 + a29*a33 - a30*a33 - a33, a18*a29 - a15*a33 + 2a9*a36 - 2a9*a39, a15*a29 - a15*a30 + a36 - a39, a12*a29 - a12*a30 + 3a6*a36 - 3a6*a39, 3a9*a29 - 2a9 + 2a24 - a33, a6*a29 + 2a6*a30 - a6 + a21 - a27, a3*a29 + 2a3*a30 - 3a6*a33, 3a15*a24 - 3a9*a36 + 3a9*a39 - a18, 3a6*a24 - 3a3*a30 + 3a6*a33 - a3, a18*a21 - a12*a24 - a18*a27 + a12*a33 + a3*a36 - a3*a39, 3a15*a21 - 3a15*a27 + 3a12*a30 - 3a6*a36 + 3a6*a39 - a12, 3a9*a21 - 3a9*a27 + 3a6*a33 - a3, a6*a18 - a12*a24 + a3*a36 - a3*a39, 3a9*a15 - a18, 3a6*a15 - a12, a3*a15 - a12*a24 + a3*a36 - a3*a39, a9*a12 - a12*a24 + a3*a36 - a3*a39, 3a6*a9 - a3, a21*a29*a36 + 2a21*a30*a36 - a27*a29*a39 + a27*a30*a39 - a15*a27 + a12*a30 - a6*a36 - a21*a36 - a27*a36 + 2a21*a39, 6a9*a27*a36 - 3a6*a33*a36 - 3a21*a33*a36 - 3a9*a27*a39 - 3a24*a27*a39 + 6a6*a33*a39 + a18*a27 - a12*a33 + a3*a36 - a3*a39", false)
    latex2111 = macaulay_latex("a53 - a54, a52 + 2a54 - 1, a50 - a51, a49 + 2a51 - 1, a44 - a45, a43 + 2a45 - 1, a28 + a29 + a30 - 1", false)
    latex2112 = macaulay_latex("a53 - a54, a52 + 2a54 - 1, a50 - a51, a49 + 2a51 - 1, a47 - a48, a46 + 2a48 - 1, a44 - a45, a43 + 2a45 - 1, a32 - a33, a31 + 2a33 - 1, a28 + a29 + a30 - 1, a23 - a24, a22 + 2a24 - 1, a8 - a9, a7 + 2a9 - 1, 3a9*a30 + a9 - a24 - a33, a24*a29 + 2a24*a30 + a29*a33 - a30*a33 - a33, 3a9*a29 - 2a9 + 2a24 - a33", false)
    latex2121_sub = macaulay_latex("a5*a29 + 2a5*a30 - a5 + a20 - a26, 2a20*a29 a41 + a26*a29 a41 + 3a20*a29 a30*a41 - 3a20*a29*a30 a41 - 3a26*a29*a30 a41 - 2a20*a30 a41 + 2a26*a30 a41 - 3a20*a26*a29 a44 - 3a26 a29 a44 - 3a20*a26*a29*a30*a44 + 6a26 a29*a30*a44 + 6a20*a26*a30 a44 - 3a26 a30 a44 - 6a20 a29 a50 + 3a20*a26*a29 a50 - 15a20 a29*a30*a50 - 6a20*a26*a29*a30*a50 - 6a20 a30 a50 + 3a20*a26*a30 a50 + 3a20*a26*a29 a53 + 3a20*a26*a29*a30*a53 - 6a20*a26*a30 a53 - 4a20*a29 a41 - 2a26*a29 a41 - a20*a29*a30*a41 + a26*a29*a30*a41 + 5a20*a30 a41 + a26*a30 a41 + 3a20 a29*a44 + 6a20*a26*a29*a44 + 3a26 a29*a44 + 6a20 a30*a44 + 18a5*a26*a30*a44 - 6a20*a26*a30*a44 - 3a26 a30*a44 + 6a20*a26*a29*a50 - 9a5*a20*a30*a50 + 9a20 a30*a50 - 9a5*a26*a30*a50 + 12a20*a26*a30*a50 - 3a20 a29*a53 - 3a26 a29*a53 - 6a20 a30*a53 + 3a26 a30*a53 + 3a26*a29*a41 - 3a26*a30*a41 - 3a5 a44 + 3a5*a20*a44 - 3a5*a26*a44 - 6a26 a44 + 3a5 a50 - 6a5*a20*a50 + 3a20 a50 + 6a5*a26*a50 - 6a20*a26*a50 + 3a5*a20*a53 - 3a20 a53 - 3a5*a26*a53 + 6a20*a26*a53\n                                           3             3              2                      2                  2              3              3                  2          2   2                                 2                          2          2   2          2   2                  2           2                                         2   2                  2                  2                                         2              2              2                                                  2             2          2                                 2              2                                                    2                                                   2                                                    2              2              2              2                                           2                                      2         2                        2                                                     2", true)
    latex2211_sub = macaulay_latex("a14*a29 - a14*a30 + a35 - a38, 3a29 a35*a38*a44 + 3a29*a30*a35*a38*a44 - 6a30 a35*a38*a44 + 3a29 a35*a38*a50 + 12a29*a30*a35*a38*a50 + 12a30 a35*a38*a50 - 6a29 a38 a50 + 3a29*a30*a38 a50 + 3a30 a38 a50 - 3a29 a35 a53 - 12a29*a30*a35 a53 - 12a30 a35 a53 - 3a29 a35*a38*a53 - 3a29*a30*a35*a38*a53 + 6a30 a35*a38*a53 - a29 a35*a56 - 3a29 a30*a35*a56 + 4a30 a35*a56 - 2a29 a38*a56 - 3a29 a30*a38*a56 + 3a29*a30 a38*a56 + 2a30 a38*a56 + 3a29*a35 a44 + 6a30*a35 a44 - 6a29*a35*a38*a44 - 3a30*a35*a38*a44 + 3a29*a38 a44 - 3a30*a38 a44 - 9a14*a30*a35*a50 - 9a14*a30*a38*a50 - 12a29*a35*a38*a50 - 6a30*a35*a38*a50 + 12a29*a38 a50 + 6a30*a38 a50 + 18a14*a30*a35*a53 + 3a29*a35 a53 + 6a30*a35 a53 - 9a30*a35*a38*a53 - 3a29*a38 a53 + 3a30*a38 a53 + a29 a35*a56 + a29*a30*a35*a56 - 2a30 a35*a56 + 2a29 a38*a56 - a29*a30*a38*a56 - a30 a38*a56 - 3a14*a35*a44 - 3a35 a44 + 3a14*a38*a44 + 9a35*a38*a44 - 6a38 a44 + 3a14 a50 + 6a14*a35*a50 - 6a14*a38*a50 + 3a35*a38*a50 - 3a38 a50 - 3a14 a53 - 3a14*a35*a53 - 6a35 a53 + 3a14*a38*a53 + 3a35*a38*a53 + 3a38 a53 - 2a29*a35*a56 - 4a30*a35*a56 + 2a29*a38*a56 + 4a30*a38*a56 + 2a35*a56 - 2a38*a56\n                                   2                                         2                  2                                           2                  2   2                  2          2   2          2   2                   2           2   2          2                                         2                 3              2                  3              3              2                      2              3                  2              2                                                    2              2                                                                                            2              2                                  2              2                                 2              2         2                                2              2                               2                             2                                        2          2                                                       2          2                         2                                        2", true)
    latex2212_sub = macaulay_latex("a17*a30 - a14*a32 - a8*a35 + a8*a38, 3a8*a30 + a8 - a23 - a32, a23*a29 + 2a23*a30 + a29*a32 - a30*a32 - a32, a17*a29 - a14*a32 + 2a8*a35 - 2a8*a38, a14*a29 - a14*a30 + a35 - a38, 3a8*a29 - 2a8 + 2a23 - a32, 3a14*a23 - 3a8*a35 + 3a8*a38 - a17, 3a8*a14 - a17, 3a32*a38*a44 - 2a29*a38*a47 - a30*a38*a47 - 3a32*a38*a50 + 3a32*a35*a53 + 3a8*a38*a53 - 3a23*a38*a53 + a29*a32*a56 - a30*a32*a56 - a17*a44 + a14*a47 - a35*a47 + a38*a47 + a17*a50 - a17*a53 - a8*a56 + a23*a56, 3a8*a35*a44 - 3a32*a35*a44 - 3a8*a38*a44 + a29*a35*a47 + 2a30*a35*a47 + 3a8*a35*a50 - 3a23*a38*a50 + a29*a32*a56 - a30*a32*a56 + a17*a44 - a14*a47 - a35*a47 + a38*a47 - a8*a56 + a23*a56, 3a17*a32*a44  - 6a14*a32*a44*a47 + 3a32*a35*a44*a47 + 3a14*a30*a47  - a29*a35*a47  - 2a30*a35*a47  - 3a8*a17*a44*a50 - 3a17*a32*a44*a50 + 3a14*a32*a47*a50 - 3a8*a35*a47*a50 + 3a23*a38*a47*a50 + 3a8*a17*a50  - 3a17*a23*a44*a53 + 3a8*a35*a47*a53 - 3a8*a38*a47*a53 - 3a17*a23*a50*a53 + 6a8*a32*a44*a56 - a29*a32*a47*a56 + a30*a32*a47*a56 - 3a8 a50*a56 + 3a8*a23*a50*a56 - 3a8*a32*a50*a56 + 3a8 a53*a56 - 3a8*a23*a53*a56 + 3a8*a32*a53*a56 - a35*a47  + a38*a47  + a17*a47*a50 + a17*a47*a53 - 2a32*a47*a56, 9a8*a23*a38*a44*a50 - 9a8*a23*a38*a50  + 9a23*a32*a35*a44*a53 + 9a8*a23*a38*a44*a53 + 3a29*a32*a35*a47*a53 - 3a30*a32*a35*a47*a53 + 9a23 a38*a50*a53 + 9a23*a30*a32*a53*a56 + 3a29*a32 a53*a56 - 3a30*a32 a53*a56 - 3a17*a23*a44  - 3a23*a35*a44*a47 + 6a32*a35*a44*a47 - 3a29*a35*a47  - 3a30*a35*a47  + 3a17*a23*a44*a50 - 9a8*a35*a47*a50 + 3a8*a38*a47*a50 + 3a23*a38*a47*a50 - 3a17*a23*a44*a53 + 3a8*a35*a47*a53 - 3a32*a35*a47*a53 - 3a8*a38*a47*a53 - 3a23*a38*a47*a53 - 6a8*a23*a44*a56 - 3a23*a30*a47*a56 - 3a29*a32*a47*a56 + 3a30*a32*a47*a56 + 6a8*a23*a50*a56 - 3a23 a50*a56 - 3a8*a23*a53*a56 - 3a32 a53*a56 + a14*a47  + 2a35*a47  - a38*a47  - a17*a47*a50 + a17*a47*a53 + 2a8*a47*a56 + a32*a47*a56, 9a23*a32*a35*a44  + 9a23*a30*a35*a44*a47 + a29 a35*a47  + 4a29*a30*a35*a47  - 5a30 a35*a47  - 18a23*a32*a35*a44*a50 - 6a29*a32*a35*a47*a50 + 6a30*a32*a35*a47*a50 + 27a23*a30*a38*a47*a50 + 9a29*a32*a38*a47*a50 - 9a30*a32*a38*a47*a50 + 18a8*a23*a35*a50  - 9a8*a23*a38*a50  - 9a23 a38*a50  - 9a23 a35*a44*a53 + 9a23*a32*a35*a44*a53 + 9a8*a23*a38*a44*a53 + 9a23*a30*a35*a47*a53 + 6a29*a32*a35*a47*a53 - 6a30*a32*a35*a47*a53 - 9a23 a35*a50*a53 + 9a23 a38*a50*a53 + 9a23*a30*a32*a44*a56 + 3a29*a32 a44*a56 - 3a30*a32 a44*a56 + 9a23*a30 a47*a56 + a29 a32*a47*a56 + a29*a30*a32*a47*a56 - 2a30 a32*a47*a56 + 9a23 a30*a50*a56 - 27a23*a30*a32*a50*a56 - 9a29*a32 a50*a56 + 9a30*a32 a50*a56 - 9a23 a30*a53*a56 + 18a23*a30*a32*a53*a56 + 6a29*a32 a53*a56 - 6a30*a32 a53*a56 - 3a17*a23*a44  - 9a23*a35*a44*a47 - 3a32*a35*a44*a47 + 9a23*a38*a44*a47 - 3a29*a35*a47  + 3a29*a38*a47  - 3a30*a38*a47  + 6a17*a23*a44*a50 - 3a8*a35*a47*a50 - 9a23*a35*a47*a50 + 6a32*a35*a47*a50 + 6a8*a38*a47*a50 + 6a23*a38*a47*a50 - 9a32*a38*a47*a50 - 3a17*a23*a44*a53 + 3a8*a35*a47*a53 + 3a23*a35*a47*a53 - 6a32*a35*a47*a53 - 3a8*a38*a47*a53 - 3a23*a38*a47*a53 - 3a8*a23*a44*a56 + 3a23 a44*a56 - 3a32 a44*a56 - 12a23*a30*a47*a56 - 4a29*a32*a47*a56 + a30*a32*a47*a56 - 3a23*a32*a50*a56 + 9a32 a50*a56 - 3a8*a23*a53*a56 + 3a23 a53*a56 + 3a23*a32*a53*a56 - 6a32 a53*a56 + a14*a47  + 4a35*a47  - 4a38*a47  - 2a17*a47*a50 + a17*a47*a53 - a8*a47*a56 + a23*a47*a56 + 4a32*a47*a56, 3a14*a17 a44  - 6a14 a17*a44*a47 + 3a14*a17*a35*a44*a47 + 3a14 a47  - 3a14 a35*a47  - 3a14*a17 a44*a50 - 3a17 a38*a44*a50 + 3a14 a17*a47*a50 + 3a14*a17*a38*a47*a50 + 3a17 a38*a50  - 3a17 a35*a44*a53 + 3a14*a17*a35*a47*a53 - 3a17 a35*a50*a53 + 3a8*a17*a35*a50*a56 - 3a8*a17*a38*a50*a56 - 3a8*a17*a35*a53*a56 + 3a8*a17*a38*a53*a56 + 2a17 a44*a56 - 2a14*a17*a47*a56 + a17*a35*a47*a56 - a17*a38*a47*a56 - a17 a50*a56 + a17 a53*a56, 3a29 a35*a38*a44 + 3a29*a30*a35*a38*a44 - 6a30 a35*a38*a44 + 3a29 a35*a38*a50 + 12a29*a30*a35*a38*a50 + 12a30 a35*a38*a50 - 6a29 a38 a50 + 3a29*a30*a38 a50 + 3a30 a38 a50 - 3a29 a35 a53 - 12a29*a30*a35 a53 - 12a30 a35 a53 - 3a29 a35*a38*a53 - 3a29*a30*a35*a38*a53 + 6a30 a35*a38*a53 - a29 a35*a56 - 3a29 a30*a35*a56 + 4a30 a35*a56 - 2a29 a38*a56 - 3a29 a30*a38*a56 + 3a29*a30 a38*a56 + 2a30 a38*a56 + 3a29*a35 a44 + 6a30*a35 a44 - 6a29*a35*a38*a44 - 3a30*a35*a38*a44 + 3a29*a38 a44 - 3a30*a38 a44 - 9a14*a30*a35*a50 - 9a14*a30*a38*a50 - 12a29*a35*a38*a50 - 6a30*a35*a38*a50 + 12a29*a38 a50 + 6a30*a38 a50 + 18a14*a30*a35*a53 + 3a29*a35 a53 + 6a30*a35 a53 - 9a30*a35*a38*a53 - 3a29*a38 a53 + 3a30*a38 a53 + a29 a35*a56 + a29*a30*a35*a56 - 2a30 a35*a56 + 2a29 a38*a56 - a29*a30*a38*a56 - a30 a38*a56 - 3a14*a35*a44 - 3a35 a44 + 3a14*a38*a44 + 9a35*a38*a44 - 6a38 a44 + 3a14 a50 + 6a14*a35*a50 - 6a14*a38*a50 + 3a35*a38*a50 - 3a38 a50 - 3a14 a53 - 3a14*a35*a53 - 6a35 a53 + 3a14*a38*a53 + 3a35*a38*a53 + 3a38 a53 - 2a29*a35*a56 - 4a30*a35*a56 + 2a29*a38*a56 + 4a30*a38*a56 + 2a35*a56 - 2a38*a56\n                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2                                                     2              2               2                                                                                                           2                                                                                                                                      2                                                 2                                                     2          2                                                                                  2                                                                                                  2                                             2                  2                      2                                                     2               2                                                                                                                                                                                                                                                                           2                                2                 2           2          2                                                                          2                             2       2                   2       2       2                                                                                                                                                               2                  2       2       2       2                                                                                                                                    2                  2                                             2                  2                  2             2                                        2                  2                                              2                  2              2                                              2                  2                      2                                                                        2               2               2                                                                                                                                                                                                                                                                            2              2                                                                                          2                                2                                 2                 2           2           2                                                                                 2   2       2                                         3   2       2       2           2              2                  2                                         2       2       2                                         2                                                                                                          2                                                                    2             2             2                                         2                  2                                           2                  2   2                  2          2   2          2   2                   2           2   2          2                                         2                 3              2                  3              3              2                      2              3                  2              2                                                    2              2                                                                                            2              2                                  2              2                                 2              2         2                                2              2                               2                             2                                        2          2                                                       2          2                         2                                        2", true) 
    println()
    print(latex_julia(latex2212_sub))
end

"""
    input:  a list of invariants separated by comma (eg. "a22 + 2a24 - 1, a8 - a9, a7 + 2a9 - 1")
    output: returns arraylist of strings (eg. ["a22 + 2a24 - 1", "a8 - a9", "a7 + 2a9 - 1"])
"""
function comma_sep(str)
    temp = split(str, ",") #split the string on comma
    ret = [] #storing return value
    for ele in temp #iterate through each element
        if length(ele) > 0 #neglect the empty element
            push!(ret, strip(ele, [' '])) #remove the first tab
        end
    end
    return ret
end

"""
    input:  invariants separated by comma (eg. "a32^2 - a33, a31 + 2a33^2*a45 - 1, a28 + a29 + a30 - 1, a23 - a24, a22 + 2a24 - 1")
    output: string 
    (eg. "\\item \$
    a_{32}^{2} - a_{33}\$
    \\item \$
     a_{31} + 2a_{33}^{2}*a_{45} - 1\$
    \\item \$
     a_{28} + a_{29} + a_{30} - 1\$
    \\item \$
     a_{23} - a_{24}\$
    \\item \$
     a_{22} + 2a_{24} - 1\$")
"""
function latex_add_item(str)
    temp = split(str, ",") #split the string on comma
    ret = [] #storing return value
    for ele in temp #iterate through each element
        if length(ele) > 0 #neglect the empty element
            push!(ret, "\\item \$\n"*ele*"\$\n")
        end
    end
    return join(ret)
end

"""
    input:  str: strings of the macaulay version invariants
                 before the newline is the invariants without exponent,
                 after the newline is the string of exponent, the position is the same in invariants
                 eg. macaulay_latex("a5*a29 + 2a5*a30 - a5 + a20 - a26, 2a20*a29 a41\n                                           3", true)
            exp: true if there is exponent
                  
    output: strings of the latex version invariants
            eg. a_{5}*a_{29} + 2a_{5}*a_{30} - a_{5} + a_{20} - a_{26}, 2a_{20}*a_{29}^{3}*a_{41}
"""
function macaulay_latex(str, exp)
    if exp
        temp = split(str, "\n")
        str = temp[1] #storing invariants
        exp = temp[2] #storing exponents
        j = 0 #store index in str
        for i in 1:length(exp)
            j += 1
            if exp[i] != ' ' && str[j] == ' ' && str[j+1] != 'a'
                str=str[1:j-1]*'^'*exp[i]*str[j+1:end]
                j+=1
            elseif exp[i] != ' ' && str[j] == ' ' && str[j+1] == 'a'
                str=str[1:j-1]*'^'*exp[i]*'*'*str[j+1:end]
                j+=2
            end
            
        end
    end

    temp = split(str, "a") #split the element on "a"
    #iterate through every segment of the element after splitting
    for i in 1:length(temp)
        #if temp[i] is not empty, 
        #add "a_{}" around the index, add "{}" around the exponent
        #eg. "a32^2-a33" --> ["", "32^2-", "33"] --> ["", "a_{32}^{2}-", "a_{33}"]
        if length(temp[i]) > 0
            #iterate though every character of the segment (temp[i][j])
            for j in 1:length(temp[i])
                #if the character is not a number and is the first occurance of non-number
                if !occursin(r"[0-9]", string(temp[i][j])) 
                    #add "}" in between the number and the non-number character
                    temp[i] = temp[i][1:j-1]*"}"*temp[i][j:length(temp[i])]
                    break
                #if the character is number and is the last character of the segment
                elseif occursin(r"[0-9]", string(temp[i][j])) && (j == length(temp[i]))
                    temp[i] = temp[i][1:j]*"}" #add "}" to the end
                end
            end
            for j in 1:length(temp[i]) #handle the exponent
                if occursin(r"[\^]", string(temp[i][j]))
                    if length(temp[i])> j+1
                        temp[i] = temp[i][1:j]*"{"*temp[i][j+1]*"}"*temp[i][j+2:length(temp[i])]
                    else
                        temp[i] = temp[i][1:j]*"{"*temp[i][j+1]*"}"
                    end
                end
            end
            temp[i] = "a_{"*temp[i] #add "a_{" to the front
        end
    end
    return join(temp)
end

"""
    input:  strings of the latex version invariants
        eg. "a_{32}^{2} - a_{33}, a_{31} + 2a_{33}^{2}*a_{45} - 1, a_{28} + a_{29} + a_{30} - 1, a_{23} - a_{24}, a_{22} + 2a_{24} - 1"
    output: strings of the macaulay version invariants
        eg. "a32^2 - a33, a31 + 2a33^2*a45 - 1, a28 + a29 + a30 - 1, a23 - a24, a22 + 2a24 - 1"
"""
function latex_macaulay(str)
    ret = replace(str, r"[{}_]" => "")
    return ret
end

"""
    input:  strings of the latex version invariants
        eg. "a_{32}^{2} - a_{33}, a_{31} + 2a_{33}^{2}*a_{45} - 1, a_{28} + a_{29} + a_{30} - 1, a_{23} - a_{24}, a_{22} + 2a_{24} - 1"
    output: strings of the julia version invariants
        eg. "a[32]^2 - a[33], a[31] + 2a[33]^2*a[45] - 1, a[28] + a[29] + a[30] - 1, a[23] - a[24], a[22] + 2a[24] - 1"
"""
function latex_julia(str)
    ret = []
    temp = replace(str, "{" => "[")
    temp = replace(temp, "}" => "]")
    temp = replace(temp, "_" => "")
    temp = split(temp, "^")
    for i in 1:length(temp)
        if length(temp[i]) > 0
            if length(temp[i]) > 3
                if temp[i][1] == '[' && temp[i][3] == ']' && temp[i][4] == 'a'
                    temp[i] = "^"*temp[i][2]*"*"*temp[i][4:length(temp[i])]
                elseif temp[i][1] == '[' && temp[i][3] == ']' && temp[i][4] != 'a'
                    temp[i] = "^"*temp[i][2]*temp[i][4:length(temp[i])]
                end
            else 
                if temp[i][1] == '[' && temp[i][3] == ']' 
                    temp[i] = "^"*temp[i][2]*temp[i][4:length(temp[i])]
                end
            end
        end
        push!(ret, temp[i])
    end
    return join(ret)
end

main()