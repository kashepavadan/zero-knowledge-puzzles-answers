pragma circom 2.1.8;

// Create constraints that enforces all signals
// in `in` are binary, i.e. 0 or 1.

template AllBinary(n) {
    signal input in[n];

    for (var i = 0; i < n; i++) {
        in[i] * (in[i] - 1) === 0;
    }
}

component main = AllBinary(4);

/*
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[0] ] * [ main.in[0] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[1] ] * [ main.in[1] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[2] ] * [ main.in[2] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[3] ] * [ main.in[3] ] - [  ] = 0
*/