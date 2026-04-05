/*
 * Autor       : José Solano
 * Proyecto    : Testbench para el módulo top_pwm
 * Descripción : Simulación de PWM y HEX0 con tareas de verificación automática.
 * Entradas    : clk (50MHz), rst_n, sw[3:0].
 * Salidas     : pwm_out, hex_out.
 */

`timescale 1ns/1ps

module tb_top_pwm;

    // ── Señales del DUT ────────────────────────────────────────
    logic        clk, rst_n;
    logic [3:0]  sw;
    logic        pwm_out;
    logic [6:0]  hex_out;

    // ── Instancia del DUT ──────────────────────────────────────
    top_pwm dut (
        .CLOCK_50 (clk    ),
        .KEY0     (rst_n  ),
        .SW       (sw     ),
        .LEDR0    (pwm_out),
        .HEX0     (hex_out)
    );

    // ── Generador de reloj: 50 MHz → T = 20 ns ─────────────────
    initial clk = 1'b0;
    always #10 clk = ~clk;

    // ── Tarea: medir duty cycle en 1 período PWM (16 ciclos) ───
    task automatic check_duty (
        input [3:0]  sw_val,
        input integer expected_pct
    );
        integer high_count, i, actual_pct;
        high_count = 0;

        sw = sw_val;
        // esperar que el contador se estabilice (2 períodos)
        @(posedge clk); @(posedge clk);

        // medir durante 1 período completo (16 ciclos)
        for (i = 0; i < 16; i++) begin
            @(posedge clk);
            if (pwm_out) high_count++;
        end

        actual_pct = high_count * 100 / 16;

        if (actual_pct === expected_pct)
            $display("  PASS  SW=%0d | PWM duty = %0d%% (esperado %0d%%)",
                     sw_val, actual_pct, expected_pct);
        else
            $display("  FAIL  SW=%0d | PWM duty = %0d%% (esperado %0d%%)",
                     sw_val, actual_pct, expected_pct);
    endtask

    // ── Tarea: verificar decodificador HEX ─────────────────────
    task automatic check_hex (
        input [3:0] sw_val,
        input [6:0] expected_seg
    );
        sw = sw_val;
        #5; // lógica combinacional: sin espera de reloj
        if (hex_out === expected_seg)
            $display("  PASS  HEX SW=%0h | seg=7'b%b", sw_val, hex_out);
        else
            $display("  FAIL  HEX SW=%0h | got=7'b%b  exp=7'b%b",
                     sw_val, hex_out, expected_seg);
    endtask

    // ── Bloque principal de estímulos ──────────────────────────
    initial begin
        $display("\n=== INICIO TESTBENCH PWM ===");

        // 1. Reset asíncrono
        $display("\n-- Test 1: Reset --");
        rst_n = 1'b0; sw = 4'h0;
        #35; // mantener reset 35 ns (>1 ciclo de reloj)
        if (pwm_out === 1'b0)
            $display("  PASS  PWM = 0 durante reset");
        else
            $display("  FAIL  PWM debe ser 0 durante reset");
        rst_n = 1'b1;
        #20;

        // 2. Duty cycle por nivel
        $display("\n-- Test 2: Duty cycle por nivel --");
        check_duty(4'd0,   0);  //   0 %
        check_duty(4'd1,  25);  //  25 %
        check_duty(4'd2,  50);  //  50 %
        check_duty(4'd3,  75);  //  75 %
        check_duty(4'd4,  75);  //  75 %
        check_duty(4'd5, 100);  // 100 % (force_on)
        check_duty(4'd9, 100);  // 100 % (force_on)
        check_duty(4'd15,100);  // 100 % (force_on)

        // 3. Transiciones entre niveles
        $display("\n-- Test 3: Transiciones --");
        check_duty(4'd0,   0);
        check_duty(4'd5, 100);
        check_duty(4'd2,  50);
        check_duty(4'd0,   0);

        // 4. Decodificador HEX (casos representativos)
        $display("\n-- Test 4: HEX decoder --");
        check_hex(4'h0, 7'b1000000); // 0
        check_hex(4'h5, 7'b0010010); // 5
        check_hex(4'ha, 7'b0001000); // A
        check_hex(4'hf, 7'b0001110); // F

        $display("\n=== FIN TESTBENCH ===");
        $stop;
    end

    // ── Timeout de seguridad ───────────────────────────────────
    initial begin
        #200_000;
        $display("TIMEOUT — simulación detenida");
        $stop;
    end

endmodule: tb_top_pwm