// Decryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset
//Decryption of shiftrows 128bits
module inver_shiftrow1(sr, sl);
input  [127:0] sl;
output [127:0] sr;
wire  [31:0] row[3:0];
localparam Nb = 4;

//formed the four rows

assign sr = {row[3], row[2], row[1], row[0]};
assign row[3] = sl[127:96];
assign row[2] = {sl[71:64],sl[95:72]};
assign row[1] = {sl[47:32],sl[63:48]};
assign row[0] = {sl[23:0],sl[31:24]};

endmodule


//Decryption of shiftrows 256bits
module inver_shiftrow256(sr,sl);
input [255:0] sl;
output[255:0] sr;
wire [63:0] row[3:0];
localparam Nb = 8;

//formed the four rows
assign sr = {row[3], row[2], row[1], row[0]};
assign row[3] = sl[255:192];
assign row[2] = {sl[135:128], sl[191:136]};
assign row[1] = {sl[87:64], sl[127:88]};
assign row[0] = {sl[31:0], sl[63:32]};

endmodule
