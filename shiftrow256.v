// Encryption of ShiftRows in Verilog 256
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset

//Encryption of shiftrows 256bits

module shiftrow256(sl,sr);
input [255:0] sl;
output [255:0] sr;
wire [63:0] row[3:0];
localparam Nb = 8;

//formed the four rows

assign sr = {row[3], row[2], row[1], row[0]};
assign row[3] = sl[255:192];
assign row[2] = {sl[183:128],sl[191:184]};
assign row[1] = {sl[103:64],sl[127:104]};
assign row[0] = {sl[31:0],sl[63:32]};

endmodule


module testshiftrow256();
wire [255:0] state_in;
wire [255:0] state_out;
assign state_in = 256'h_dbf201c6d42d01c6_130a01c6d42601c6_532201c6d43101c6_455c01c6d54c01c6;
shiftrow256 data_in(state_in, state_out);
endmodule