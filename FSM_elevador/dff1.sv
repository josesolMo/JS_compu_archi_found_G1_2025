module dff1(
    input  logic clk,
    input  logic d,
    output logic q
);

    initial q = 1'b0;

    always @(posedge clk) begin
        q <= d;
    end

endmodule