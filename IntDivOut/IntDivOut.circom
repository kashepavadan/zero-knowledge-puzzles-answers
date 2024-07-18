pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

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

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;

    signal remainder <-- numerator % denominator;
    signal quotient <-- numerator \ denominator;

    component intdiv = IntDiv(n);
    intdiv.numerator <== numerator;
    intdiv.denominator <== denominator;
    intdiv.remainder <== remainder;
    intdiv.quotient <== quotient;

    out <== quotient;
}

component main = IntDivOut(252);

// 1517 constraints
