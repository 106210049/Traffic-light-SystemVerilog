module led7segment (
  input  wire [3:0] digit, // Giá trị BCD 4-bit (0–9)
  input wire decode_en,
  output reg  [7:0] segments     // 7 đoạn: a b c d e f g
);

  // Đoạn bit thứ tự: segments = {a, b, c, d, e, f, g}
  // 0 là sáng (vì cathode chung)
  // Nếu 1 là sáng, 0 là tắt (active-high):
  always @(*) begin
    if(decode_en)	begin
      case (digit)
      4'd0: segments = 8'b11111100;
      4'd1: segments = 8'b01100000;
      4'd2: segments = 8'b11011010;
      4'd3: segments = 8'b11110010;
      4'd4: segments = 8'b01100110;
      4'd5: segments = 8'b10110110;
      4'd6: segments = 8'b10111110;
      4'd8: segments = 8'b11100000;
      4'd7: segments = 8'b11111110;
      4'd9: segments = 8'b11110110;
      default: segments = 8'b00000000; // tắt hết
    endcase
	end
    else	begin
      segments = 8'b00000000;
    end
  end


endmodule
