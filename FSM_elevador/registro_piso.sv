module registro_piso(
    input  logic       clk,
    input  logic       enable,
    input  logic [3:0] nuevo_piso,
    output logic [3:0] piso_actual
);

    logic [3:0] d_in;

    mux2_4bits U_MUX_REG(
        .a  (piso_actual),
        .b  (nuevo_piso),
        .sel(enable),
        .y  (d_in)
    );

    dff1 FF0(.clk(clk), .d(d_in[0]), .q(piso_actual[0]));
    dff1 FF1(.clk(clk), .d(d_in[1]), .q(piso_actual[1]));
    dff1 FF2(.clk(clk), .d(d_in[2]), .q(piso_actual[2]));
    dff1 FF3(.clk(clk), .d(d_in[3]), .q(piso_actual[3]));

endmodule