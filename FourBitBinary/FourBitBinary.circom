pragma circom 2.1.8;

// Create a circuit that takes an array of four signals
// `in`and a signal s and returns is satisfied if `in`
// is the binary representation of `n`. For example:
// 
// Accept:
// 0,  [0,0,0,0]
// 1,  [1,0,0,0]
// 15, [1,1,1,1]
// 
// Reject:
// 0, [3,0,0,0]
// 
// The circuit is unsatisfiable if n > 15

include "../node_modules/circomlib/circuits/bitify.circom";

template FourBitBinary() {
    signal input in[4];
    signal input n;

    for (var i = 0; i < 4; i++) {
        in[i] * (in[i] - 1) === 0;
    }

    component b2n = Bits2Num(4);
    b2n.in <== in;

    component iseq = IsEqual();
    iseq.in[0] <== b2n.out;
    iseq.in[1] <== n;

    iseq.out === 1;
}

component main{public [in, n]} = FourBitBinary();

/*
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[0] ] * [ main.in[0] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[1] ] * [ main.in[1] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[2] ] * [ main.in[2] ] - [  ] = 0
[INFO]  snarkJS: [ 218882428718392752222464057452572750885483644004160343436982041865758084956161 +main.in[3] ] * [ main.in[3] ] - [  ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[0] +21888242871839275222246405745257275088548364400416034343698204186575808495615main.in[1] +21888242871839275222246405745257275088548364400416034343698204186575808495613main.in[2] +21888242871839275222246405745257275088548364400416034343698204186575808495609main.in[3] +main.n ] * [ main.iseq.isz.inv ] - [  ] = 0
[INFO]  snarkJS: [  ] * [  ] - [ main.in[0] +2main.in[1] +4main.in[2] +8main.in[3] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.n ] = 0
*/