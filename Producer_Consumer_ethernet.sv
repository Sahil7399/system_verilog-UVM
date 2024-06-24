//tb
class ethernetpacket;
  
  rand bit[7:0] destination;
  rand bit [7:0]source;
  rand bit [1:0] length;
  rand bit[7:0] payload;

  function new();
    
    $display("preamble : %0d DA : %0d SA : %0d sfd : %0d length : %0d data : %0d crc : %0d", preamble,DA,SA, sfd, length, data, crc);
    
  endfunction
  
endclass

class producer;
  
  ethernetpacket pkt;
  mailbox #(ethernetpacket) mbx;
  event next;
  
  
  
  function new(mailbox #(ethernetpacket) mbx);
    
    pkt = new();
    this.mbx = mbx;
    
  endfunction
  
  task run();
    
    forever begin
      
      assert(pkt.randomize()) else $error("Randomization Failed");

      $display("Data Produced in Producer  ");
      e1.display();
      mbx.put(pkt);
      @(next);
    end
  endtask
endclass


class consumer;
  ethernetpacket pkt;
  mailbox #(ethernetpacket) mbx;
  event next;
  
  function new(mailbox #(ethernetpacket) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
  
    forever begin
      
        mbx.get(pkt);
      	$display("Data Recieved in Consumer");
      	e1.display();
      $display("------------------------------------------------");
        ->next;
      	#5;

    end 
  endtask
endclass
////////////////////////////////////////////////////

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
    $finish;
    
  end
  
  
endmodule
