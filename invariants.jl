using LinearAlgebra
# I don't think we need the n argument bc there will always be 57
# a's for these invariants

"""
    input:
        a: an array of concordance factors
    output: true/false whether the concordance factors fit the invariants
"""
function inv_net1112(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[32] - a[33], 
    a[31] + 2a[33] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[23] - a[24], 
    a[22] + 2a[24] - 1, 
    a[8] - a[9], 
    a[7] + 2a[9] - 1, 
    3a[9]*a[30] + a[9] - a[24] - a[33], 
    a[24]*a[29] + 2a[24]*a[30] + a[29]*a[33] - a[30]*a[33] - a[33], 
    3a[9]*a[29] - 2a[9] + 2a[24] - a[33]]
end

function inv_net1121(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[28] + a[29] + a[30] - 1, 
    a[26] - a[27], 
    a[25] + 2a[27] - 1, 
    a[20] - a[21], 
    a[19] + 2a[21] - 1, 
    a[5] - a[6], 
    a[4] + 2a[6] - 1, 
    a[6]*a[29] + 2a[6]*a[30] - a[6] + a[21] - a[27]]
end

function inv_net1211(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[38] - a[39], 
    a[37] + 2a[39] - 1, 
    a[35] - a[36], 
    a[34] + 2a[36] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[14] - a[15], 
    a[13] + 2a[15] - 1, 
    a[15]*a[29] - a[15]*a[30] + a[36] - a[39]]
end

function inv_net2111(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[53] - a[54], 
    a[52] + 2a[54] - 1, 
    a[50] - a[51], 
    a[49] + 2a[51] - 1, 
    a[44] - a[45], 
    a[43] + 2a[45] - 1, 
    a[28] + a[29] + a[30] - 1]
end

function inv_net1122(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[32] - a[33], 
    a[31] + 2a[33] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[26] - a[27], 
    a[25] + 2a[27] - 1, 
    a[23] - a[24], 
    a[22] + 2a[24] - 1, 
    a[20] - a[21], 
    a[19] + 2a[21] - 1, 
    a[8] - a[9], 
    a[7] + 2a[9] - 1, 
    a[5] - a[6], 
    a[4] + 2a[6] - 1, 
    a[2] - a[3], 
    a[1] + 2a[3] - 1, 
    3a[9]*a[30] + a[9] - a[24] - a[33], 
    a[24]*a[29] + 2a[24]*a[30] + a[29]*a[33] - a[30]*a[33] - a[33], 
    3a[9]*a[29] - 2a[9] + 2a[24] - a[33], 
    a[6]*a[29] + 2a[6]*a[30] - a[6] + a[21] - a[27], 
    a[3]*a[29] + 2a[3]*a[30] - 3a[6]*a[33], 
    3a[6]*a[24] - 3a[3]*a[30] + 3a[6]*a[33] - a[3], 
    3a[9]*a[21] - 3a[9]*a[27] + 3a[6]*a[33] - a[3], 
    3a[6]*a[9] - a[3]]
end

function inv_net1212(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[38] - a[39], 
    a[37] + 2a[39] - 1, 
    a[35] - a[36], 
    a[34] + 2a[36] - 1, 
    a[32] - a[33], 
    a[31] + 2a[33] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[23] - a[24], 
    a[22] + 2a[24] - 1, 
    a[17] - a[18], 
    a[16] + 2a[18] - 1, 
    a[14] - a[15], 
    a[13] + 2a[15] - 1, 
    a[8] - a[9], 
    a[7] + 2a[9] - 1, 
    a[18]*a[30] - a[15]*a[33] - a[9]*a[36] + a[9]*a[39], 
    3a[9]*a[30] + a[9] - a[24] - a[33], 
    a[24]*a[29] + 2a[24]*a[30] + a[29]*a[33] - a[30]*a[33] - a[33], 
    a[18]*a[29] - a[15]*a[33] + 2a[9]*a[36] - 2a[9]*a[39], 
    a[15]*a[29] - a[15]*a[30] + a[36] - a[39], 
    3a[9]*a[29] - 2a[9] + 2a[24] - a[33], 
    3a[15]*a[24] - 3a[9]*a[36] + 3a[9]*a[39] - a[18], 
    3a[9]*a[15] - a[18]]
end

function inv_net2112(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[53] - a[54], 
    a[52] + 2a[54] - 1, 
    a[50] - a[51], 
    a[49] + 2a[51] - 1, 
    a[47] - a[48], 
    a[46] + 2a[48] - 1, 
    a[44] - a[45], 
    a[43] + 2a[45] - 1, 
    a[32] - a[33], 
    a[31] + 2a[33] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[23] - a[24], 
    a[22] + 2a[24] - 1, 
    a[8] - a[9], 
    a[7] + 2a[9] - 1, 
    3a[9]*a[30] + a[9] - a[24] - a[33], 
    a[24]*a[29] + 2a[24]*a[30] + a[29]*a[33] - a[30]*a[33] - a[33], 
    3a[9]*a[29] - 2a[9] + 2a[24] - a[33]]
end

function inv_net2211(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[13] + 2a[15] - 1, 
    a[14] - a[15], 
    a[28] + a[29] + a[30] - 1, 
    a[34] + 2a[36] - 1, 
    a[35] - a[36], 
    a[37] + 2a[39] - 1, 
    a[38] - a[39], 
    a[43] + 2a[45] - 1, 
    a[44] - a[45], 
    a[49] + 2a[51] - 1, 
    a[50] - a[51], 
    a[52] + 2a[54] - 1, 
    a[53] - a[54], 
    a[55] + 2a[57] - 1, 
    a[56] - a[57],
    a[14]*a[29] - a[14]*a[30] + a[35] - a[38], 
    3a[29]^2*a[35]*a[38]*a[44] + 3a[29]*a[30]*a[35]*a[38]*a[44] - 6a[30]^2*a[35]*a[38]*a[44] + 3a[29]^2*a[35]*a[38]*a[50] + 12a[29]*a[30]*a[35]*a[38]*a[50] + 
    12a[30]^2*a[35]*a[38]*a[50] - 6a[29]^2*a[38]^2*a[50] + 3a[29]*a[30]*a[38]^2*a[50] + 3a[30]^2*a[38]^2*a[50] - 3a[29]^2*a[35]^2*a[53] - 12a[29]*a[30]*a[35]^2*a[53] - 
    12a[30]^2*a[35]^2*a[53] - 3a[29]^2*a[35]*a[38]*a[53] - 3a[29]*a[30]*a[35]*a[38]*a[53] + 6a[30]^2*a[35]*a[38]*a[53] - a[29]^3*a[35]*a[56] - 3a[29]^2*a[30]*a[35]*a[56] + 
    4a[30]^3*a[35]*a[56] - 2a[29]^3*a[38]*a[56] - 3a[29]^2*a[30]*a[38]*a[56] + 3a[29]*a[30]^2*a[38]*a[56] + 2a[30]^3*a[38]*a[56] + 3a[29]*a[35]^2*a[44] + 6a[30]*a[35]^2*a[44] - 6a[29]*a[35]*a[38]*a[44] - 3a[30]*a[35]*a[38]*a[44] + 3a[29]*a[38]^2*a[44] - 
    3a[30]*a[38]^2*a[44] - 9a[14]*a[30]*a[35]*a[50] - 9a[14]*a[30]*a[38]*a[50] - 12a[29]*a[35]*a[38]*a[50] - 6a[30]*a[35]*a[38]*a[50] + 12a[29]*a[38]^2*a[50] + 
    6a[30]*a[38]^2*a[50] + 18a[14]*a[30]*a[35]*a[53] + 3a[29]*a[35]^2*a[53] + 6a[30]*a[35]^2*a[53] - 9a[30]*a[35]*a[38]*a[53] - 3a[29]*a[38]^2*a[53] + 
    3a[30]*a[38]^2*a[53] + a[29]^2*a[35]*a[56] + a[29]*a[30]*a[35]*a[56] - 2a[30]^2*a[35]*a[56] + 2a[29]^2*a[38]*a[56] - a[29]*a[30]*a[38]*a[56] - 
    a[30]^2*a[38]*a[56] - 3a[14]*a[35]*a[44] - 3a[35]^2*a[44] + 3a[14]*a[38]*a[44] + 9a[35]*a[38]*a[44] - 6a[38]^2*a[44] + 3a[14]^2*a[50] + 6a[14]*a[35]*a[50] - 
    6a[14]*a[38]*a[50] + 3a[35]*a[38]*a[50] - 3a[38]^2*a[50] - 3a[14]^2*a[53] - 3a[14]*a[35]*a[53] - 6a[35]^2*a[53] + 3a[14]*a[38]*a[53] + 3a[35]*a[38]*a[53] + 
    3a[38]^2*a[53] - 2a[29]*a[35]*a[56] - 4a[30]*a[35]*a[56] + 2a[29]*a[38]*a[56] + 4a[30]*a[38]*a[56] + 2a[35]*a[56] - 2a[38]*a[56]]
end

function inv_net2121(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[4] + 2a[6] - 1, 
    a[5] - a[6], 
    a[28] + a[29] + a[30] - 1, 
    a[19] + 2a[21] - 1, 
    a[20] - a[21], 
    a[25] + 2a[27] - 1, 
    a[26] - a[27], 
    a[40] + 2a[42] - 1, 
    a[41] - a[42], 
    a[43] + 2a[45] - 1, 
    a[44] - a[45], 
    a[49] + 2a[51] - 1, 
    a[50] - a[51], 
    a[52] + 2a[54] - 1, 
    a[53] - a[54],
    a[5]*a[29] + 2a[5]*a[30] - a[5] + a[20] - a[26], 
    2a[20]*a[29]^3*a[41] + a[26]*a[29]^3*a[41] + 3a[20]*a[29]^2*a[30]*a[41] - 3a[20]*a[29]*a[30]^2*a[41] - 
    3a[26]*a[29]*a[30]^2*a[41] - 2a[20]*a[30]^3*a[41] + 2a[26]*a[30]^3*a[41] - 3a[20]*a[26]*a[29]^2*a[44] - 3a[26]^2*a[29]^2*a[44] - 3a[20]*a[26]*a[29]*a[30]*a[44] + 
    6a[26]^2*a[29]*a[30]*a[44] + 6a[20]*a[26]*a[30]^2*a[44] - 3a[26]^2*a[30]^2*a[44] - 6a[20]^2*a[29]^2*a[50] + 3a[20]*a[26]*a[29]^2*a[50] - 15a[20]^2*a[29]*a[30]*a[50] - 
    6a[20]*a[26]*a[29]*a[30]*a[50] - 6a[20]^2*a[30]^2*a[50] + 3a[20]*a[26]*a[30]^2*a[50] + 3a[20]*a[26]*a[29]^2*a[53] + 3a[20]*a[26]*a[29]*a[30]*a[53] - 
    6a[20]*a[26]*a[30]^2*a[53] - 4a[20]*a[29]^2*a[41] - 2a[26]*a[29]^2*a[41] - a[20]*a[29]*a[30]*a[41] + a[26]*a[29]*a[30]*a[41] + 5a[20]*a[30]^2*a[41] + 
    a[26]*a[30]^2*a[41] + 3a[20]^2*a[29]*a[44] + 6a[20]*a[26]*a[29]*a[44] + 3a[26]^2*a[29]*a[44] + 6a[20]^2*a[30]*a[44] + 18a[5]*a[26]*a[30]*a[44] - 
    6a[20]*a[26]*a[30]*a[44] - 3a[26]^2*a[30]*a[44] + 6a[20]*a[26]*a[29]*a[50] - 9a[5]*a[20]*a[30]*a[50] + 9a[20]^2*a[30]*a[50] - 9a[5]*a[26]*a[30]*a[50] + 
    12a[20]*a[26]*a[30]*a[50] - 3a[20]^2*a[29]*a[53] - 3a[26]^2*a[29]*a[53] - 6a[20]^2*a[30]*a[53] + 3a[26]^2*a[30]*a[53] + 3a[26]*a[29]*a[41] - 
    3a[26]*a[30]*a[41] - 3a[5]^2*a[44] + 3a[5]*a[20]*a[44] - 3a[5]*a[26]*a[44] - 6a[26]^2*a[44] + 3a[5]^2*a[50] - 6a[5]*a[20]*a[50] + 3a[20]^2*a[50] + 
    6a[5]*a[26]*a[50] - 6a[20]*a[26]*a[50] + 3a[5]*a[20]*a[53] - 3a[20]^2*a[53] - 3a[5]*a[26]*a[53] + 6a[20]*a[26]*a[53]]
end

function inv_net1221(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[38] - a[39], 
    a[37] + 2a[39] - 1, 
    a[35] - a[36], 
    a[34] + 2a[36] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[26] - a[27], 
    a[25] + 2a[27] - 1, 
    a[20] - a[21], 
    a[19] + 2a[21] - 1, 
    a[14] - a[15], 
    a[13] + 2a[15] - 1, 
    a[11] - a[12], 
    a[10] + 2a[12] - 1, 
    a[5] - a[6], 
    a[4] + 2a[6] - 1, 
    a[15]*a[29] - a[15]*a[30] + a[36] - a[39], 
    a[12]*a[29] - a[12]*a[30] + 3a[6]*a[36] - 3a[6]*a[39], 
    a[6]*a[29] + 2a[6]*a[30] - a[6] + a[21] - a[27], 
    3a[15]*a[21] - 3a[15]*a[27] + 3a[12]*a[30] - 3a[6]*a[36] + 3a[6]*a[39] - a[12], 
    3a[6]*a[15] - a[12], 
    a[21]*a[29]*a[36] + 2a[21]*a[30]*a[36] - a[27]*a[29]*a[39] + a[27]*a[30]*a[39] - a[15]*a[27] + a[12]*a[30] - a[6]*a[36] - a[21]*a[36] - a[27]*a[36] + 2a[21]*a[39]]
end

function inv_net1222(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[38] - a[39], 
    a[37] + 2a[39] - 1, 
    a[35] - a[36], 
    a[34] + 2a[36] - 1, 
    a[32] - a[33], 
    a[31] + 2a[33] - 1, 
    a[28] + a[29] + a[30] - 1, 
    a[26] - a[27], 
    a[25] + 2a[27] - 1, 
    a[23] - a[24], 
    a[22] + 2a[24] - 1, 
    a[20] - a[21], 
    a[19] + 2a[21] - 1, 
    a[17] - a[18], 
    a[16] + 2a[18] - 1, 
    a[14] - a[15], 
    a[13] + 2a[15] - 1, 
    a[11] - a[12], 
    a[10] + 2a[12] - 1, 
    a[8] - a[9], 
    a[7] + 2a[9] - 1, 
    a[5] - a[6], 
    a[4] + 2a[6] - 1, 
    a[2] - a[3], 
    a[1] + 2a[3] - 1, 
    a[18]*a[30] - a[15]*a[33] - a[9]*a[36] + a[9]*a[39], 
    3a[9]*a[30] + a[9] - a[24] - a[33], 
    a[24]*a[29] + 2a[24]*a[30] + a[29]*a[33] - a[30]*a[33] - a[33], 
    a[18]*a[29] - a[15]*a[33] + 2a[9]*a[36] - 2a[9]*a[39], 
    a[15]*a[29] - a[15]*a[30] + a[36] - a[39], 
    a[12]*a[29] - a[12]*a[30] + 3a[6]*a[36] - 3a[6]*a[39], 
    3a[9]*a[29] - 2a[9] + 2a[24] - a[33], 
    a[6]*a[29] + 2a[6]*a[30] - a[6] + a[21] - a[27], 
    a[3]*a[29] + 2a[3]*a[30] - 3a[6]*a[33], 
    3a[15]*a[24] - 3a[9]*a[36] + 3a[9]*a[39] - a[18], 
    3a[6]*a[24] - 3a[3]*a[30] + 3a[6]*a[33] - a[3], 
    a[18]*a[21] - a[12]*a[24] - a[18]*a[27] + a[12]*a[33] + a[3]*a[36] - a[3]*a[39], 
    3a[15]*a[21] - 3a[15]*a[27] + 3a[12]*a[30] - 3a[6]*a[36] + 3a[6]*a[39] - a[12], 
    3a[9]*a[21] - 3a[9]*a[27] + 3a[6]*a[33] - a[3], 
    a[6]*a[18] - a[12]*a[24] + a[3]*a[36] - a[3]*a[39], 
    3a[9]*a[15] - a[18], 
    3a[6]*a[15] - a[12], 
    a[3]*a[15] - a[12]*a[24] + a[3]*a[36] - a[3]*a[39], 
    a[9]*a[12] - a[12]*a[24] + a[3]*a[36] - a[3]*a[39], 
    3a[6]*a[9] - a[3], 
    a[21]*a[29]*a[36] + 2a[21]*a[30]*a[36] - a[27]*a[29]*a[39] + a[27]*a[30]*a[39] - a[15]*a[27] + a[12]*a[30] - a[6]*a[36] - a[21]*a[36] - a[27]*a[36] + 2a[21]*a[39], 
    6a[9]*a[27]*a[36] - 3a[6]*a[33]*a[36] - 3a[21]*a[33]*a[36] - 3a[9]*a[27]*a[39] - 3a[24]*a[27]*a[39] + 6a[6]*a[33]*a[39] + a[18]*a[27] - a[12]*a[33] + a[3]*a[36] - a[3]*a[39]]
end

function inv_net2212(a)
    length(a) == 57 || error("wrong dimension of a")

    return [a[16] + 2a[18] - 1, 
    a[17] - a[18], 
    a[28] + a[29] + a[30] - 1, 
    a[13] + 2a[15] - 1, 
    a[14] - a[15], 
    a[31] + 2a[33] - 1, 
    a[32] - a[33], 
    a[7] + 2a[9] - 1, 
    a[8] - a[9], 
    a[34] + 2a[36] - 1, 
    a[35] - a[36], 
    a[37] + 2a[39] - 1, 
    a[38] - a[39], 
    a[22] + 2a[24] - 1, 
    a[23] - a[24], 
    a[43] + 2a[45] - 1, 
    a[44] - a[45], 
    a[46] + 2a[48] - 1, 
    a[47] - a[48], 
    a[49] + 2a[51] - 1, 
    a[50] - a[51], 
    a[52] + 2a[54] - 1, 
    a[53] - a[54], 
    a[55] + 2a[57] - 1, 
    a[56] - a[57],
    a[17]*a[30] - a[14]*a[32] - a[8]*a[35] + a[8]*a[38], 
    3a[8]*a[30] + a[8] - a[23] - a[32], 
    a[23]*a[29] + 2a[23]*a[30] + a[29]*a[32] - a[30]*a[32] - a[32], 
    a[17]*a[29] - a[14]*a[32] + 2a[8]*a[35] - 2a[8]*a[38], 
    a[14]*a[29] - a[14]*a[30] + a[35] - a[38], 
    3a[8]*a[29] - 2a[8] + 2a[23] - a[32], 
    3a[14]*a[23] - 3a[8]*a[35] + 3a[8]*a[38] - a[17], 
    3a[8]*a[14] - a[17], 

    3a[32]*a[38]*a[44] - 2a[29]*a[38]*a[47] - a[30]*a[38]*a[47] - 3a[32]*a[38]*a[50] + 3a[32]*a[35]*a[53] + 3a[8]*a[38]*a[53] - 3a[23]*a[38]*a[53] + 
    a[29]*a[32]*a[56] - a[30]*a[32]*a[56] - a[17]*a[44] + a[14]*a[47] - a[35]*a[47] + a[38]*a[47] + a[17]*a[50] - a[17]*a[53] - a[8]*a[56] + a[23]*a[56], 

    3a[8]*a[35]*a[44] - 3a[32]*a[35]*a[44] - 3a[8]*a[38]*a[44] + a[29]*a[35]*a[47] + 2a[30]*a[35]*a[47] + 3a[8]*a[35]*a[50] - 3a[23]*a[38]*a[50] + 
    a[29]*a[32]*a[56] - a[30]*a[32]*a[56] + a[17]*a[44] - a[14]*a[47] - a[35]*a[47] + a[38]*a[47] - a[8]*a[56] + a[23]*a[56], 

    3a[17]*a[32]*a[44]^2 - 6a[14]*a[32]*a[44]*a[47] + 3a[32]*a[35]*a[44]*a[47] + 3a[14]*a[30]*a[47]^2 - a[29]*a[35]*a[47]^2 - 2a[30]*a[35]*a[47]^2 - 
    3a[8]*a[17]*a[44]*a[50] - 3a[17]*a[32]*a[44]*a[50] + 3a[14]*a[32]*a[47]*a[50] - 3a[8]*a[35]*a[47]*a[50] + 3a[23]*a[38]*a[47]*a[50] + 3a[8]*a[17]*a[50]^2 - 
    3a[17]*a[23]*a[44]*a[53] + 3a[8]*a[35]*a[47]*a[53] - 3a[8]*a[38]*a[47]*a[53] - 3a[17]*a[23]*a[50]*a[53] + 6a[8]*a[32]*a[44]*a[56] - a[29]*a[32]*a[47]*a[56] + 
    a[30]*a[32]*a[47]*a[56] - 3a[8]^2*a[50]*a[56] + 3a[8]*a[23]*a[50]*a[56] - 3a[8]*a[32]*a[50]*a[56] + 3a[8]^2*a[53]*a[56] - 3a[8]*a[23]*a[53]*a[56] + 
    3a[8]*a[32]*a[53]*a[56] - a[35]*a[47]^2 + a[38]*a[47]^2 + a[17]*a[47]*a[50] + a[17]*a[47]*a[53] - 2a[32]*a[47]*a[56], 

    9a[8]*a[23]*a[38]*a[44]*a[50] - 9a[8]*a[23]*a[38]*a[50]^2 + 9a[23]*a[32]*a[35]*a[44]*a[53] + 9a[8]*a[23]*a[38]*a[44]*a[53] + 3a[29]*a[32]*a[35]*a[47]*a[53] - 
    3a[30]*a[32]*a[35]*a[47]*a[53] + 9a[23]^2*a[38]*a[50]*a[53] + 9a[23]*a[30]*a[32]*a[53]*a[56] + 3a[29]*a[32]^2*a[53]*a[56] - 3a[30]*a[32]^2*a[53]*a[56] - 
    3a[17]*a[23]*a[44]^2 - 3a[23]*a[35]*a[44]*a[47] + 6a[32]*a[35]*a[44]*a[47] - 3a[29]*a[35]*a[47]^2 - 3a[30]*a[35]*a[47]^2 + 3a[17]*a[23]*a[44]*a[50] - 
    9a[8]*a[35]*a[47]*a[50] + 3a[8]*a[38]*a[47]*a[50] + 3a[23]*a[38]*a[47]*a[50] - 3a[17]*a[23]*a[44]*a[53] + 3a[8]*a[35]*a[47]*a[53] - 3a[32]*a[35]*a[47]*a[53] - 
    3a[8]*a[38]*a[47]*a[53] - 3a[23]*a[38]*a[47]*a[53] - 6a[8]*a[23]*a[44]*a[56] - 3a[23]*a[30]*a[47]*a[56] - 3a[29]*a[32]*a[47]*a[56] + 3a[30]*a[32]*a[47]*a[56] + 
    6a[8]*a[23]*a[50]*a[56] - 3a[23]^2*a[50]*a[56] - 3a[8]*a[23]*a[53]*a[56] - 3a[32]^2*a[53]*a[56] + a[14]*a[47]^2 + 2a[35]*a[47]^2 - a[38]*a[47]^2 - 
    a[17]*a[47]*a[50] + a[17]*a[47]*a[53] + 2a[8]*a[47]*a[56] + a[32]*a[47]*a[56], 
    
    9a[23]*a[32]*a[35]*a[44]^2 + 9a[23]*a[30]*a[35]*a[44]*a[47] + a[29]^2*a[35]*a[47]^2 + 
    4a[29]*a[30]*a[35]*a[47]^2 - 5a[30]^2*a[35]*a[47]^2 - 18a[23]*a[32]*a[35]*a[44]*a[50] - 6a[29]*a[32]*a[35]*a[47]*a[50] + 6a[30]*a[32]*a[35]*a[47]*a[50] + 
    27a[23]*a[30]*a[38]*a[47]*a[50] + 9a[29]*a[32]*a[38]*a[47]*a[50] - 9a[30]*a[32]*a[38]*a[47]*a[50] + 18a[8]*a[23]*a[35]*a[50]^2 - 9a[8]*a[23]*a[38]*a[50]^2 - 
    9a[23]^2*a[38]*a[50]^2 - 9a[23]^2*a[35]*a[44]*a[53] + 9a[23]*a[32]*a[35]*a[44]*a[53] + 9a[8]*a[23]*a[38]*a[44]*a[53] + 9a[23]*a[30]*a[35]*a[47]*a[53] + 
    6a[29]*a[32]*a[35]*a[47]*a[53] - 6a[30]*a[32]*a[35]*a[47]*a[53] - 9a[23]^2*a[35]*a[50]*a[53] + 9a[23]^2*a[38]*a[50]*a[53] + 9a[23]*a[30]*a[32]*a[44]*a[56] + 
    3a[29]*a[32]^2*a[44]*a[56] - 3a[30]*a[32]^2*a[44]*a[56] + 9a[23]*a[30]^2*a[47]*a[56] + a[29]^2*a[32]*a[47]*a[56] + a[29]*a[30]*a[32]*a[47]*a[56] - 
    2a[30]^2*a[32]*a[47]*a[56] + 9a[23]^2*a[30]*a[50]*a[56] - 27a[23]*a[30]*a[32]*a[50]*a[56] - 9a[29]*a[32]^2*a[50]*a[56] + 9a[30]*a[32]^2*a[50]*a[56] - 
    9a[23]^2*a[30]*a[53]*a[56] + 18a[23]*a[30]*a[32]*a[53]*a[56] + 6a[29]*a[32]^2*a[53]*a[56] - 6a[30]*a[32]^2*a[53]*a[56] - 3a[17]*a[23]*a[44]^2 - 
    9a[23]*a[35]*a[44]*a[47] - 3a[32]*a[35]*a[44]*a[47] + 9a[23]*a[38]*a[44]*a[47] - 3a[29]*a[35]*a[47]^2 + 3a[29]*a[38]*a[47]^2 - 3a[30]*a[38]*a[47]^2 + 
    6a[17]*a[23]*a[44]*a[50] - 3a[8]*a[35]*a[47]*a[50] - 9a[23]*a[35]*a[47]*a[50] + 6a[32]*a[35]*a[47]*a[50] + 6a[8]*a[38]*a[47]*a[50] + 6a[23]*a[38]*a[47]*a[50] - 
    9a[32]*a[38]*a[47]*a[50] - 3a[17]*a[23]*a[44]*a[53] + 3a[8]*a[35]*a[47]*a[53] + 3a[23]*a[35]*a[47]*a[53] - 6a[32]*a[35]*a[47]*a[53] - 3a[8]*a[38]*a[47]*a[53] - 
    3a[23]*a[38]*a[47]*a[53] - 3a[8]*a[23]*a[44]*a[56] + 3a[23]^2*a[44]*a[56] - 3a[32]^2*a[44]*a[56] - 12a[23]*a[30]*a[47]*a[56] - 4a[29]*a[32]*a[47]*a[56] + 
    a[30]*a[32]*a[47]*a[56] - 3a[23]*a[32]*a[50]*a[56] + 9a[32]^2*a[50]*a[56] - 3a[8]*a[23]*a[53]*a[56] + 3a[23]^2*a[53]*a[56] + 3a[23]*a[32]*a[53]*a[56] - 
    6a[32]^2*a[53]*a[56] + a[14]*a[47]^2 + 4a[35]*a[47]^2 - 4a[38]*a[47]^2 - 2a[17]*a[47]*a[50] + a[17]*a[47]*a[53] - a[8]*a[47]*a[56] + a[23]*a[47]*a[56] + 
    4a[32]*a[47]*a[56], 
    
    3a[14]*a[17]^2*a[44]^2 - 6a[14]^2*a[17]*a[44]*a[47] + 3a[14]*a[17]*a[35]*a[44]*a[47] + 3a[14]^3*a[47]^2 - 3a[14]^2*a[35]*a[47]^2 - 
    3a[14]*a[17]^2*a[44]*a[50] - 3a[17]^2*a[38]*a[44]*a[50] + 3a[14]^2*a[17]*a[47]*a[50] + 3a[14]*a[17]*a[38]*a[47]*a[50] + 3a[17]^2*a[38]*a[50]^2 - 
    3a[17]^2*a[35]*a[44]*a[53] + 3a[14]*a[17]*a[35]*a[47]*a[53] - 3a[17]^2*a[35]*a[50]*a[53] + 3a[8]*a[17]*a[35]*a[50]*a[56] - 3a[8]*a[17]*a[38]*a[50]*a[56] - 
    3a[8]*a[17]*a[35]*a[53]*a[56] + 3a[8]*a[17]*a[38]*a[53]*a[56] + 2a[17]^2*a[44]*a[56] - 2a[14]*a[17]*a[47]*a[56] + a[17]*a[35]*a[47]*a[56] - a[17]*a[38]*a[47]*a[56] - 
    a[17]^2*a[50]*a[56] + a[17]^2*a[53]*a[56], 
    
    3a[29]^2*a[35]*a[38]*a[44] + 3a[29]*a[30]*a[35]*a[38]*a[44] - 6a[30]^2*a[35]*a[38]*a[44] + 3a[29]^2*a[35]*a[38]*a[50] + 
    12a[29]*a[30]*a[35]*a[38]*a[50] + 12a[30]^2*a[35]*a[38]*a[50] - 6a[29]^2*a[38]^2*a[50] + 3a[29]*a[30]*a[38]^2*a[50] + 3a[30]^2*a[38]^2*a[50] - 
    3a[29]^2*a[35]^2*a[53] - 12a[29]*a[30]*a[35]^2*a[53] - 12a[30]^2*a[35]^2*a[53] - 3a[29]^2*a[35]*a[38]*a[53] - 3a[29]*a[30]*a[35]*a[38]*a[53] + 
    6a[30]^2*a[35]*a[38]*a[53] - a[29]^3*a[35]*a[56] - 3a[29]^2*a[30]*a[35]*a[56] + 4a[30]^3*a[35]*a[56] - 2a[29]^3*a[38]*a[56] - 3a[29]^2*a[30]*a[38]*a[56] + 
    3a[29]*a[30]^2*a[38]*a[56] + 2a[30]^3*a[38]*a[56] + 3a[29]*a[35]^2*a[44] + 6a[30]*a[35]^2*a[44] - 6a[29]*a[35]*a[38]*a[44] - 3a[30]*a[35]*a[38]*a[44] + 
    3a[29]*a[38]^2*a[44] - 3a[30]*a[38]^2*a[44] - 9a[14]*a[30]*a[35]*a[50] - 9a[14]*a[30]*a[38]*a[50] - 12a[29]*a[35]*a[38]*a[50] - 6a[30]*a[35]*a[38]*a[50] + 
    12a[29]*a[38]^2*a[50] + 6a[30]*a[38]^2*a[50] + 18a[14]*a[30]*a[35]*a[53] + 3a[29]*a[35]^2*a[53] + 6a[30]*a[35]^2*a[53] - 9a[30]*a[35]*a[38]*a[53] - 
    3a[29]*a[38]^2*a[53] + 3a[30]*a[38]^2*a[53] + a[29]^2*a[35]*a[56] + a[29]*a[30]*a[35]*a[56] - 2a[30]^2*a[35]*a[56] + 2a[29]^2*a[38]*a[56] - 
    a[29]*a[30]*a[38]*a[56] - a[30]^2*a[38]*a[56] - 3a[14]*a[35]*a[44] - 3a[35]^2*a[44] + 3a[14]*a[38]*a[44] + 9a[35]*a[38]*a[44] - 6a[38]^2*a[44] + 
    3a[14]^2*a[50] + 6a[14]*a[35]*a[50] - 6a[14]*a[38]*a[50] + 3a[35]*a[38]*a[50] - 3a[38]^2*a[50] - 3a[14]^2*a[53] - 3a[14]*a[35]*a[53] - 6a[35]^2*a[53] + 
    3a[14]*a[38]*a[53] + 3a[35]*a[38]*a[53] + 3a[38]^2*a[53] - 2a[29]*a[35]*a[56] - 4a[30]*a[35]*a[56] + 2a[29]*a[38]*a[56] + 4a[30]*a[38]*a[56] + 2a[35]*a[56] - 2a[38]*a[56]]
end

