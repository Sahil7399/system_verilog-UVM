module simple_mux #(parameter WIDTH = 8, SEL_WIDTH = 2) (
    input logic [SEL_WIDTH-1:0] sel,        // Selector input
    input logic [WIDTH-1:0] in0,            // Input 0
    input logic [WIDTH-1:0] in1,            // Input 1
    input logic [WIDTH-1:0] in2,            // Input 2
    input logic [WIDTH-1:0] in3,            // Input 3
    output logic [WIDTH-1:0] out            // Output
);

    always_comb begin
        unique case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = {WIDTH{1'b0}};  // Default case (for safety, though unique case usually doesn't need it)
        endcase
    end

endmodule




`timescale 1ns / 1ps

module tb_simple_mux();

    // Parameters for the testbench
    localparam WIDTH = 8;      // Data width
    localparam SEL_WIDTH = 2;  // Selector width (for a 4-to-1 MUX)

    // Testbench signals
    reg [SEL_WIDTH-1:0] sel;   // Selector input
    reg [WIDTH-1:0] in0;       // Input 0
    reg [WIDTH-1:0] in1;       // Input 1
    reg [WIDTH-1:0] in2;       // Input 2
    reg [WIDTH-1:0] in3;       // Input 3
    wire [WIDTH-1:0] out;      // Output

    // Instantiate the simple_mux module
    simple_mux #(WIDTH, SEL_WIDTH) uut (
        .sel(sel),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        in0 = 8'hA5;   // 10100101
        in1 = 8'h3C;   // 00111100
        in2 = 8'h7E;   // 01111110
        in3 = 8'hFF;   // 11111111
        sel = 2'b00;

        // Apply test vectors and display the output
        #10 sel = 2'b00;  // Select in0
        #10 sel = 2'b01;  // Select in1
        #10 sel = 2'b10;  // Select in2
        #10 sel = 2'b11;  // Select in3
        #10 sel = 2'b00;  // Select in0 again

        // Test with an invalid selector value (should default)
        #10 sel = 2'bxx;  // Undefined selector

        // End simulation
        #20 $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("Time: %0t | sel: %b | in0: %h | in1: %h | in2: %h | in3: %h | out: %h", 
                 $time, sel, in0, in1, in2, in3, out);
    end

endmodule
