pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    in[0] * (in[0] - 1) === 0;
    var ors;
    ors = in[0];
    for (var i = 1; i < n; i++) {
        in[i] * (in[i] - 1) === 0;

        ors += in[i];
    }

    component lt = IsZero();
    lt.in <== ors;

    out <== 1 - lt.out;
}

component main = MultiOR(4);

/*
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[0] ] * [ main.in[0] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[1] ] * [ main.in[1] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[2] ] * [ main.in[2] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[3] ] * [ main.in[3] ] - [  ] = 0
[INFO]  snarkJS: [ main.in[0] +main.in[1] +main.in[2] +main.in[3] ] * [ main.lt.inv ] - [ main.out ] = 0
[INFO]  snarkJS: [ main.in[0] +main.in[1] +main.in[2] +main.in[3] ] * [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.out ] - [  ] = 0
*/