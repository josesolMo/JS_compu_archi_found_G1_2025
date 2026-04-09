module comparador_ge_4bits(
    input  logic [3:0] A,
    input  logic [3:0] B,
    output logic       ge
);

    logic eq3, eq2, eq1;
    logic gt3, gt2, gt1;
    logic ge0;

    assign eq3 = ~(A[3] ^ B[3]);
    assign eq2 = ~(A[2] ^ B[2]);
    assign eq1 = ~(A[1] ^ B[1]);

    assign gt3 =  A[3] & ~B[3];
    assign gt2 =  A[2] & ~B[2];
    assign gt1 =  A[1] & ~B[1];

    assign ge0 = A[0] | ~B[0];

    assign ge = gt3 |
               (eq3 & gt2) |
               (eq3 & eq2 & gt1) |
               (eq3 & eq2 & eq1 & ge0);

endmodule