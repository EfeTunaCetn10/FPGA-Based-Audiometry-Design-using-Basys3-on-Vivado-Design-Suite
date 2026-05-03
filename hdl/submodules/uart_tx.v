module uart_tx #(
    parameter integer CLK_FREQ_HZ = 100_000_000,
    parameter integer BAUD_RATE   = 115200
)(
    input  wire       clk,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output reg        tx = 1'b1,
    output reg        tx_busy = 1'b0,
    output reg        tx_done = 1'b0
);

localparam integer CLKS_PER_BIT = CLK_FREQ_HZ / BAUD_RATE;

localparam [2:0]
    IDLE       = 3'd0,
    START_BIT  = 3'd1,
    DATA_BITS  = 3'd2,
    STOP_BIT   = 3'd3,
    CLEANUP    = 3'd4;

reg [2:0] state = IDLE;
reg [$clog2(CLKS_PER_BIT):0] clk_count = 0;
reg [2:0] bit_index = 0;
reg [7:0] data_reg = 8'd0;

always @(posedge clk) begin
    tx_done <= 1'b0;

    case (state)

        IDLE: begin
            tx <= 1'b1;
            tx_busy <= 1'b0;
            clk_count <= 0;
            bit_index <= 0;

            if (tx_start) begin
                tx_busy <= 1'b1;
                data_reg <= tx_data;
                state <= START_BIT;
            end
        end

        START_BIT: begin
            tx <= 1'b0;

            if (clk_count < CLKS_PER_BIT - 1) begin
                clk_count <= clk_count + 1;
            end else begin
                clk_count <= 0;
                state <= DATA_BITS;
            end
        end

        DATA_BITS: begin
            tx <= data_reg[bit_index];

            if (clk_count < CLKS_PER_BIT - 1) begin
                clk_count <= clk_count + 1;
            end else begin
                clk_count <= 0;

                if (bit_index < 7) begin
                    bit_index <= bit_index + 1;
                end else begin
                    bit_index <= 0;
                    state <= STOP_BIT;
                end
            end
        end

        STOP_BIT: begin
            tx <= 1'b1;

            if (clk_count < CLKS_PER_BIT - 1) begin
                clk_count <= clk_count + 1;
            end else begin
                clk_count <= 0;
                state <= CLEANUP;
            end
        end

        CLEANUP: begin
            tx_busy <= 1'b0;
            tx_done <= 1'b1;
            state <= IDLE;
        end

        default: begin
            state <= IDLE;
        end

    endcase
end

endmodule
