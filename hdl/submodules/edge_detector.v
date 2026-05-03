module edge_detector (
    input  wire clk,
    input  wire signal_in,
    output wire rising_edge
);

reg signal_d = 0;

always @(posedge clk) begin
    signal_d <= signal_in;
end

assign rising_edge = signal_in & ~signal_d;

endmodule
