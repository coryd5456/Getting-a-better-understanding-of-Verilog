module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
    output[7:0]DAC,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
    //input [3:0] a,b,
    //output [4:0] c
    );

/*reg [15:0] number [31:0]; // output name is "number"
// specifies how many rows there are of 16bits to create a memory aray.
// However, this memmory isn't saved. These bits will be constructed as RAM in the Complex Logic Blocks. It is fast for small ammounts of data, but not large. 
// this chews through our resources. //This is called distributed RAM

//We can use memmory blocks instead as deadicated block ram. 
sram #(.ADDRESS_WIDTH(8),DATA_WIDTH(8), DEPTH(256)) number_array (
 .clk(clk),.i_addr(),.i_write(),.i_data(),.o_data()
);*/
//wire FGEN;
wire [7:0] FGEN_out;
//timing timer(.clk(clk),.clk_out(FGEN));//.clk(clk) tells what external pin to wire to the internal pin.
//each object in the list is a wire definition.

SignalGenerator ramp(.clk1(clk),.Signal_Out(FGEN_out));


//timing_2 timer2(.clk(clk),.clk_out(FGEN));


wire rst = ~rst_n; // make reset active high


//Math example
//wire [3:0] b;
wire [7:0] c;

//assign b = 4'b0011;
assign c = FGEN_out;








// these signals should be high-z when not used 
/* // comment this section out when not using transmit.
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;*/

assign led = FGEN_out;
assign DAC = c;

//everything below this line is for transmitting data over rx/tx. If not being used it can be removed. 
  wire [7:0] tx_data;
  wire new_tx_data;
  wire tx_busy;
  wire [7:0] rx_data;
  wire new_rx_data;
 
  avr_interface  #(50000000,500000) avr_interface (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_sck(spi_sck),
    .spi_ss(spi_ss),
    .spi_channel(spi_channel),
    .tx(avr_rx), // FPGA tx goes to AVR rx
    .rx(avr_tx),
    .channel(4'd15), // invalid channel disables the ADC
    
    .new_sample(),
    .sample(),
    .sample_channel(),
    .tx_data(tx_data),
    .new_tx_data(new_tx_data),
    .tx_busy(tx_busy),
    .tx_block(avr_rx_busy),
    .rx_data(rx_data),
    .new_rx_data(new_rx_data)
  );
 
  message_printer helloWorldPrinter (
    .clk(clk),
    .rst(rst),
    .tx_data(tx_data),
    .new_tx_data(new_tx_data),
    .tx_busy(tx_busy),
    .rx_data(rx_data),
    .new_rx_data(new_rx_data)
  );
  
endmodule