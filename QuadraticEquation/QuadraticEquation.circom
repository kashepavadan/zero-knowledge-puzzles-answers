pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equal

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    signal x2 <== x * x;
    signal ax2 <== a * x2;
    signal combo <== ax2 + (b * x) + c;
    
    component iseq = IsEqual();
    iseq.in[0] <== combo;
    iseq.in[1] <== res;

    out <== iseq.out;
}

component main  = QuadraticEquation();

/*
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.x ] * [ main.x ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.x2 ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.a ] * [ main.x2 ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.ax2 ] = 0
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.b ] * [ main.x ] - [ main.c +main.ax2 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.combo ] = 0
[INFO]  snarkJS: [ main.res +21888242871839275222246405745257275088548364400416034343698204186575808495616main.combo ] * [ main.iseq.isz.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.out ] = 0
[INFO]  snarkJS: [ main.res +21888242871839275222246405745257275088548364400416034343698204186575808495616main.combo ] * [ main.out ] - [  ] = 0
*/

