module Decimal_Split (
  input wire clk,
  input wire en,
  input wire [4:0] number,
  output reg [3:0] unit,
  output reg [3:0] dec,
  output wire decode_en
);

  reg [4:0] count_val;
  reg [4:0] count_val3;
  reg [4:0] number_reg;

  wire en_count;
  wire number_changed;

  // Phát hiện sự thay đổi của input number
  assign number_changed = (number != number_reg);

  // Kích hoạt trừ nếu lớn hơn 10
  assign en_count = (count_val >= 5'd10);

  // FF lưu giá trị number cũ
  always @(posedge clk) begin
    if(en)
      number_reg <= number;
    else 
      number_reg<=0;
  end

  // FF cho count_val (trừ 10 nếu được kích hoạt, hoặc load lại khi number đổi)
  always @(posedge clk) begin
    if (number_changed) begin
      count_val <= number;
    end else if (en && en_count) begin
      count_val <= count_val - 5'd10;
    end
    else	begin
      count_val<=count_val;
    end
  end

  // FF cho count_val3 (đếm số lần trừ, reset khi number đổi)
  always @(posedge clk) begin
    if (number_changed) begin
      count_val3 <= 5'd0;
    end else if (en && en_count) begin
      count_val3 <= count_val3 + 5'd1;
    end
    else	begin
      count_val3<=count_val3;
    end
  end

  // Gán output
  always @(*) begin
    unit = count_val[3:0];
    dec  = count_val3[3:0];
  end

  assign decode_en = (~en_count) & en;

endmodule
