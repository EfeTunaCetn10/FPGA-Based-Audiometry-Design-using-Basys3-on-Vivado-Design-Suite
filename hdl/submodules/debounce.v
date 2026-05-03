module debounce #(
    parameter integer CLK_FREQ_HZ = 100_000_000,
    parameter integer DEBOUNCE_MS = 20
)(
    input  wire clk,
    input  wire noisy_btn,
    output reg  clean_btn = 0
);

localparam integer COUNT_MAX = (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

reg [$clog2(COUNT_MAX):0] counter = 0;
reg btn_sync_0 = 0;
reg btn_sync_1 = 0;
reg btn_state  = 0;

always @(posedge clk) begin
    btn_sync_0 <= noisy_btn;
    btn_sync_1 <= btn_sync_0;

    if (btn_sync_1 != btn_state) begin
        if (counter >= COUNT_MAX) begin
            btn_state <= btn_sync_1;
            clean_btn <= btn_sync_1;
            counter   <= 0;
        end else begin
            counter <= counter + 1;
        end
    end else begin
        counter <= 0;
    end
end

endmodule
