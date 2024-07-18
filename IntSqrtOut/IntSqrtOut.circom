pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(x) {
    // compute the floor of the
    // integer square root
    var x1 = x \ 2;
    var x2 = 2;

    while (x2 - x1 > 1 || x2 - x1 < -1) {
        x2 = (x1 + x2) \ 2;
        x1 = x \ x2;
    }

    return x1;
}

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

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    out <-- intSqrtFloor(in);
    // constrain out using your
    // work from IntSqrt

    component sqrt = IntSqrt(n);
    sqrt.in[0] <== out;
    sqrt.in[1] <== in;
}

component main = IntSqrtOut(252);

// 1266 constraints