module message_rom (
    input clk,
    input [3:0] addr,
    output [7:0] data
  );
 //you aren't allowed to use multi-dimensional arrays in port declarations
 //try this once it runs
  wire [7:0] rom_data [13:0] [1:0];
 //Each charicter is it's ASCII value.
  assign rom_data[0][0] = "H";
  assign rom_data[1][0] = "e";
  assign rom_data[2][0] = "l";
  assign rom_data[3][0] = "l";
  assign rom_data[4][0] = "o";
  assign rom_data[5][0] = " ";
  assign rom_data[6][0] = "W";
  assign rom_data[7][0] = "o";
  assign rom_data[8][0] = "r";
  assign rom_data[9][0] = "l";
  assign rom_data[10][0] = "d";
  assign rom_data[11][0] = "!";
  assign rom_data[12][0] = "\n";
  assign rom_data[13][0] = "\r";
  
  assign rom_data[0][1] = "H";
  assign rom_data[1][1] = "e";
  assign rom_data[2][1] = "l";
  assign rom_data[3][1] = "l";
  assign rom_data[4][1] = "o";
  assign rom_data[5][1] = " ";
  assign rom_data[6][1] = "W";
  assign rom_data[7][1] = "o";
  assign rom_data[8][1] = "r";
  assign rom_data[9][1] = "l";
  assign rom_data[10][1] = "d";
  assign rom_data[11][1] = "!";
  assign rom_data[12][1] = "\n";
  assign rom_data[13][1] = "\r";
 
  reg [7:0] data_d, data_q;
 
  assign data = data_q;
 //@(*) is kind of like an interrupt
  always @(*) begin
    if (addr > 4'd13)
      data_d = " ";
    else
      data_d = rom_data[addr][0];
  end
 
  always @(posedge clk) begin
    data_q <= data_d;
  end
 
endmodule