module bit1_reg (
    input  logic clk,
    input  logic RESET,
    input  logic bit_in,
    output logic bit_out
);

    always_ff @(negedge clk or posedge RESET) begin
        if (RESET)
            bit_out <= 1'b0;
        else
            bit_out <= bit_in;
    end

endmodule