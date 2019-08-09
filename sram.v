module sram #(parameter ADDRESS_WIDTH = 8, DATA_WIDTH = 8, DEPTH = 256)(
    input wire clk,  // clock
    input wire [ADDRESS_WIDTH - 1:0] i_addr,
    input wire i_write,
    input wire [DATA_WIDTH - 1:0] i_data,
    output reg [DATA_WIDTH - 1:0] o_data
  );
// DATA_WIDTH is the length of the numbers you would like to save
// DEPTH is how many numbers you would like to save. 
// ADDRESS_WIDTH is how many bits you need to uniquly identify each row. 
  reg [DATA_WIDTH - 1:0] memory_array [DEPTH-1:0] [DEPTH-1:0];
  //What makes this line different is that it is infered differently in this structure. 
  
  
  // i_write = 1, then we are writing data
  // i_write =0, then we are reading data to o_data
  /* Sequential Logic */
  always @(posedge clk) begin
    if (i_write) begin
      memory_array[i_addr] <= i_data;
      // Add flip-flop reset values here
    end 
    else begin
      o_data <= memory_array[i_addr];
      // Add flip-flop q <= d statements here
    end
  end
  
endmodule
