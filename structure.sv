`timescale 1ns / 1ps

module tb_person_module;

    // Declare a variable of type person_t
    person_t person;

    // Initial block to assign values to the structure
    initial begin
        // Assigning values to the person structure
        person.id = 32'h87654321;
        person.name = "Alice Smith";
        person.address.street = 8'h56;
        person.address.city = 8'h78;
        person.address.zip_code = 16'h1234;

        // Displaying the values to check correctness
        $display("Testbench - Person ID: %h", person.id);
        $display("Testbench - Person Name: %s", person.name);
        $display("Testbench - Street: %h", person.address.street);
        $display("Testbench - City: %h", person.address.city);
        $display("Testbench - Zip Code: %h", person.address.zip_code);

        // Additional tests can be added here

        // End simulation
        #10 $finish;
    end

endmodule



`timescale 1ns / 1ps
​
module tb_person_module;
​
    // Declare a variable of type person_t
    person_t person;
​
    // Initial block to assign values to the structure
    initial begin
        // Assigning values to the person structure
        person.id = 32'h87654321;
        person.name = "Alice Smith";
        person.address.street = 8'h56;
        person.address.city = 8'h78;
        person.address.zip_code = 16'h1234;
​
        // Displaying the values to check correctness
        $display("Testbench - Person ID: %h", person.id);
        $display("Testbench - Person Name: %s", person.name);
        $display("Testbench - Street: %h", person.address.street);
        $display("Testbench - City: %h", person.address.city);
        $display("Testbench - Zip Code: %h", person.address.zip_code);
​
        // Additional tests can be added here
​
        // End simulation
        #10 $finish;
    end
​
endmodule
​
