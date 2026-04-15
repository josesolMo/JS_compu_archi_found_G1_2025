module divisor_50ms(
    input  logic clk,
    output logic tick_50ms
);

    logic [22:0] cuenta_actual;
    logic [22:0] siguiente_cuenta;
    logic [22:0] suma_uno;
    logic reset_contador;

    genvar i;
    generate
        for (i = 0; i < 23; i = i + 1) begin : reg_contador
            dff1 bit_inst (
                .clk(clk),
                .d(siguiente_cuenta[i]),
                .q(cuenta_actual[i])
            );
        end
    endgenerate

    assign suma_uno         = cuenta_actual + 23'd1;
    assign reset_contador   = (cuenta_actual == 23'd2_499_999);
    assign siguiente_cuenta = reset_contador ? 23'd0 : suma_uno;

    assign tick_50ms = reset_contador;

endmodule