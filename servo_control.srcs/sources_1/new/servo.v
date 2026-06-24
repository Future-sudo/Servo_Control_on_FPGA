`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2026 10:57:33 AM
// Design Name: 
// Module Name: servo
// Project Name: 
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


module servo#(parameter count=2000000)(input clk, rst, 
                input [7:0] angle, 
                output servo_sig, RGB1
    );
    
reg [20:0] counter;
reg [20:0] pulse;
    
always @(posedge clk) begin
    if(rst) begin
        counter<=20'b0; 
    end
    else if(counter==(count-1)) begin
        counter<=20'b0;
    end
    else begin 
        counter<=counter+1'b1;
    end
end

always @(posedge clk) begin
    pulse<=100000+(angle*10000/18);
end


assign servo_sig=(counter<pulse);
assign RGB1=servo_sig;
    
endmodule




//module servo #(
//    parameter CLK_FREQ = 100_000_000,   // 100 MHz clock
//    parameter PWM_FREQ = 50             // 50 Hz servo frequency
//)(
//    input clk,
//    input rst,
//    input [7:0] angle,                  // 0 to 180 degrees
//    output servo_sig,
//    output RGB1
//);

//    // 20 ms period for servo PWM
//    localparam PERIOD_COUNT = CLK_FREQ / PWM_FREQ;

//    // 1 ms to 2 ms pulse width
//    localparam MIN_PULSE = CLK_FREQ / 1000;       // 1 ms
//    localparam MAX_PULSE = CLK_FREQ / 500;        // 2 ms

//    reg [20:0] counter = 0;
//    reg [20:0] pulse_width = 0;

//    // Counter for PWM period
//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            counter <= 0;
//        else if (counter >= PERIOD_COUNT - 1)
//            counter <= 0;
//        else
//            counter <= counter + 1;
//    end

//    // Convert angle (0–180) to pulse width
//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            pulse_width <= MIN_PULSE;
//        else begin
//            if (angle > 180)
//                pulse_width <= MAX_PULSE;
//            else
//                pulse_width <= MIN_PULSE +
//                               ((angle * (MAX_PULSE - MIN_PULSE)) / 180);
//        end
//    end

//    // PWM output
//    assign servo_sig = (counter < pulse_width) ? 1'b1 : 1'b0;

//    // Debug LED output
//    assign RGB1 = servo_sig;

//endmodule
