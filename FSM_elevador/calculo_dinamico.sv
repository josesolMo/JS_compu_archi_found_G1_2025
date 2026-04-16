module calculo_dinamico (
    input  logic        clk,
    input  logic        load,      // Carga valores iniciales (desde S0/S3)
    input  logic        en_step,   // Habilita un paso de cálculo (desde S1)
    input  logic        dir,       // 1: Sube, 0: Baja
    input  logic [3:0]  p_dest_in,
    input  logic [3:0]  p_act_in,
    input  logic [3:0]  dist_in,
    output logic [3:0]  p_act_out, // Va al HEX
    output logic [3:0]  dist_out   // Va al PWM y MEF
);

    // --- Señales Internas ---
    logic [3:0] next_piso, piso_calc;
    logic [3:0] next_dist, dist_calc;
    logic [3:0] piso_reg = 4'b0000;
	 logic [3:0] dist_reg = 4'b0000;
    logic       cout_p, cout_d;

    // --- LÓGICA PARA EL PISO ACTUAL ---

    // Sumador/Restador para el piso
    addsub_4bits calc_piso (
        .A    (piso_reg),
        .B    (4'b0001),
        .op   (dir), 
        .S    (piso_calc),
        .Cout (cout_p)
    );

    // Mux para decidir entre valor calculado o valor de carga 
    mux2_4bits mux_piso (
        .a   (piso_calc),
        .b   (p_act_in),
        .sel (load),
        .y   (next_piso)
    );

    // --- LÓGICA PARA LA DISTANCIA ---

    // Restador para la distancia 
    addsub_4bits calc_dist (
        .A    (dist_reg),
        .B    (4'b0001),
        .op   (1'b0), 
        .S    (dist_calc),
        .Cout (cout_d)
    );

    // 4. Mux para decidir entre distancia calculada o de carga 
    mux2_4bits mux_dist (
        .a   (dist_calc),
        .b   (dist_in),
        .sel (load),
        .y   (next_dist)
    );

    // --- REGISTROS DE ESTADO (MEMORIA) ---
    // Actualizan el valor solo si load=1 o si la MEF pide un paso (en_step)
    always_ff @(posedge clk) begin
        if (load || en_step) begin
            piso_reg <= next_piso;
            dist_reg <= next_dist;
        end
    end

    // Salidas continuas
    assign p_act_out = piso_reg;
    assign dist_out  = dist_reg;

endmodule