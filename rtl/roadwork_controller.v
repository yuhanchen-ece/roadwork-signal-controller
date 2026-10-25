module roadwork_controller #(
    parameter A_GO_CYCLES = 5,
    parameter B_GO_CYCLES = 7,
    parameter CLEAR_CYCLES = 2
)(
    input  wire clk,
    input  wire reset,
    output reg  a_go,
    output reg  a_stop,
    output reg  b_go,
    output reg  b_stop
);
    localparam A_go = 0, A_to_B = 1, B_go = 2, B_to_A = 3;
    reg[2:0] state, next_state;
    reg[31:0] phase_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= B_to_A;
            phase_count <= 32'b0;
        end else begin
            if (next_state != state) begin
                phase_count <= 0;
            end else begin
                phase_count <= phase_count + 1'b1;
            end
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        if (state == A_go) begin
            if (phase_count + 1'b1 == A_GO_CYCLES) begin
                next_state = A_to_B;
            end
        end else if (state == A_to_B) begin
            if (phase_count + 1'b1 == CLEAR_CYCLES) begin
                next_state = B_go;
            end
        end else if (state == B_go) begin
            if (phase_count + 1'b1 == B_GO_CYCLES) begin
                next_state = B_to_A;
            end
        end else if (state == B_to_A) begin
            if (phase_count + 1'b1 == CLEAR_CYCLES) begin
                next_state = A_go;
            end
        end
    end

    assign a_go = (state == A_go);
    assign a_stop = (state != A_go);
    assign b_go = (state == B_go);
    assign b_stop = (state != B_go);
endmodule