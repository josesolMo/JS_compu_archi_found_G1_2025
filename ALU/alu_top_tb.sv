`timescale 1ns/1ps

module alu_top_tb;

    logic clk;
    logic enable;
    logic op;
    logic [3:0] cantidad;

    logic [3:0] piso_actual;
    logic [3:0] piso_destino;
    logic [3:0] distancia;
    logic sat;
    logic c_out;

    // Instancia del DUT (Device Under Test)
    alu_top DUT (
        .clk(clk),
        .enable(enable),
        .op(op),
        .cantidad(cantidad),
        .piso_actual(piso_actual),
        .piso_destino(piso_destino),
        .distancia(distancia),
        .sat(sat),
        .c_out(c_out)
    );

    // Generación de reloj: periodo de 20 ns
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        // Valores iniciales
        enable   = 0;
        op       = 1'b1;
        cantidad = 4'b0000;

        // Esperar un poco al inicio
        #25;

        // =========================
        // CASO 1: 0 + 3 = 3
        // =========================
        op       = 1'b1;      // suma
        cantidad = 4'b0011;   // 3
        enable   = 1'b1;
        #20;                  // un ciclo de reloj
        enable   = 1'b0;
        #20;

        // =========================
        // CASO 2: 3 + 5 = 8
        // =========================
        op       = 1'b1;      // suma
        cantidad = 4'b0101;   // 5
        enable   = 1'b1;
        #20;
        enable   = 1'b0;
        #20;

        // =========================
        // CASO 3: 8 - 2 = 6
        // =========================
        op       = 1'b0;      // resta
        cantidad = 4'b0010;   // 2
        enable   = 1'b1;
        #20;
        enable   = 1'b0;
        #20;

        // =========================
        // CASO 4: 6 + 10 = 15 (saturación)
        // =========================
        op       = 1'b1;      // suma
        cantidad = 4'b1010;   // 10
        enable   = 1'b1;
        #20;
        enable   = 1'b0;
        #20;

        // =========================
        // CASO 5: 15 - 4 = 11
        // =========================
        op       = 1'b0;      // resta
        cantidad = 4'b0100;   // 4
        enable   = 1'b1;
        #20;
        enable   = 1'b0;
        #20;

        // =========================
        // CASO 6: 11 - 15 = 0 (saturación)
        // =========================
        op       = 1'b0;      // resta
        cantidad = 4'b1111;   // 15
        enable   = 1'b1;
        #20;
        enable   = 1'b0;
        #20;

        // Fin de simulación
        $stop;
    end

endmodule