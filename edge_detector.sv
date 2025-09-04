module edge_detector (
    input logic clk_i,
    input logic rstn_i,
    input logic signal_i,
    output logic rising_o,
    output logic falling_o
);

    logic signal_prev;

    always_ff @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            signal_prev <= 0;
        end else begin
            signal_prev <= signal_i;
        end
    end

    assign rising_o = signal_i && !signal_prev;
    assign falling_o = !signal_i && signal_prev;

endmodule