pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";
/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/

template Range(n) {
    signal input a;
    signal input lowerbound;
    signal input upperbound;
    signal output out;

    var max_bits = n;

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

template Sudoku () {
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;
    
    // Checking if the question is valid
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0);
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out;

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; 

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; 

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; 

    // Write your solution from here.. Good Luck!

    component in_range[16];
    signal item_ranges[16];
    for (var i = 0; i < 16; i++) {
        in_range[i] = Range(3);
        in_range[i].a <== solution[i];
        in_range[i].lowerbound <== 1;
        in_range[i].upperbound <== 4;

        item_ranges[i] <== in_range[i].out;
    }

    component sol_matches[16];
    for (var i = 0; i < 16; i++) {
        sol_matches[i] = IsEqual();
        sol_matches[i].in[0] <== solution[i];
        sol_matches[i].in[1] <== question[i];
    }

    component ors[16];
    signal ors_arr[16];
    for (var i = 0; i < 4; i ++) {
        ors[i] = OR();
        ors[i].a <== sol_matches[i].out;
        ors[i].b <== row1[i].out;
        ors_arr[i] <== ors[i].out;

        ors[i + 4] = OR();
        ors[i + 4].a <== sol_matches[i + 4].out;
        ors[i + 4].b <== row2[i].out;
        ors_arr[i + 4] <== ors[i + 4].out;

        ors[i + 8] = OR();
        ors[i + 8].a <== sol_matches[i + 8].out;
        ors[i + 8].b <== row3[i].out;
        ors_arr[i + 8] <== ors[i + 8].out;

        ors[i + 12] = OR();
        ors[i + 12].a <== sol_matches[i + 12].out;
        ors[i + 12].b <== row4[i].out;
        ors_arr[i + 12] <== ors[i + 12].out;
    }
    
    signal uniques[4];
    signal row_product[16];
    signal col_product[16];
    component iseq_row[4];
    component iseq_col[4];
    for (var i = 0; i < 4; i++) {
        row_product[i * 4] <== solution[i * 4];
        col_product[i * 4] <== solution[i];
        for (var j = 1; j < 4; j++) {
            row_product[i * 4 + j] <== row_product[i * 4 + j - 1] * solution[i * 4 + j];
            col_product[i * 4 + j] <== col_product[i * 4 + j - 1] * solution[i + j * 4];
        }

        iseq_row[i] = IsEqual();
        iseq_row[i].in[0] <== row_product[i * 4 + 3];
        iseq_row[i].in[1] <== 24;

        iseq_col[i] = IsEqual();
        iseq_col[i].in[0] <== col_product[i * 4 + 3];
        iseq_col[i].in[1] <== 24;

        uniques[i] <== iseq_row[i].out * iseq_col[i].out;
    }

    component all_unique = MultiAND(4);
    all_unique.in <== uniques;
    component all_in_range = MultiAND(16);
    all_in_range.in <== item_ranges;
    component all_match = MultiAND(16);
    all_match.in <== ors_arr;

    component all_together = MultiAND(3);
    all_together.in[0] <== all_unique.out;
    all_together.in[1] <== all_in_range.out;
    all_together.in[2] <== all_match.out;

    out <== all_together.out;
}



component main = Sudoku();

// 447 constraints
