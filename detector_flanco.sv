module detector_flanco (
    input logic clk,
    input logic reset,
    input logic pulso_in,
    output logic pulso_out
);

    logic pulso_prev;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pulso_prev <= 1'b0;
        else
            pulso_prev <= pulso_in;
    end

    assign pulso_out = pulso_in & ~pulso_prev;

endmodule