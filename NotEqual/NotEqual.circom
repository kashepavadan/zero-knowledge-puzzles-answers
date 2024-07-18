pragma circom 2.1.4;


// Input : a , length of 2 .
// Output : c .
// In this exercise , you have to check that a[0] is NOT equal to a[1], if not equal, output 1, else output 0.
// You are free to use any operator you may like . 

// HINT:NEGATION

template IsZero() {
  signal input in;
  signal output out;

  signal inv <-- in != 0 ? 1 / in : 0;
  out <== 1 - (in * inv);

  in * out === 0;
}

template NotEqual() {

    // Your code here.
    signal input a[2];
    signal output c;

    component isz = IsZero();

    isz.in <== a[0] - a[1];

    c <== 1 - isz.out;
}

component main = NotEqual();

/*
[INFO]  snarkJS: [ main.a[0] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[1] ] * [ main.isz.inv ] - [ main.c ] = 0
[INFO]  snarkJS: [ main.a[0] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[1] ] * [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.c ] - [  ] = 0
*/