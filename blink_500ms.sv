module blink_500ms (
    input logic clk,
    input logic reset,
    output logic blink
);

    parameter COUNT_MAX = 50000000; // 50e6 cycles for 500ms at 100MHz
    logic [25:0] count; // 26 bits for 50e6

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            blink <= 0;
        end else begin
            if (count == COUNT_MAX - 1) begin
                count <= 0;
                blink <= ~blink;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule