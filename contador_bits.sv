module contador_bits (
    input  logic clk,
    input  logic reset,
    input  logic cont_en,
    input  logic cont_reset,
    output logic [2:0] cont
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            cont <= 3'd0;
        else if (cont_reset)
            cont <= 3'd0;
        else if (cont_en)
            cont <= cont + 3'd1;
    end

endmodule