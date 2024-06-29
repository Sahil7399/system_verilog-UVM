class singleton_class;

  protected static singleton_class sc;  // Static instance of the singleton class
  static int instances = 0;             // Counter for the number of instances

  protected function new();  // Protected constructor to prevent direct instantiation
    $display("Singleton Class Created");
    instances++;
  endfunction

  static function singleton_class create();  // Static method to create or return the singleton instance
    if (sc == null)  // Check if the instance is null (i.e., not created yet)
      sc = new();  // Create a new instance if it doesn't exist
    return sc;  // Return the singleton instance
  endfunction

endclass
module tb();

  singleton_class sc1, sc2, sc3;

  initial begin
    sc1 = singleton_class::create();
    $display("Instances after sc1 = %0d", sc1.instances);
    sc2 = singleton_class::create();
    $display("Instances after sc2 = %0d", sc2.instances);
    sc3 = singleton_class::create();
    $display("Instances after sc3 = %0d", sc3.instances);
  end

endmodule
