module comparador_eq_4bits(
    input  logic [3:0] A,
    input  logic [3:0] B,
    output logic       eq
);

    logic e0, e1, e2, e3;

    assign e0 = ~(A[0] ^ B[0]);
    assign e1 = ~(A[1] ^ B[1]);
    assign e2 = ~(A[2] ^ B[2]);
    assign e3 = ~(A[3] ^ B[3]);

    assign eq = e0 & e1 & e2 & e3;

endmodule