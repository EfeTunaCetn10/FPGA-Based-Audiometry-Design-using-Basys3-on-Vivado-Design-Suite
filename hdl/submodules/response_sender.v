module response_sender (
    input  wire clk,
    input  wire send_trigger,
    input  wire tx_busy,
    input  wire tx_done,
    output reg  tx_start = 0,
    output reg [7:0] tx_data = 8'd0,
    output reg  sending = 0
);

localparam integer MSG_LEN = 9;

reg [3:0] index = 0;

localparam [1:0]
    IDLE      = 2'd0,
    LOAD_BYTE = 2'd1,
    WAIT_DONE = 2'd2,
    FINISH    = 2'd3;

reg [1:0] state = IDLE;

always @(*) begin
    case (index)
        4'd0: tx_data = "R";
        4'd1: tx_data = "E";
        4'd2: tx_data = "S";
        4'd3: tx_data = "P";
        4'd4: tx_data = "O";
        4'd5: tx_data = "N";
        4'd6: tx_data = "S";
        4'd7: tx_data = "E";
        4'd8: tx_data = 8'h0A; // newline: \n
        default: tx_data = 8'h0A;
    endcase
end

always @(posedge clk) begin
    tx_start <= 1'b0;

    case (state)

        IDLE: begin
            sending <= 1'b0;
            index <= 0;

            if (send_trigger) begin
                sending <= 1'b1;
                state <= LOAD_BYTE;
            end
        end

        LOAD_BYTE: begin
            sending <= 1'b1;

            if (!tx_busy) begin
                tx_start <= 1'b1;
                state <= WAIT_DONE;
            end
        end

        WAIT_DONE: begin
            sending <= 1'b1;

            if (tx_done) begin
                if (index < MSG_LEN - 1) begin
                    index <= index + 1;
                    state <= LOAD_BYTE;
                end else begin
                    state <= FINISH;
                end
            end
        end

        FINISH: begin
            sending <= 1'b0;
            state <= IDLE;
        end

        default: begin
            state <= IDLE;
        end

    endcase
end

endmodule
