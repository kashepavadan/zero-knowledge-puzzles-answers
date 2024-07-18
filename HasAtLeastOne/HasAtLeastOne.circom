pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

include "../node_modules/circomlib/circuits/comparators.circom";

template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;
    signal output out;

    component iseq[n];
    var sum_eq = 0;
    for (var i = 0; i < n; i++) {
        iseq[i] = IsEqual();
        iseq[i].in[0] <== in[i];
        iseq[i].in[1] <== k;
        sum_eq += iseq[i].out;
    }

    component isz = IsZero();
    isz.in <== sum_eq;

    out <== 1 - isz.out;
}

component main = HasAtLeastOne(4);

/*
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[0] +main.k ] * [ main.iseq[0].isz.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iseq[0].out ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[0] +main.k ] * [ main.iseq[0].out ] - [  ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[1] +main.k ] * [ main.iseq[1].isz.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iseq[1].out ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[1] +main.k ] * [ main.iseq[1].out ] - [  ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[2] +main.k ] * [ main.iseq[2].isz.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iseq[2].out ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[2] +main.k ] * [ main.iseq[2].out ] - [  ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[3] +main.k ] * [ main.iseq[3].isz.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iseq[3].out ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[3] +main.k ] * [ main.iseq[3].out ] - [  ] = 0
[INFO]  snarkJS: [ main.iseq[0].out +main.iseq[1].out +main.iseq[2].out +main.iseq[3].out ] * [ main.isz.inv ] - [ main.out ] = 0
[INFO]  snarkJS: [ main.iseq[0].out +main.iseq[1].out +main.iseq[2].out +main.iseq[3].out ] * [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.out ] - [  ] = 0
*/