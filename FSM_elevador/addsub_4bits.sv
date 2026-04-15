module addsub_4bits(
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic       op,
    output logic [3:0] S,
    output logic       Cout
);

    logic [3:0] B_mod;
    logic c1, c2, c3;

    assign B_mod[0] = B[0] ^ (~op);
    assign B_mod[1] = B[1] ^ (~op);
    assign B_mod[2] = B[2] ^ (~op);
    assign B_mod[3] = B[3] ^ (~op);

    full_adder FA0(
        .A(A[0]),
        .B(B_mod[0]),
        .Cin(~op),
        .S(S[0]),
        .Cout(c1)
    );

    full_adder FA1(
        .A(A[1]),
        .B(B_mod[1]),
        .Cin(c1),
        .S(S[1]),
        .Cout(c2)
    );

    full_adder FA2(
        .A(A[2]),
        .B(B_mod[2]),
        .Cin(c2),
        .S(S[2]),
        .Cout(c3)
    );

    full_adder FA3(
        .A(A[3]),
        .B(B_mod[3]),
        .Cin(c3),
        .S(S[3]),
        .Cout(Cout)
    );

endmodule