module dynamic_array_example;

    // Declare a dynamic array
    logic [7:0] my_array [];
    
    // Initial block to demonstrate dynamic array usage
    initial begin
        // Allocate memory for the dynamic array with 5 elements
        my_array = new[5];
        
        // Populate the array with values
        for (int i = 0; i < 5; i++) begin
            my_array[i] = i * 10;  // Assigning values 0, 10, 20, 30, 40
        end
        
        // Display the array contents
        $display("Dynamic Array Contents after initialization:");
        for (int i = 0; i < 5; i++) begin
            $display("my_array[%0d] = %0d", i, my_array[i]);
        end
        
        // Reallocate memory for the dynamic array with 8 elements
        my_array = new[8];
        
        // Populate the array with new values
        for (int i = 0; i < 8; i++) begin
            my_array[i] = i * 15;  // Assigning values 0, 15, 30, ..., 105
        end
        
        // Display the array contents again
        $display("Dynamic Array Contents after resizing:");
        for (int i = 0; i < 8; i++) begin
            $display("my_array[%0d] = %0d", i, my_array[i]);
        end
    end

endmodule
`timescale 1ns / 1ps

module tb_dynamic_array_example;

    // Instantiate the dynamic_array_example module
    dynamic_array_example dut();

    initial begin
        // Run the simulation for a short time to observe the output
        #10 $finish;
    end

endmodule
