pragma circom 2.1.4;

// Input : 'a',array of length 2 .
// Output : 'c 
// Using a forLoop , add a[0] and a[1] , 4 times in a row .

template ForLoop() {
    signal input a[2];
    signal output c;

    var acc = 0;
    for(var i = 0; i < 4; i++) {
        acc += a[0] + a[1];
    }

    c <== acc;

}  

component main {public [a]} = ForLoop();

/*
[INFO]  snarkJS: [  ] * [  ] - [ 21888242871839275222246405745257275088548364400416034343698204186575808495616main.c +4main.a[0] +4main.a[1] ] = 0
*/