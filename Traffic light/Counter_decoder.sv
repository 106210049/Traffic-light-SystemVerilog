// Code your design here
module Counter_decoder #(
  parameter pNUMBER_WIDTH=5,
  parameter pLED_WIDTH=8,
  parameter pLED_NO=2
)
  (

	input logic clk,
  	input logic en,
  	input logic [pNUMBER_WIDTH-1:0] number,
    output logic [pLED_NO-1:0][ pLED_WIDTH-1:0] display_led
);
  
  logic [7:0] dozens;
  logic [7:0] unit;
  
  always_comb	begin: decoder_proc
    if(en) begin
      case(number)
        5'd0:	begin
          dozens=8'h0x3F;
          unit=8'h0x3F;
        end
        5'd1:	begin
          dozens=8'h0x3F;
          unit=8'h0x06;
        end
        5'd2:	begin
          dozens=8'h0x3F;
          unit=8'h0x5B;
        end
        5'd3:	begin
          dozens=8'h0x3F;
          unit=8'h0x40;
        end
        5'd4:	begin
          dozens=8'h0x3F;
          unit=8'h0x66;
        end
        5'd5:	begin
          dozens=8'h0x3F;
          unit=8'h0x6D;
        end
        5'd6:	begin
          dozens=8'h0x3F;
          unit=8'h0x7D;
        end
         5'd7:	begin
          dozens=8'h0x3F;
          unit=8'h0x07;
        end
         5'd8:	begin
          dozens=8'h0x3F;
          unit=8'h0x7F;
        end
         5'd9:	begin
          dozens=8'h0x3F;
          unit=8'h0x6F;
        end
        
        
        5'd10:	begin
          dozens=8'h0x06;
          unit=8'h0x3F;
        end
        5'd11:	begin
          dozens=8'h0x06;
          unit=8'h0x06;
        end
        5'd12:	begin
          dozens=8'h0x06;
          unit=8'h0x5B;
        end
        5'd13:	begin
          dozens=8'h0x06;
          unit=8'h0x40;
        end
        5'd14:	begin
          dozens=8'h0x06;
          unit=8'h0x66;
        end
        5'd15:	begin
          dozens=8'h0x06;
          unit=8'h0x6D;
        end
        5'd16:	begin
          dozens=8'h0x06;
          unit=8'h0x7D;
        end
         5'd17:	begin
          dozens=8'h0x06;
          unit=8'h0x07;
        end
         5'd18:	begin
          dozens=8'h0x06;
          unit=8'h0x7F;
        end
         5'd19:	begin
          dozens=8'h0x06;
          unit=8'h0x6F;
        end
     endcase
  end
  end: decoder_proc
  assign display_led[1]=dozens;
  assign display_led[0]=unit;
endmodule: Counter_decoder