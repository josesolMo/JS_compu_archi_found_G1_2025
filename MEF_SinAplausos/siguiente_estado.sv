module siguiente_estado (
    input  logic S1,
    input  logic S0,
    input  logic OK_pulse,
    input  logic C,
    output logic next_S1,
    output logic next_S0
);

    assign next_S1 = (~S1 &  S0) |
                     ( S1 & ~S0) |
                     ( S1 &  S0 & ~OK_pulse);

    assign next_S0 = (~S1 & ~S0 &  OK_pulse) |
                     (~S1 &  S0 & ~OK_pulse) |
                     ( S1 & ~S0 &  OK_pulse & C) |
                     ( S1 &  S0 & ~OK_pulse);

endmodule