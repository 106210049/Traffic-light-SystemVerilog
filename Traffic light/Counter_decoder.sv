`include "led7segment.v"
`include "Decimal_Split.v"
// Code your design here
module Counter_decoder #(
	parameter pNUMBER_WIDTH = 5,
  	parameter pLED_WIDTH = 8,
  	parameter pLED_NO = 2
)
  (
  input wire clk,
  input wire en,
  input wire [pNUMBER_WIDTH-1:0] number,
  output wire [pLED_NO-1:0] [pLED_WIDTH-1:0] display_led 
//   output wire [6:0] seg_unit,   // LED cho hàng đơn vị
//   output wire [6:0] seg_dec     // LED cho hàng chục
);

  wire [3:0] unit;
  wire [3:0] dec;
  wire decode_en;
  wire [pLED_WIDTH-1:0] seg_unit, seg_dec;
  // Decimal Split
  Decimal_Split u_decimal_split (
    .clk(clk),
    .en(en),
    .number(number),
    .unit(unit),
    .dec(dec),
    .decode_en(decode_en)
  );

  // Seven Segment Decoder cho đơn vị
  led7segment u_unit_decoder (
    .digit(unit[3:0]),
    .decode_en(decode_en),
    .segments(seg_unit)
  );

  // Seven Segment Decoder cho hàng chục
  led7segment u_dec_decoder (
    .digit(dec[3:0]),
    .decode_en(decode_en),
    .segments(seg_dec)
  );
//   assign display_led [0] = seg_dec;
//   assign display_led [1] = seg_unit;
endmodule
