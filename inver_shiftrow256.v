// Decryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset
//Decryption of shiftrows 128bits

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

module testinver_shiftrow256();
wire [255:0] state_in;
wire [255:0] state_out;
assign state_in = 256'h_8e9f01c6d54d01c6_4ddc01c6d57e01c6_a15801c6d7bd01c6_bc9d01c6d6f801c6;
inver_shiftrow256 data_in(state_in, state_out);
endmodule