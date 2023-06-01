`default_nettype none
`timescale 1ns/1ps

module tb(
    input wire          clk,
    input wire          rst_n,
    input wire [3:0]    si,
    input wire [1:0]    inputs,
    output wire [6:0]   outputs,
    output wire         debug
);
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    /* unused stuff */
    wire [7:0] uio_oe = 8'b0; /* all inputs */
    wire [7:0] uio_in = 8'b0;
    wire [7:0] uio_out;
    wire ena = 1'b1;
    
    /* inputs, no longer include clock/reset */
    wire [7:0] ui_in = {inputs,si, 2'b0};
 
    /* outputs from module */
    wire [7:0] uo_out;
    assign outputs = uo_out[6:0];
    assign debug = uo_out[7];
    // assign {debug,outputs} = uo_out;
    tt_um_s4ga s4ga(
        `ifdef GL_TEST
            .vccd1( 1'b1),
            .vssd1( 1'b0),
        `endif
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in),
        .uio_out (uio_out),
        .uio_oe (uio_oe),
        .ena (ena),
        .clk (clk),
        .rst_n (rst_n)
        );
    
    
endmodule
