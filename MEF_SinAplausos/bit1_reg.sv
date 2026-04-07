module bit1_reg (
    input  logic clk,
    input  logic bit_in,
    output logic bit_out
);

    always_ff @(posedge clk) begin
        bit_out <= bit_in;
    end

endmodule