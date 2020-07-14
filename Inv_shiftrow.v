// Decryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset


//Decryption of shiftrows 128bits
module inv_shiftrow(clock,sl,sr);
input clock;

input [127:0] sr;
output reg [127:0] sl;
always @(posedge clock)
begin

      sl[127:120] = sr[127:120];  
      sl[119:112] = sr[119:112];
      sl[111:104] = sr[111:104];
      sl[103:96]  = sr[103:96];
   
      sl[87:80] = sr[95:88];
      sl[79:72] = sr[87:80];
      sl[71:64] = sr[79:72];
      sl[95:88] = sr[71:64];
   
      sl[63:56] = sr[55:48];									
      sl[55:48] = sr[63:56];
      sl[47:40] = sr[39:32];
      sl[39:32] = sr[47:40];
   
      sl[7:0]   = sr[31:24];
      sl[31:24] = sr[23:16];
      sl[23:16] = sr[15:8];
      sl[15:8]  =  sr[7:0]; 
		  end


endmodule

//Decryption of shiftrows 256bits
module inv_shiftrow256(clock,sl,sr);
input clock;
input  [255:0] sr;
output reg [255:0] sl;
always @(posedge clock)
begin

       sl[255:248] = sr[255:248];  
       sl[247:240] = sr[247:240];
       sl[239:232] = sr[239:232];
       sl[231:224] = sr[231:224];
       sl[223:216] = sr[223:216];
       sl[215:208] = sr[215:208];
       sl[207:200] = sr[207:200];
       sl[199:192] = sr[199:192];
   
        sl[183:176] = sr[191:184];
        sl[175:168] = sr[183:176];
        sl[167:160] = sr[175:168];
        sl[159:152] = sr[167:160];
        sl[151:144] = sr[159:152];
        sl[143:136] = sr[151:144];
        sl[135:128] = sr[143:136];
        sl[191:184] = sr[135:128];

        sl[103:96]  = sr[127:120];
        sl[95:88]   = sr[119:112];
        sl[87:80]   = sr[111:104];
        sl[79:72]   = sr[103:96];
        sl[71:64]   = sr[95:88];
        sl[127:120] = sr[87:80];
        sl[119:112] = sr[79:72];
        sl[111:104] = sr[71:64];
   
        sl[31:24]   = sr[63:56];
        sl[23:16]   = sr[55:48];
        sl[15:8]    = sr[47:40];
        sl[7:0]     = sr[39:32];
        sl[63:56]   = sr[31:24];
        sl[55:48]   = sr[23:16];
        sl[47:40]   = sr[15:8];
        sl[39:32]   = sr[7:0];
end
endmodule
 