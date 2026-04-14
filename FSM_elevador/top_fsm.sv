module top_fsm(
    input  logic       clk,
    input  logic       SW,
    output logic [9:0] LEDR
);

    logic tick_3s;

    logic [2:0] state_reg;
    logic [2:0] next_state;

    logic dir_out;
    logic dir_load;

    logic op_out;
    logic op_load;

    logic [3:0] piso_nuevo_reg;
    logic piso_nuevo_load;
    logic [3:0] piso_shift;

    logic [3:0] piso_anterior_reg;
    logic piso_anterior_load;

    logic [2:0] cont_bits;
    logic cont_enable;
    logic cont_clear;
    logic cont_fin;

    divisor_3s U_DIV (
        .clk(clk),
        .tick_3s(tick_3s)
    );

    assign cont_fin = cont_bits[2] & (~cont_bits[1]) & (~cont_bits[0]);

    assign dir_load = tick_3s &
                      (~state_reg[2]) &
                      (~state_reg[1]) &
                      ( state_reg[0]);

    assign piso_nuevo_load = tick_3s &
                         (~next_state[2]) &
                         ( next_state[1]) &
                         (~next_state[0]) &
                         (~cont_fin);

    assign cont_enable = tick_3s &
                         (~state_reg[2]) &
                         ( state_reg[1]) &
                         (~state_reg[0]) &
                         (~cont_fin);

    assign cont_clear = tick_3s &
                        (~state_reg[2]) &
                        (~state_reg[1]) &
                        (~state_reg[0]);

    assign op_load = tick_3s &
                     (~state_reg[2]) &
                     ( state_reg[1]) &
                     ( state_reg[0]);

    assign piso_anterior_load = tick_3s &
                                ( state_reg[2]) &
                                (~state_reg[1]) &
                                (~state_reg[0]) &
                                SW;

    next_state_logic U_NEXT (
        .state_reg(state_reg),
        .SW(SW),
        .cont_fin(cont_fin),
        .next_state(next_state)
    );

    estado_reg_en U_ESTADO (
        .clk(clk),
        .enable(tick_3s),
        .d(next_state),
        .q(state_reg)
    );

    dir_reg U_DIR (
        .clk(clk),
        .enable(dir_load),
        .dir_in(SW),
        .dir_out(dir_out)
    );

    dir_reg U_OP (
        .clk(clk),
        .enable(op_load),
        .dir_in(SW),
        .dir_out(op_out)
    );

    assign piso_shift[3] = piso_nuevo_reg[2];
    assign piso_shift[2] = piso_nuevo_reg[1];
    assign piso_shift[1] = piso_nuevo_reg[0];
    assign piso_shift[0] = SW;

    registro_piso U_PISO_NUEVO (
        .clk(clk),
        .enable(piso_nuevo_load),
        .nuevo_piso(piso_shift),
        .piso_actual(piso_nuevo_reg)
    );

    registro_piso U_PISO_ANTERIOR (
        .clk(clk),
        .enable(piso_anterior_load),
        .nuevo_piso(piso_nuevo_reg),
        .piso_actual(piso_anterior_reg)
    );

    contador_3bits U_CONT (
        .clk(clk),
        .enable(cont_enable),
        .clear(cont_clear),
        .q(cont_bits)
    );

    assign LEDR[9] = state_reg[2];
    assign LEDR[8] = state_reg[1];
    assign LEDR[7] = state_reg[0];

    assign LEDR[6] = piso_nuevo_reg[3];
    assign LEDR[5] = piso_nuevo_reg[2];
    assign LEDR[4] = piso_nuevo_reg[1];
    assign LEDR[3] = piso_nuevo_reg[0];

    assign LEDR[2] = dir_out;
    assign LEDR[1] = op_out;

    // Validación estado 100
    assign LEDR[0] = state_reg[2] & (~state_reg[1]) & (~state_reg[0]);

endmodule