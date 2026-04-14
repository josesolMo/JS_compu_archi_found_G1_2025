module mux2_1bit(
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);

    assign y = (~sel & a) | (sel & b);

endmodule