module siguiente_estado (
    input  logic S1,
    input  logic S0,
    input  logic C,
    output logic next_S1,
    output logic next_S0
);

    assign next_S1 = (~S1 & S0) |
                     ( S1 & ~S0);

    assign next_S0 = (~S1 & ~S0) |
                     ( S1 & ~S0 & C);

endmodule