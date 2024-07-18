pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

template IsZero() {
  signal input in;
  signal output out;

  signal inv <-- in != 0 ? 1 / in : 0;
  out <== 1 - (in * inv);

  in * out === 0;
}

template Equality() {
   // Your Code Here..
   signal input a[3];
   signal output c;

   component iz1 = IsZero();
   component iz2 = IsZero();
   
   iz1.in <== a[0] - a[1];
   iz2.in <== a[1] - a[2];

   c <== iz1.out * iz2.out;
   
}

component main = Equality();

/*
[INFO]  snarkJS: [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.iz1.out ] * [ main.iz2.out ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.c ] = 0
[INFO]  snarkJS: [ main.a[0] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[1] ] * [ main.iz1.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iz1.out ] = 0
[INFO]  snarkJS: [ main.a[0] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[1] ] * [ main.iz1.out ] - [  ] = 0
[INFO]  snarkJS: [ main.a[1] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[2] ] * [ main.iz2.inv ] - [ 1 +21888242871839275222246405745257275088548364400416034343698204186575808495616main.iz2.out ] = 0
[INFO]  snarkJS: [ main.a[1] +21888242871839275222246405745257275088548364400416034343698204186575808495616main.a[2] ] * [ main.iz2.out ] - [  ] = 0
*/