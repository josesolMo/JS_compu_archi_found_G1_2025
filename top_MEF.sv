module top_MEF (
    input  logic clk,
    input  logic reset,
    input  logic OK,
    input  logic SW,
    output logic dir,
    output logic ready,
    output logic [3:0] piso,
    output logic [2:0] cont
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S0 = 3'b001,
        S1 = 3'b010,
        S2 = 3'b011,
        S3 = 3'b100
    } estado_MEF;

    estado_MEF estado_actual, siguiente_estado;

    logic registro_en;
    logic cont_en;
    logic cont_reset;
    logic pulso_ok;

    // Instancias
    detector_flanco inst_detector_flanco (
        .clk(clk),
        .reset(reset),
        .pulso_in(~OK),
        .pulso_out(pulso_ok)
    );

    registro_piso inst_registro_piso (
        .clk(clk),
        .reset(reset),
        .registro_en(registro_en),
        .SW(SW),
        .piso(piso)
    );

    contador_bits inst_contador_bits (
        .clk(clk),
        .reset(reset),
        .cont_en(cont_en),
        .cont_reset(cont_reset),
        .cont(cont)
    );

    // Registro de estado actual
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            estado_actual <= IDLE;
        else
            estado_actual <= siguiente_estado;
    end

    // Transición entre estados
    always_comb begin
        siguiente_estado = estado_actual;

        case (estado_actual)

            IDLE: begin
                if (pulso_ok)
                    siguiente_estado = S0;
            end

            S0: begin
                if (pulso_ok)
                    siguiente_estado = S1;
            end

            S1: begin
                if (pulso_ok)
                    siguiente_estado = S2;
            end

            S2: begin
                if (pulso_ok && cont < 3)
                    siguiente_estado = S2;
                else if (pulso_ok && cont == 3)
                    siguiente_estado = S3;
            end

            S3: begin
                if (pulso_ok)
                    siguiente_estado = IDLE;
            end

        endcase
    end

    // Lógica de salidas 
    always_comb begin
        registro_en = 1'b0;
        cont_en = 1'b0;
        cont_reset = 1'b0;
        ready = 1'b0;

        case (estado_actual)

            IDLE: begin
                cont_reset = 1'b1;
            end

            S2: begin
                if (pulso_ok) begin
                    registro_en = 1'b1;
                    cont_en = 1'b1;
                end
            end

            S3: begin
                ready = 1'b1;
            end

        endcase
    end

    // Registro de dirección
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            dir <= 1'b0;
        else if (estado_actual == S1 && pulso_ok)
            dir <= SW;
    end

endmodule