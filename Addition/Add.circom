pragma circom 2.1.4;

template Add() {
    signal input in[3];

    in[0] === in[1] + in[2];
}

component main {public [in]}  = Add();

/*
[INFO]  snarkJS: [  ] * [  ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.in[0] +main.in[1] +main.in[2] ] = 0
*/