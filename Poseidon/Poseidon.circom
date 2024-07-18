pragma circom 2.1.4;


// Go through the circomlib library and import the poseidon hashing template using node_modules
// Input 4 variables,namely,'a','b','c','d' , and output variable 'out' .
// Now , hash all the 4 inputs using poseidon and output it . 

include "../node_modules/circomlib/circuits/poseidon.circom";

template poseidon() {

   signal input a;
   signal input b;
   signal input c;
   signal input d;
   signal output out;

   component pos = Poseidon(4);
   
   pos.inputs[0] <== a;
   pos.inputs[1] <== b;
   pos.inputs[2] <== c;
   pos.inputs[3] <== d;

   out <== pos.out;
}

component main = poseidon();

// 297 constraints