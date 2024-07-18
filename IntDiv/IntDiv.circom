pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;

    component n2b_remainder = Num2Bits(n);
    n2b_remainder.in <== remainder;
    component n2b_denominator = Num2Bits(n);
    n2b_denominator.in <== denominator;
    component n2b_numerator = Num2Bits(n);
    n2b_numerator.in <== numerator;
    component n2b_quotient = Num2Bits(n);
    n2b_quotient.in <== quotient;


    component isz = IsZero();
    isz.in <== denominator;
    component lt = LessThan(n);
    lt.in[0] <== remainder;
    lt.in[1] <== denominator;
    component lt2 = LessThan(n);
    lt2.in[0] <== quotient;
    lt2.in[1] <== numerator;

    lt.out * (1 - isz.out) === 1;
    lt2.out === 1;

    quotient * denominator + remainder === numerator;

}

component main = IntDiv(252);

// 761 constraints
