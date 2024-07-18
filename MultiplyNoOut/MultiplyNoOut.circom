pragma circom 2.1.8;

// Your circuit should constrain the third signal in `in`
// to be the product of the first two signals

template MultiplyNoOutput() {
    signal input in[3];

    in[2] === in[0] * in[1];

}

component main = MultiplyNoOutput();

/*
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[0] ] * [ main.in[1] ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[2] ] = 0
*/