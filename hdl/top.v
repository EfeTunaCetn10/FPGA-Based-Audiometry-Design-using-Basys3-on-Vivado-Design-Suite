module top (
    input  wire clk,
    input  wire btnC,
    output wire led0,
    output wire led1,
    output wire tx
);

wire clean_btn;
wire btn_pulse;

wire tx_start;
wire [7:0] tx_data;
wire tx_busy;
wire tx_done;
wire sending;

debounce debounce_inst (
    .clk(clk),
    .noisy_btn(btnC),
    .clean_btn(clean_btn)
);

edge_detector edge_detector_inst (
    .clk(clk),
    .signal_in(clean_btn),
    .rising_edge(btn_pulse)
);

response_sender response_sender_inst (
    .clk(clk),
    .send_trigger(btn_pulse),
    .tx_busy(tx_busy),
    .tx_done(tx_done),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .sending(sending)
);

uart_tx #(
    .CLK_FREQ_HZ(100_000_000),
    .BAUD_RATE(115200)
) uart_tx_inst (
    .clk(clk),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy),
    .tx_done(tx_done)
);
assign led0 = clean_btn;
assign led1 = sending;

endmodule
