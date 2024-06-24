class ethernetpacket;

  rand bit[7:0] Destination;
  rand bit[7:0] Source;
  rand bit[7:0] data; 

  function new();

    $display("Destination : %0d Source : %0d data : %0d",Destination,Source,data);
  endfunction

  
  covergroup covgrp;

    A : coverpoint Source {
      ignore_bins ignore_vals = {0,64};
      ignore_bins invalid_trans = ([0:60] => 64),([1:64] => 0);
      bins low = {[0:20]};
      bins mid = {[21:55]};
      bins high = {[55:64]};
    }

    B : coverpoint Destination{

      option.weight = 3;
      bins low = {[0:15]};
      bins mid = {[16:32]};
      bins high = {[33:64]};

    }

    C : coverpoint data {

      option.weight = 4;
      bins low = {[0:7]};
      bins mid = {[8:32]};
      bins high = {[33:64]};
      wildcard bins w1 = {8'b1111??};

    }


    AXB : cross A,B;

  endgroup


  function new();

    this.covgrp = new();

  endfunction

endclass

class producer;

  ethernet e1;
  mailbox #(ethernetpacket) mbx;
  event next;



  function new(mailbox #(ethernetpacket) mbx);

    e1 = new();
    this.mbx = mbx;

  endfunction

  task run();

    forever begin

      assert(e1.randomize()) else $error("Randomization Failed");

      $display("Data Produced in Producer  ");
      e1.display();
      mbx.put(e1);
      @(next);

    end

  endtask

endclass


class consumer;

  ethernet e1;
  mailbox #(ethernetpacket) mbx;
  event next;

  function new(mailbox #(ethernetpacket) mbx);
    this.mbx = mbx;

  endfunction

  task run();

    forever begin

        mbx.get(e1);
      	$display("Data Recieved in Consumer");
      	e1.display();
     	e1.covgrp.sample();
      	$display("------------------------------------------------");
        ->next;
      	#5;

    end

  endtask



endclass


module tb();


  mailbox #(ethernetpacket) mbx;
  producer p1;
  consumer c1;


  initial begin
    mbx = new();
    p1 = new(mbx);
    c1 = new(mbx);
    p1.next = c1.next;

    fork

      p1.run();
      c1.run();

    join_none


    #1000;
    $display("Coverage = %0.2f",c1.e1.covgrp.get_inst_coverage());
    $finish;

  end
endmodule
