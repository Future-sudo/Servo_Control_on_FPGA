`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2026 10:57:33 AM
// Design Name: Servo Control
// Module Name: servo
// Project Name: Servo Control With FPGA
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module servo #(
    parameter CLK_FREQ = 100_000_000,   // 100 MHz clock frequency
    parameter PWM_FREQ = 50             // 50 Hz servo refresh rate
)(
    input wire clk,
    input wire rst,
    input wire [7:0] angle,             // 0 to 180 degrees
    output wire servo_sig,
    output wire RGB1                    // Debug LED output
);

    // Calculate period count (20ms for 50Hz)
    localparam PERIOD_COUNT = CLK_FREQ / PWM_FREQ;
    
    // Pulse width range: 1ms to 2ms
    localparam MIN_PULSE = CLK_FREQ / 1000;      // 1ms pulse
    localparam MAX_PULSE = CLK_FREQ / 500;       // 2ms pulse
    
    // Width calculation for pulse range
    localparam PULSE_RANGE = MAX_PULSE - MIN_PULSE;
    
    // Internal registers
    reg [20:0] counter;
    reg [20:0] pulse_width;

    // PWM period counter
    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
        end else begin
            if (counter >= PERIOD_COUNT - 1)
                counter <= 0;
            else
                counter <= counter + 1'b1;
        end
    end

    // Pulse width calculation based on angle
    always @(posedge clk) begin
        if (rst) begin
            pulse_width <= MIN_PULSE;
        end else begin
            // Clamp angle to valid range (0-180)
            if (angle > 180)
                pulse_width <= MAX_PULSE;
            else
                pulse_width <= MIN_PULSE + (angle * PULSE_RANGE / 180);
        end
    end

    // Generate PWM output signal
    assign servo_sig = (counter < pulse_width) ? 1'b1 : 1'b0;
    
    // Debug output (same as servo signal)
    assign RGB1 = servo_sig;

endmodule
