module SignalGenerator (
    input clk1,  // clock
    output [7:0] Signal_Out
  );
  
  reg [7:0] Signal_Out;
  
  wire [7:0] Signal [0:39];
  integer index = 0;
  
  genvar i;
  generate
    for (i = 0;i<40;i = i+1) begin : genbit
      assign Signal [i] = i;
    end
  endgenerate
  
  /* Sequential Logic */
  always @(posedge clk1) begin
    index <= index + 1;
    Signal_Out <= Signal[index];
    if (index == 40) begin
      // Add flip-flop reset values here
      index <= 0;
    end
  end
  
endmodule

/*
module timing_2 (
    input clk,  // clock
    output clk_out
  );

  reg [24:0] counter;//register to keep track of counting index
  reg clk_out;
  */
  /* Sequential Logic */
  /*
  always @(posedge clk) begin
    counter <= counter + 1'b1;
    if (counter == 25_000_000) begin // underscores are ignored
      counter <= 0;
      clk_out <= ~clk_out;
    end
  end
  
endmodule
*/