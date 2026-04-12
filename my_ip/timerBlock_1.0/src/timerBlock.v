`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2025 16:16:01
// Design Name: 
// Module Name: timerBlock
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

module timerBlock(
    input waveStartTrigger,
    input waveEndTrigger,
    input clock,
    input reset,
    input [1:0] currentPhase,
    output reg [31:0] measuredTime,
    output reg [31:0] measuredPulseWidth
    );
    
    reg [31:0] counter_value = 0;
    reg [31:0] pulse_width = 0;

    reg waveEnd_d;
    wire waveEnd_posedge =  waveEndTrigger & ~waveEnd_d;
    wire waveEnd_negedge = ~waveEndTrigger &  waveEnd_d;
    
    always @(posedge clock or negedge reset)
    begin
        if (!reset)
        begin
            counter_value      <= 0;
            pulse_width        <= 0;
            measuredTime       <= 0;
            measuredPulseWidth <= 0;
    
            waveEnd_d <= 0;
        end
        else
        begin
            // sample async input (required for edge detection)
            waveEnd_d <= waveEndTrigger;
    
            //---------------------------------------------------------
            // BLOCK 2: "negedge waveEndTrigger" effect
            //---------------------------------------------------------
            if (waveEnd_negedge)
            begin
                counter_value      <= 0;
                measuredTime       <= 0;
                measuredPulseWidth <= pulse_width * 1000;
            end
    
            //---------------------------------------------------------
            // BLOCK 3: "posedge waveEndTrigger" effect
            //---------------------------------------------------------
            else if (waveEnd_posedge)
            begin
                pulse_width        <= 0;
                measuredPulseWidth <= 0;
                measuredTime       <= counter_value * 1000;
                // This condition was impossible before and remains impossible:
                // waveStartTrigger && (~waveEndTrigger)
                // because waveEndTrigger is 1 at posedge
            end
            
            else if (waveEndTrigger == 1)
            begin
                pulse_width <= pulse_width + 1;
            end 
            //---------------------------------------------------------
            // BLOCK 1: "posedge clock" logic
            //---------------------------------------------------------
    
            // Phase 2 ? delay measurement
            else if (currentPhase == 2)
            begin
                if (waveStartTrigger && !waveEndTrigger)
                    counter_value <= counter_value + 1;
    
//                if (waveStartTrigger && waveEndTrigger)
//                    measuredTime <= counter_value * 1000;
            end
    
            // Phase 0 ? pulse width measurement (your commented code)
                 
//            else if (waveEndTrigger == 0)
//            begin
//                measuredPulseWidth <= pulse_width * 1000;
//                pulse_width <= 0;
//            end  
        end
    end
    
endmodule
