module divisor_3s(
    input  logic clk,
    output logic tick_3s
);

    logic [27:0] cuenta_actual;
    logic [27:0] siguiente_cuenta;
    logic [27:0] suma_uno;
    logic reset_contador;

    genvar i;
    generate
        for (i = 0; i < 28; i = i + 1) begin : reg_contador
            dff1 bit_inst (
                .clk(clk),
                .d(siguiente_cuenta[i]),
                .q(cuenta_actual[i])
            );
        end
    endgenerate

    assign suma_uno         = cuenta_actual + 28'd1;
    assign reset_contador   = (cuenta_actual == 28'd149_999_999);
    assign siguiente_cuenta = reset_contador ? 28'd0 : suma_uno;

    assign tick_3s = reset_contador;

endmodule