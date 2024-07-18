pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/bitify.circom";
include "../node_modules/circomlib/circuits/gates.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted() {
    signal input in[4];

    component n2b[4];
    for (var i = 0; i < 4; i++) {
        n2b[i] = Num2Bits(252);
        n2b[i].in <== in[i];
    }

    component lt[4];
    signal results[3];
    for (var i = 0; i < 3; i++) {
        lt[i] = LessEqThan(252);
        lt[i].in[0] <== in[i];
        lt[i].in[1] <== in[i + 1];

        results[i] <== lt[i].out;
    }

    component multi_and = MultiAND(3);
    multi_and.in <== results;
    multi_and.out === 1;
}

component main = IsSorted();

// 1769 constraints
