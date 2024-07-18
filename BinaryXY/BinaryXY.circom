pragma circom 2.1.8;

template BinaryXY() {
    signal input in[2];

    in[0] * (in[0] - 1) === 0;
    in[1] * (in[1] - 1) === 0;
}

component main = BinaryXY();

/*
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[0] ] * [ main.in[0] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[1] ] * [ main.in[1] ] - [  ] = 0
*/