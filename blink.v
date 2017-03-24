module top(input clk, output led1, led2);
wire clk, led;
reg [23:0] counter;

always @(posedge clk) begin
  counter <= counter + 1;
  led1 <= counter[23];
  led2 <= counter[22];
end

endmodule
