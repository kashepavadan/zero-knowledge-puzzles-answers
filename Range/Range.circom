pragma circom 2.1.4;

// In this exercise , we will learn how to check the range of a private variable and prove that 
// it is within the range . 

// For example we can prove that a certain person's income is within the range
// Declare 3 input signals `a`, `lowerbound` and `upperbound`.
// If 'a' is within the range, output 1 , else output 0 using 'out'

include "../node_modules/circomlib/circuits/comparators.circom";

template Range() {
    signal input a;
    signal input lowerbound;
    signal input upperbound;
    signal output out;

    var max_bits = 252;

    component n2b_a = Num2Bits(max_bits);
    n2b_a.in <== a;
    component n2b_lowerbound = Num2Bits(max_bits);
    n2b_lowerbound.in <== lowerbound;
    component n2b_upperbound = Num2Bits(max_bits);
    n2b_upperbound.in <== upperbound;
   
    component let = LessEqThan(max_bits);
    component get = GreaterEqThan(max_bits);
    get.in[0] <== a;
    get.in[1] <== lowerbound;
    let.in[0] <== a;
    let.in[1] <== upperbound;

    out <== let.out * get.out;
}

component main  = Range();

// 1263 constraints


