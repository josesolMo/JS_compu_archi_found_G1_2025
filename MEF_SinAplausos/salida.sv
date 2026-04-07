module salida (
    input  logic S1,
    input  logic S0,
    input  logic dir,
    input  logic cont1,
    input  logic cont0,
    output logic E,
    output logic D,
    output logic V,
    output logic C
);

    assign E = S0;
    assign D = S0 & dir;
    assign V = S1 & S0;
    assign C = S1 & cont1 & cont0;

endmodule