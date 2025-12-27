module rocket_controller(
    input wire sysclk,       // 12 MHz System Clock
    input wire btn1,         // Start Button (Active Low)
    input wire btn2,         // Reset Button (Active Low)
    output reg led_launch,   // Launch LED
    output reg [6:0] seg     // 7-Segment Display
    );

    // ==========================================
    // 1. Input Inversion (Active Low Fix)
    // ==========================================
    // The buttons now connect to GND.
    // Pressed = 0, Released = 1 (due to Pull-Up).
    // We invert them here so the rest of the logic sees "1" as Pressed.
    wire b1_inv = ~btn1;
    wire b2_inv = ~btn2;

    // ==========================================
    // 2. Clock Generation
    // ==========================================
    reg [23:0] counter_1hz = 0;
    reg pulse_1hz = 0;
   
    always @(posedge sysclk) begin
        if (counter_1hz >= 11999999) begin
            counter_1hz <= 0;
            pulse_1hz <= 1;
        end else begin
            counter_1hz <= counter_1hz + 1;
            pulse_1hz <= 0;
        end
    end

    // ==========================================
    // 3. Input Debouncing
    // ==========================================
    reg b1_clean, b2_clean;
    reg [17:0] debounce_cnt_1 = 0;
    reg [17:0] debounce_cnt_2 = 0;
    reg b1_sync_0, b1_sync_1;
    reg b2_sync_0, b2_sync_1;

    always @(posedge sysclk) begin
        // Sync the INVERTED signals
        b1_sync_0 <= b1_inv; b1_sync_1 <= b1_sync_0;
        b2_sync_0 <= b2_inv; b2_sync_1 <= b2_sync_0;

        if (b1_sync_1 == b1_clean) debounce_cnt_1 <= 0;
        else begin
            debounce_cnt_1 <= debounce_cnt_1 + 1;
            if (debounce_cnt_1 == 250000) b1_clean <= b1_sync_1;
        end

        if (b2_sync_1 == b2_clean) debounce_cnt_2 <= 0;
        else begin
            debounce_cnt_2 <= debounce_cnt_2 + 1;
            if (debounce_cnt_2 == 250000) b2_clean <= b2_sync_1;
        end
    end

    reg b1_prev, b2_prev;
    wire b1_pressed, b2_pressed;
    always @(posedge sysclk) begin
        b1_prev <= b1_clean;
        b2_prev <= b2_clean;
    end
    assign b1_pressed = (b1_clean && !b1_prev);
    assign b2_pressed = (b2_clean && !b2_prev);

    // ==========================================
    // 4. State Machine
    // ==========================================
    localparam S_INIT   = 2'b00;
    localparam S_COUNT  = 2'b01;
    localparam S_LAUNCH = 2'b10;

    reg [1:0] current_state = S_INIT;
    reg [3:0] count_val = 9;

    always @(posedge sysclk) begin
        if (b2_pressed) begin
            current_state <= S_INIT;
            count_val <= 9;
            led_launch <= 0;
        end
        else begin
            case (current_state)
                S_INIT: begin
                    led_launch <= 0;
                    count_val <= 9;
                    if (b1_pressed) current_state <= S_COUNT;
                end
                S_COUNT: begin
                    led_launch <= 0;
                    if (pulse_1hz) begin
                        if (count_val == 0) current_state <= S_LAUNCH;
                        else count_val <= count_val - 1;
                    end
                end
                S_LAUNCH: begin
                    count_val <= 0;
                    led_launch <= 1;
                end
            endcase
        end
    end

    // ==========================================
    // 5. 7-Segment Decoder
    // ==========================================
    always @(*) begin
        case(count_val)
            4'd0:    seg = 7'b0111111;
            4'd1:    seg = 7'b0000110;
            4'd2:    seg = 7'b1011011;
            4'd3:    seg = 7'b1001111;
            4'd4:    seg = 7'b1100110;
            4'd5:    seg = 7'b1101101;
            4'd6:    seg = 7'b1111101;
            4'd7:    seg = 7'b0000111;
            4'd8:    seg = 7'b1111111;
            4'd9:    seg = 7'b1101111;
            default: seg = 7'b0000000;
        endcase
    end
endmodule