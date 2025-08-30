module clock_divider (
    input  logic clk_100MHz,
    input  logic rstn,
    output logic clk_out
);
    logic [26:0] counter;

    always_ff @(posedge clk_100MHz or negedge rstn) begin
        if (!rstn) begin
            counter <= 27'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter == 27'd49_999_999) begin  // 50.000.000 - 1
                counter <= 27'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 27'd1;
            end
        end
    end

endmodule
