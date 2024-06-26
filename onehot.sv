module check_onehot(
  input [31:0] num,
  output logic is_onehot
);
  always_comb begin
    if (num != 0 && ((num & (num - 1)) == 0))
      is_onehot = 1;
    else
      is_onehot = 0;
  end
endmodule
///////////////////////
module testbench;
  reg [31:0] num;
  wire is_onehot;

  check_onehot uut (
    .num(num),
    .is_onehot(is_onehot)
  );

  initial begin
    $monitor("num = %b, is_onehot = %b", num, is_onehot);

    // Test cases
    num = 32'b00000000000000000000000000000001; #10;
    num = 32'b00000000000000000000000000000010; #10;
    num = 32'b00000000000000000000000000000100; #10;
    num = 32'b00000000000000000000000000001000; #10;
    num = 32'b00000000000000000000000000000000; #10;
    num = 32'b00000000000000000000000000001100; #10;
    num = 32'b00000000000000000000000000010000; #10;
    num = 32'b00000000000000000000000100000000; #10;
    num = 32'b00000000000000000000001000000000; #10;

    $finish;
  end
endmodule
