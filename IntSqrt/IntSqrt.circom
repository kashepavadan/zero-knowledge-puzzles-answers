pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if
// in[0] is the floor of the integer integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];

    component n2b_0 = Num2Bits(n);
    n2b_0.in <== in[0];
    component n2b_1 = Num2Bits(n);
    n2b_1.in <== in[1];
    component n2b_prod = Num2Bits(n);
    n2b_prod.in <== (in[0] + 1) * (in[0] + 1);

    component lt1 = LessThan(n);
    lt1.in[0] <== (in[0] - 1) * (in[0] - 1);
    lt1.in[1] <== in[1];
    component lt2 = LessThan(n);
    lt2.in[0] <== in[1];
    lt2.in[1] <== (in[0] + 1) * (in[0] + 1);

    lt1.out * lt2.out === 1;
}

component main = IntSqrt(252);

// 1266 constraints
