pragma circom 2.1.4;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 

include "../node_modules/circomlib/circuits/bitify.circom";

template Pow() {
   signal input a[2];
   signal output c;

   var max_bits = 254;

   component n2b = Num2Bits_strict();
   n2b.in <== a[1];

   component b2n = Bits2Num_strict();
   b2n.in <== n2b.out;
   b2n.out === a[1];

   signal binary_pows[max_bits];
   binary_pows[0] <== a[0];
   for (var i = 1; i < max_bits; i++) {
      binary_pows[i] <== binary_pows[i - 1] * binary_pows[i - 1];
   }

   signal mults[max_bits];
   mults[0] <== (binary_pows[0] * n2b.out[0]) + (1 - n2b.out[0]);
   signal result[max_bits];
   result[0] <== mults[0];

   for (var i = 1; i < max_bits; i++) {
      mults[i] <== (binary_pows[i] * n2b.out[i]) + (1 - n2b.out[i]);
      result[i] <== result[i - 1] * mults[i];
   }

   c <== result[max_bits - 1];
}

component main = Pow();

// 1536 constraints
