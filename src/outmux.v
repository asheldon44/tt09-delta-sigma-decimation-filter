module outmux (
    input wire clk,                // Clock input
    input wire rst,              // Reset input
    input wire [7:0] d0,           // Data input 0
    input wire [7:0] d1,           // Data input 1
    input wire [7:0] d2,           // Data input 2
    input wire [7:0] d3,           // Data input 3
    output wire [7:0] y            // Output
);

  reg [2:0] count; // 2-bit counter

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      count <= 3'b000;
    end
    else begin
      count <= count + 1;
    end
  end

  // Using a continuous assignment to implement the multiplexer logic
assign y = (count == 3'b010) ? d0 :
           (count == 3'b011) ? d1 :
           (count == 3'b100) ? d2 :
           (count == 3'b101) ? d3 :
                       8'b00000000;

endmodule

