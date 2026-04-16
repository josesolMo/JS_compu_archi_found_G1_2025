module alu_core(
    input  logic [3:0] piso_actual,
    input  logic [3:0] cantidad,
    input  logic       op,
    output logic [3:0] resultado,
    output logic       sat,
    output logic       c_out
);

    logic [3:0] s_int;
    logic [3:0] sat_val;

    addsub_4bits SUM(
        .A   (piso_actual),
        .B   (cantidad),
        .op  (op),
        .S   (s_int),
        .Cout(c_out)
    );

    assign sat = ~(op ^ c_out);
    assign sat_val = {op, op, op, op};

    mux2_4bits MUX(
        .a  (s_int),
        .b  (sat_val),
        .sel(sat),
        .y  (resultado)
    );

endmodule