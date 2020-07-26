// Decryption of MixcolumnLUT1 in Verilog (128/256)
// Vi Lam, 07/22/20
// Function:
// This module is used to perform multipplication on columns of the data in GF(256) treating each colum as a polynomial.
// The columns are multiplied by different other polynomials in the fields based on whether the system is doing encryption or decryption.

module inver_mixcolumnLUT1(clock,reset, enable, in_byte, out_byte);
input clock, enable, reset;
input [127:0] in_byte;
output reg [127:0] out_byte;
reg[31:0] decrypt_row[3:0];        //decrypt value
localparam     Nb = 4 ;            // number of rows

genvar i;
//formed the four rows
always @(posedge clock, negedge enable, negedge reset)
begin
out_byte <= {decrypt_row[3], decrypt_row[2], decrypt_row[1], decrypt_row[0]};
end

generate for (i = 0; i< Nb; i = i+1)
begin : block
reg [7:0] b3,b2,b1,b0;
reg [31:0] r[3:0];

always @(in_byte)
begin 
   r[3] <= in_byte[(Nb*32) -1:(Nb*24)];
   r[2] <= in_byte[(Nb*24) -1:(Nb*16)];
   r[1] <= in_byte[(Nb*16) -1:(Nb*8)];
   r[0] <= in_byte[(Nb*8)  -1:(Nb*0)];
end

always @(r)
begin
   b3 <= r[3][(i+1)*8-1:i*8];
	b2 <= r[2][(i+1)*8-1:i*8];
	b1 <= r[1][(i+1)*8-1:i*8];
	b0 <= r[0][(i+1)*8-1:i*8];
end

always @(b3,b2,b1,b0)
begin
   decrypt_row[3][(i+1)*8-1:i*8] <= mul0E(b3) ^ mul0B(b2) ^ mul0D(b1) ^ mul09(b0);
	decrypt_row[2][(i+1)*8-1:i*8] <= mul09(b3) ^ mul0E(b2) ^ mul0B(b1) ^ mul0D(b0);
	decrypt_row[1][(i+1)*8-1:i*8] <= mul0D(b3) ^ mul09(b2) ^ mul0E(b1) ^ mul0B(b0);
	decrypt_row[0][(i+1)*8-1:i*8] <= mul0B(b3) ^ mul0D(b2) ^ mul09(b1) ^ mul0E(b0);
end

end 
endgenerate	



//This function stores the tables holding the results of performing the
//multiplication in GF(256) of any number by 0x09
  function [7:0] mul09;
    input [7:0] x;
 
    case (x)
      8'h00 : mul09 = 8'h00;
      8'h01 : mul09 = 8'h09;
      8'h02 : mul09 = 8'h12;
      8'h03 : mul09 = 8'h1B;
      8'h04 : mul09 = 8'h24;
      8'h05 : mul09 = 8'h2D;
      8'h06 : mul09 = 8'h36;
      8'h07 : mul09 = 8'h3F;
		
      8'h08 : mul09 = 8'h48;
      8'h09 : mul09 = 8'h41;
      8'h0A : mul09 = 8'h5A;
      8'h0B : mul09 = 8'h53;
      8'h0C : mul09 = 8'h6C;
      8'h0D : mul09 = 8'h65;
      8'h0E : mul09 = 8'h7E;
      8'h0F : mul09 = 8'h77;
     
	   8'h10 : mul09 = 8'h90;
      8'h11 : mul09 = 8'h99;
      8'h12 : mul09 = 8'h82;
      8'h13 : mul09 = 8'h8B;
      8'h14 : mul09 = 8'hB4;
      8'h15 : mul09 = 8'hBD;
      8'h16 : mul09 = 8'hA6;
      8'h17 : mul09 = 8'hAF;
     
	   8'h18 : mul09 = 8'hD8;
      8'h19 : mul09 = 8'hD1;
      8'h1A : mul09 = 8'hCA;
      8'h1B : mul09 = 8'hC3;
      8'h1C : mul09 = 8'hFC;
      8'h1D : mul09 = 8'hF5;
      8'h1E : mul09 = 8'hEE;
      8'h1F : mul09 = 8'hE7;
     
	   8'h20 : mul09 = 8'h3B;
      8'h21 : mul09 = 8'h32;
      8'h22 : mul09 = 8'h29;
      8'h23 : mul09 = 8'h20;
      8'h24 : mul09 = 8'h1F;
      8'h25 : mul09 = 8'h16;
      8'h26 : mul09 = 8'h0D;
      8'h27 : mul09 = 8'h04;
     
	   8'h28 : mul09 = 8'h73;
      8'h29 : mul09 = 8'h7A;
      8'h2A : mul09 = 8'h61;
      8'h2B : mul09 = 8'h68;
      8'h2C : mul09 = 8'h57;
      8'h2D : mul09 = 8'h5E;
      8'h2E : mul09 = 8'h45;
      8'h2F : mul09 = 8'h4C;
      
		8'h30 : mul09 = 8'hAB;
      8'h31 : mul09 = 8'hA2;
      8'h32 : mul09 = 8'hB9;
      8'h33 : mul09 = 8'hB0;
      8'h34 : mul09 = 8'h8F;
      8'h35 : mul09 = 8'h86;
      8'h36 : mul09 = 8'h9D;
      8'h37 : mul09 = 8'h94;
      
		8'h38 : mul09 = 8'hE3;
      8'h39 : mul09 = 8'hEA;
      8'h3A : mul09 = 8'hF1;
      8'h3B : mul09 = 8'hF8;
      8'h3C : mul09 = 8'hC7;
      8'h3D : mul09 = 8'hCE;
      8'h3E : mul09 = 8'hD5;
      8'h3F : mul09 = 8'hDC;
     
	   8'h40 : mul09 = 8'h76;
      8'h41 : mul09 = 8'h7F;
      8'h42 : mul09 = 8'h64;
      8'h43 : mul09 = 8'h6D;
      8'h44 : mul09 = 8'h52;
      8'h45 : mul09 = 8'h5B;
      8'h46 : mul09 = 8'h40;
      8'h47 : mul09 = 8'h49;
      
		8'h48 : mul09 = 8'h3E;
      8'h49 : mul09 = 8'h37;
      8'h4A : mul09 = 8'h2C;
      8'h4B : mul09 = 8'h25;
      8'h4C : mul09 = 8'h1A;
      8'h4D : mul09 = 8'h13;
      8'h4E : mul09 = 8'h08;
      8'h4F : mul09 = 8'h01;
     
	   8'h50 : mul09 = 8'hE6;
      8'h51 : mul09 = 8'hEF;
      8'h52 : mul09 = 8'hF4;
      8'h53 : mul09 = 8'hFD;
      8'h54 : mul09 = 8'hC2;
      8'h55 : mul09 = 8'hCB;
      8'h56 : mul09 = 8'hD0;
      8'h57 : mul09 = 8'hD9;
     
	   8'h58 : mul09 = 8'hAE;
      8'h59 : mul09 = 8'hA7;
      8'h5A : mul09 = 8'hBC;
      8'h5B : mul09 = 8'hB5;
      8'h5C : mul09 = 8'h8A;
      8'h5D : mul09 = 8'h83;
      8'h5E : mul09 = 8'h98;
      8'h5F : mul09 = 8'h91;
     
	   8'h60 : mul09 = 8'h4D;
      8'h61 : mul09 = 8'h44;
      8'h62 : mul09 = 8'h5F;
      8'h63 : mul09 = 8'h56;
      8'h64 : mul09 = 8'h69;
      8'h65 : mul09 = 8'h60;
      8'h66 : mul09 = 8'h7B;
      8'h67 : mul09 = 8'h72;
     
	   8'h68 : mul09 = 8'h05;
      8'h69 : mul09 = 8'h0C;
      8'h6A : mul09 = 8'h17;
      8'h6B : mul09 = 8'h1E;
      8'h6C : mul09 = 8'h21;
      8'h6D : mul09 = 8'h28;
      8'h6E : mul09 = 8'h33;
      8'h6F : mul09 = 8'h3A;
      
		8'h70 : mul09 = 8'hDD;
      8'h71 : mul09 = 8'hD4;
      8'h72 : mul09 = 8'hCF;
      8'h73 : mul09 = 8'hC6;
      8'h74 : mul09 = 8'hF9;
      8'h75 : mul09 = 8'hF0;
      8'h76 : mul09 = 8'hEB;
      8'h77 : mul09 = 8'hE2;
      
		8'h78 : mul09 = 8'h95;
      8'h79 : mul09 = 8'h9C;
      8'h7A : mul09 = 8'h87;
      8'h7B : mul09 = 8'h8E;
      8'h7C : mul09 = 8'hB1;
      8'h7D : mul09 = 8'hB8;
      8'h7E : mul09 = 8'hA3;
      8'h7F : mul09 = 8'hAA;
      
		8'h80 : mul09 = 8'hEC;
      8'h81 : mul09 = 8'hE5;
      8'h82 : mul09 = 8'hFE;
      8'h83 : mul09 = 8'hF7;
      8'h84 : mul09 = 8'hC8;
      8'h85 : mul09 = 8'hC1;
      8'h86 : mul09 = 8'hDA;
      8'h87 : mul09 = 8'hD3;
     
	   8'h88 : mul09 = 8'hA4;
      8'h89 : mul09 = 8'hAD;
      8'h8A : mul09 = 8'hB6;
      8'h8B : mul09 = 8'hBF;
      8'h8C : mul09 = 8'h80;
      8'h8D : mul09 = 8'h89;
      8'h8E : mul09 = 8'h92;
      8'h8F : mul09 = 8'h9B;
     
	   8'h90 : mul09 = 8'h7C;
      8'h91 : mul09 = 8'h75;
      8'h92 : mul09 = 8'h6E;
      8'h93 : mul09 = 8'h67;
      8'h94 : mul09 = 8'h58;
      8'h95 : mul09 = 8'h51;
      8'h96 : mul09 = 8'h4A;
      8'h97 : mul09 = 8'h43;
      
		8'h98 : mul09 = 8'h34;
      8'h99 : mul09 = 8'h3D;
      8'h9A : mul09 = 8'h26;
      8'h9B : mul09 = 8'h2F;
      8'h9C : mul09 = 8'h10;
      8'h9D : mul09 = 8'h19;
      8'h9E : mul09 = 8'h02;
      8'h9F : mul09 = 8'h0B;
      
		8'hA0 : mul09 = 8'hD7;
      8'hA1 : mul09 = 8'hDE;
      8'hA2 : mul09 = 8'hC5;
      8'hA3 : mul09 = 8'hCC;
      8'hA4 : mul09 = 8'hF3;
      8'hA5 : mul09 = 8'hFA;
      8'hA6 : mul09 = 8'hE1;
      8'hA7 : mul09 = 8'hE8;
      
		8'hA8 : mul09 = 8'h9F;
      8'hA9 : mul09 = 8'h96;
      8'hAA : mul09 = 8'h8D;
      8'hAB : mul09 = 8'h84;
      8'hAC : mul09 = 8'hBB;
      8'hAD : mul09 = 8'hB2;
      8'hAE : mul09 = 8'hA9;
      8'hAF : mul09 = 8'hA0;
      
		8'hB0 : mul09 = 8'h47;
      8'hB1 : mul09 = 8'h4E;
      8'hB2 : mul09 = 8'h55;
      8'hB3 : mul09 = 8'h5C;
      8'hB4 : mul09 = 8'h63;
      8'hB5 : mul09 = 8'h6A;
      8'hB6 : mul09 = 8'h71;
      8'hB7 : mul09 = 8'h78;
      
		8'hB8 : mul09 = 8'h0F;
      8'hB9 : mul09 = 8'h06;
      8'hBA : mul09 = 8'h1D;
      8'hBB : mul09 = 8'h14;
      8'hBC : mul09 = 8'h2B;
      8'hBD : mul09 = 8'h22;
      8'hBE : mul09 = 8'h39;
      8'hBF : mul09 = 8'h30;
      
		8'hC0 : mul09 = 8'h9A;
      8'hC1 : mul09 = 8'h93;
      8'hC2 : mul09 = 8'h88;
      8'hC3 : mul09 = 8'h81;
      8'hC4 : mul09 = 8'hBE;
      8'hC5 : mul09 = 8'hB7;
      8'hC6 : mul09 = 8'hAC;
      8'hC7 : mul09 = 8'hA5;
     
	   8'hC8 : mul09 = 8'hD2;
      8'hC9 : mul09 = 8'hDB;
      8'hCA : mul09 = 8'hC0;
      8'hCB : mul09 = 8'hC9;
      8'hCC : mul09 = 8'hF6;
      8'hCD : mul09 = 8'hFF;
      8'hCE : mul09 = 8'hE4;
      8'hCF : mul09 = 8'hED;
      
		8'hD0 : mul09 = 8'h0A;
      8'hD1 : mul09 = 8'h03;
      8'hD2 : mul09 = 8'h18;
      8'hD3 : mul09 = 8'h11;
      8'hD4 : mul09 = 8'h2E;
      8'hD5 : mul09 = 8'h27;
      8'hD6 : mul09 = 8'h3C;
      8'hD7 : mul09 = 8'h35;
     
	   8'hD8 : mul09 = 8'h42;
      8'hD9 : mul09 = 8'h4B;
      8'hDA : mul09 = 8'h50;
      8'hDB : mul09 = 8'h59;
      8'hDC : mul09 = 8'h66;
      8'hDD : mul09 = 8'h6F;
      8'hDE : mul09 = 8'h74;
      8'hDF : mul09 = 8'h7D;
      
		8'hE0 : mul09 = 8'hA1;
      8'hE1 : mul09 = 8'hA8;
      8'hE2 : mul09 = 8'hB3;
      8'hE3 : mul09 = 8'hBA;
      8'hE4 : mul09 = 8'h85;
      8'hE5 : mul09 = 8'h8C;
      8'hE6 : mul09 = 8'h97;
      8'hE7 : mul09 = 8'h9E;
      
		8'hE8 : mul09 = 8'hE9;
      8'hE9 : mul09 = 8'hE0;
      8'hEA : mul09 = 8'hFB;
      8'hEB : mul09 = 8'hF2;
      8'hEC : mul09 = 8'hCD;
      8'hED : mul09 = 8'hC4;
      8'hEE : mul09 = 8'hDF;
      8'hEF : mul09 = 8'hD6;
      
		8'hF0 : mul09 = 8'h31;
      8'hF1 : mul09 = 8'h38;
      8'hF2 : mul09 = 8'h23;
      8'hF3 : mul09 = 8'h2A;
      8'hF4 : mul09 = 8'h15;
      8'hF5 : mul09 = 8'h1C;
      8'hF6 : mul09 = 8'h07;
      8'hF7 : mul09 = 8'h0E;
     
	   8'hF8 : mul09 = 8'h79;
      8'hF9 : mul09 = 8'h70;
      8'hFA : mul09 = 8'h6B;
      8'hFB : mul09 = 8'h62;
      8'hFC : mul09 = 8'h5D;
      8'hFD : mul09 = 8'h54;
      8'hFE : mul09 = 8'h4F;
      8'hFF : mul09 = 8'h46;
      default : mul09 = 0;
    endcase
  endfunction
 
  //This function stores the tables holding the results of performing the
  //multiplication in GF(256) of any number by 0x0B
  function [7:0] mul0B;
    input [7:0] x;
 
    case (x)
      8'h00 : mul0B = 8'h00;
      8'h01 : mul0B = 8'h0B;
      8'h02 : mul0B = 8'h16;
      8'h03 : mul0B = 8'h1D;
      8'h04 : mul0B = 8'h2C;
      8'h05 : mul0B = 8'h27;
      8'h06 : mul0B = 8'h3A;
      8'h07 : mul0B = 8'h31;
      
		8'h08 : mul0B = 8'h58;
      8'h09 : mul0B = 8'h53;
      8'h0A : mul0B = 8'h4E;
      8'h0B : mul0B = 8'h45;
      8'h0C : mul0B = 8'h74;
      8'h0D : mul0B = 8'h7F;
      8'h0E : mul0B = 8'h62;
      8'h0F : mul0B = 8'h69;
      
		8'h10 : mul0B = 8'hB0;
      8'h11 : mul0B = 8'hBB;
      8'h12 : mul0B = 8'hA6;
      8'h13 : mul0B = 8'hAD;
      8'h14 : mul0B = 8'h9C;
      8'h15 : mul0B = 8'h97;
      8'h16 : mul0B = 8'h8A;
      8'h17 : mul0B = 8'h81;
     
	   8'h18 : mul0B = 8'hE8;
      8'h19 : mul0B = 8'hE3;
      8'h1A : mul0B = 8'hFE;
      8'h1B : mul0B = 8'hF5;
      8'h1C : mul0B = 8'hC4;
      8'h1D : mul0B = 8'hCF;
      8'h1E : mul0B = 8'hD2;
      8'h1F : mul0B = 8'hD9;
      
		8'h20 : mul0B = 8'h7B;
      8'h21 : mul0B = 8'h70;
      8'h22 : mul0B = 8'h6D;
      8'h23 : mul0B = 8'h66;
      8'h24 : mul0B = 8'h57;
      8'h25 : mul0B = 8'h5C;
      8'h26 : mul0B = 8'h41;
      8'h27 : mul0B = 8'h4A;
      
		8'h28 : mul0B = 8'h23;
      8'h29 : mul0B = 8'h28;
      8'h2A : mul0B = 8'h35;
      8'h2B : mul0B = 8'h3E;
      8'h2C : mul0B = 8'h0F;
      8'h2D : mul0B = 8'h04;
      8'h2E : mul0B = 8'h19;
      8'h2F : mul0B = 8'h12;
      
		8'h30 : mul0B = 8'hCB;
      8'h31 : mul0B = 8'hC0;
      8'h32 : mul0B = 8'hDD;
      8'h33 : mul0B = 8'hD6;
      8'h34 : mul0B = 8'hE7;
      8'h35 : mul0B = 8'hEC;
      8'h36 : mul0B = 8'hF1;
      8'h37 : mul0B = 8'hFA;
      
		8'h38 : mul0B = 8'h93;
      8'h39 : mul0B = 8'h98;
      8'h3A : mul0B = 8'h85;
      8'h3B : mul0B = 8'h8E;
      8'h3C : mul0B = 8'hBF;
      8'h3D : mul0B = 8'hB4;
      8'h3E : mul0B = 8'hA9;
      8'h3F : mul0B = 8'hA2;
      
		8'h40 : mul0B = 8'hF6;
      8'h41 : mul0B = 8'hFD;
      8'h42 : mul0B = 8'hE0;
      8'h43 : mul0B = 8'hEB;
      8'h44 : mul0B = 8'hDA;
      8'h45 : mul0B = 8'hD1;
      8'h46 : mul0B = 8'hCC;
      8'h47 : mul0B = 8'hC7;
      
		8'h48 : mul0B = 8'hAE;
      8'h49 : mul0B = 8'hA5;
      8'h4A : mul0B = 8'hB8;
      8'h4B : mul0B = 8'hB3;
      8'h4C : mul0B = 8'h82;
      8'h4D : mul0B = 8'h89;
      8'h4E : mul0B = 8'h94;
      8'h4F : mul0B = 8'h9F;
      
		8'h50 : mul0B = 8'h46;
      8'h51 : mul0B = 8'h4D;
      8'h52 : mul0B = 8'h50;
      8'h53 : mul0B = 8'h5B;
      8'h54 : mul0B = 8'h6A;
      8'h55 : mul0B = 8'h61;
      8'h56 : mul0B = 8'h7C;
      8'h57 : mul0B = 8'h77;
      
		8'h58 : mul0B = 8'h1E;
      8'h59 : mul0B = 8'h15;
      8'h5A : mul0B = 8'h08;
      8'h5B : mul0B = 8'h03;
      8'h5C : mul0B = 8'h32;
      8'h5D : mul0B = 8'h39;
      8'h5E : mul0B = 8'h24;
      8'h5F : mul0B = 8'h2F;
     
	   8'h60 : mul0B = 8'h8D;
      8'h61 : mul0B = 8'h86;
      8'h62 : mul0B = 8'h9B;
      8'h63 : mul0B = 8'h90;
      8'h64 : mul0B = 8'hA1;
      8'h65 : mul0B = 8'hAA;
      8'h66 : mul0B = 8'hB7;
      8'h67 : mul0B = 8'hBC;
      
		8'h68 : mul0B = 8'hD5;
      8'h69 : mul0B = 8'hDE;
      8'h6A : mul0B = 8'hC3;
      8'h6B : mul0B = 8'hC8;
      8'h6C : mul0B = 8'hF9;
      8'h6D : mul0B = 8'hF2;
      8'h6E : mul0B = 8'hEF;
      8'h6F : mul0B = 8'hE4;
      
		8'h70 : mul0B = 8'h3D;
      8'h71 : mul0B = 8'h36;
      8'h72 : mul0B = 8'h2B;
      8'h73 : mul0B = 8'h20;
      8'h74 : mul0B = 8'h11;
      8'h75 : mul0B = 8'h1A;
      8'h76 : mul0B = 8'h07;
      8'h77 : mul0B = 8'h0C;
      
		8'h78 : mul0B = 8'h65;
      8'h79 : mul0B = 8'h6E;
      8'h7A : mul0B = 8'h73;
      8'h7B : mul0B = 8'h78;
      8'h7C : mul0B = 8'h49;
      8'h7D : mul0B = 8'h42;
      8'h7E : mul0B = 8'h5F;
      8'h7F : mul0B = 8'h54;
      
		8'h80 : mul0B = 8'hF7;
      8'h81 : mul0B = 8'hFC;
      8'h82 : mul0B = 8'hE1;
      8'h83 : mul0B = 8'hEA;
      8'h84 : mul0B = 8'hDB;
      8'h85 : mul0B = 8'hD0;
      8'h86 : mul0B = 8'hCD;
      8'h87 : mul0B = 8'hC6;
      
		8'h88 : mul0B = 8'hAF;
      8'h89 : mul0B = 8'hA4;
      8'h8A : mul0B = 8'hB9;
      8'h8B : mul0B = 8'hB2;
      8'h8C : mul0B = 8'h83;
      8'h8D : mul0B = 8'h88;
      8'h8E : mul0B = 8'h95;
      8'h8F : mul0B = 8'h9E;
     
	   8'h90 : mul0B = 8'h47;
      8'h91 : mul0B = 8'h4C;
      8'h92 : mul0B = 8'h51;
      8'h93 : mul0B = 8'h5A;
      8'h94 : mul0B = 8'h6B;
      8'h95 : mul0B = 8'h60;
      8'h96 : mul0B = 8'h7D;
      8'h97 : mul0B = 8'h76;
      
		8'h98 : mul0B = 8'h1F;
      8'h99 : mul0B = 8'h14;
      8'h9A : mul0B = 8'h09;
      8'h9B : mul0B = 8'h02;
      8'h9C : mul0B = 8'h33;
      8'h9D : mul0B = 8'h38;
      8'h9E : mul0B = 8'h25;
      8'h9F : mul0B = 8'h2E;
     
	   8'hA0 : mul0B = 8'h8C;
      8'hA1 : mul0B = 8'h87;
      8'hA2 : mul0B = 8'h9A;
      8'hA3 : mul0B = 8'h91;
      8'hA4 : mul0B = 8'hA0;
      8'hA5 : mul0B = 8'hAB;
      8'hA6 : mul0B = 8'hB6;
      8'hA7 : mul0B = 8'hBD;
     
	   8'hA8 : mul0B = 8'hD4;
      8'hA9 : mul0B = 8'hDF;
      8'hAA : mul0B = 8'hC2;
      8'hAB : mul0B = 8'hC9;
      8'hAC : mul0B = 8'hF8;
      8'hAD : mul0B = 8'hF3;
      8'hAE : mul0B = 8'hEE;
      8'hAF : mul0B = 8'hE5;
     
	   8'hB0 : mul0B = 8'h3C;
      8'hB1 : mul0B = 8'h37;
      8'hB2 : mul0B = 8'h2A;
      8'hB3 : mul0B = 8'h21;
      8'hB4 : mul0B = 8'h10;
      8'hB5 : mul0B = 8'h1B;
      8'hB6 : mul0B = 8'h06;
      8'hB7 : mul0B = 8'h0D;
     
	   8'hB8 : mul0B = 8'h64;
      8'hB9 : mul0B = 8'h6F;
      8'hBA : mul0B = 8'h72;
      8'hBB : mul0B = 8'h79;
      8'hBC : mul0B = 8'h48;
      8'hBD : mul0B = 8'h43;
      8'hBE : mul0B = 8'h5E;
      8'hBF : mul0B = 8'h55;
     
	   8'hC0 : mul0B = 8'h01;
      8'hC1 : mul0B = 8'h0A;
      8'hC2 : mul0B = 8'h17;
      8'hC3 : mul0B = 8'h1C;
      8'hC4 : mul0B = 8'h2D;
      8'hC5 : mul0B = 8'h26;
      8'hC6 : mul0B = 8'h3B;
      8'hC7 : mul0B = 8'h30;
     
	   8'hC8 : mul0B = 8'h59;
      8'hC9 : mul0B = 8'h52;
      8'hCA : mul0B = 8'h4F;
      8'hCB : mul0B = 8'h44;
      8'hCC : mul0B = 8'h75;
      8'hCD : mul0B = 8'h7E;
      8'hCE : mul0B = 8'h63;
      8'hCF : mul0B = 8'h68;
      
		8'hD0 : mul0B = 8'hB1;
      8'hD1 : mul0B = 8'hBA;
      8'hD2 : mul0B = 8'hA7;
      8'hD3 : mul0B = 8'hAC;
      8'hD4 : mul0B = 8'h9D;
      8'hD5 : mul0B = 8'h96;
      8'hD6 : mul0B = 8'h8B;
      8'hD7 : mul0B = 8'h80;
     
	   8'hD8 : mul0B = 8'hE9;
      8'hD9 : mul0B = 8'hE2;
      8'hDA : mul0B = 8'hFF;
      8'hDB : mul0B = 8'hF4;
      8'hDC : mul0B = 8'hC5;
      8'hDD : mul0B = 8'hCE;
      8'hDE : mul0B = 8'hD3;
      8'hDF : mul0B = 8'hD8;
     
	   8'hE0 : mul0B = 8'h7A;
      8'hE1 : mul0B = 8'h71;
      8'hE2 : mul0B = 8'h6C;
      8'hE3 : mul0B = 8'h67;
      8'hE4 : mul0B = 8'h56;
      8'hE5 : mul0B = 8'h5D;
      8'hE6 : mul0B = 8'h40;
      8'hE7 : mul0B = 8'h4B;
     
	   8'hE8 : mul0B = 8'h22;
      8'hE9 : mul0B = 8'h29;
      8'hEA : mul0B = 8'h34;
      8'hEB : mul0B = 8'h3F;
      8'hEC : mul0B = 8'h0E;
      8'hED : mul0B = 8'h05;
      8'hEE : mul0B = 8'h18;
      8'hEF : mul0B = 8'h13;
      
		8'hF0 : mul0B = 8'hCA;
      8'hF1 : mul0B = 8'hC1;
      8'hF2 : mul0B = 8'hDC;
      8'hF3 : mul0B = 8'hD7;
      8'hF4 : mul0B = 8'hE6;
      8'hF5 : mul0B = 8'hED;
      8'hF6 : mul0B = 8'hF0;
      8'hF7 : mul0B = 8'hFB;
      
		8'hF8 : mul0B = 8'h92;
      8'hF9 : mul0B = 8'h99;
      8'hFA : mul0B = 8'h84;
      8'hFB : mul0B = 8'h8F;
      8'hFC : mul0B = 8'hBE;
      8'hFD : mul0B = 8'hB5;
      8'hFE : mul0B = 8'hA8;
      8'hFF : mul0B = 8'hA3;
      default : mul0B = 0;
    endcase
  endfunction
 
  //This function stores the tables holding the results of performing the
  //multiplication in GF(256) of any number by 0x0D
  function [7:0] mul0D;
    input [7:0] x;
 
    case (x)
      8'h00 : mul0D = 8'h00;
      8'h01 : mul0D = 8'h0D;
      8'h02 : mul0D = 8'h1A;
      8'h03 : mul0D = 8'h17;
      8'h04 : mul0D = 8'h34;
      8'h05 : mul0D = 8'h39;
      8'h06 : mul0D = 8'h2E;
      8'h07 : mul0D = 8'h23;
      
		8'h08 : mul0D = 8'h68;
      8'h09 : mul0D = 8'h65;
      8'h0A : mul0D = 8'h72;
      8'h0B : mul0D = 8'h7F;
      8'h0C : mul0D = 8'h5C;
      8'h0D : mul0D = 8'h51;
      8'h0E : mul0D = 8'h46;
      8'h0F : mul0D = 8'h4B;
     
	   8'h10 : mul0D = 8'hD0;
      8'h11 : mul0D = 8'hDD;
      8'h12 : mul0D = 8'hCA;
      8'h13 : mul0D = 8'hC7;
      8'h14 : mul0D = 8'hE4;
      8'h15 : mul0D = 8'hE9;
      8'h16 : mul0D = 8'hFE;
      8'h17 : mul0D = 8'hF3;
     
	   8'h18 : mul0D = 8'hB8;
      8'h19 : mul0D = 8'hB5;
      8'h1A : mul0D = 8'hA2;
      8'h1B : mul0D = 8'hAF;
      8'h1C : mul0D = 8'h8C;
      8'h1D : mul0D = 8'h81;
      8'h1E : mul0D = 8'h96;
      8'h1F : mul0D = 8'h9B;
     
	   8'h20 : mul0D = 8'hBB;
      8'h21 : mul0D = 8'hB6;
      8'h22 : mul0D = 8'hA1;
      8'h23 : mul0D = 8'hAC;
      8'h24 : mul0D = 8'h8F;
      8'h25 : mul0D = 8'h82;
      8'h26 : mul0D = 8'h95;
      8'h27 : mul0D = 8'h98;
      
		8'h28 : mul0D = 8'hD3;
      8'h29 : mul0D = 8'hDE;
      8'h2A : mul0D = 8'hC9;
      8'h2B : mul0D = 8'hC4;
      8'h2C : mul0D = 8'hE7;
      8'h2D : mul0D = 8'hEA;
      8'h2E : mul0D = 8'hFD;
      8'h2F : mul0D = 8'hF0;
      
		8'h30 : mul0D = 8'h6B;
      8'h31 : mul0D = 8'h66;
      8'h32 : mul0D = 8'h71;
      8'h33 : mul0D = 8'h7C;
      8'h34 : mul0D = 8'h5F;
      8'h35 : mul0D = 8'h52;
      8'h36 : mul0D = 8'h45;
      8'h37 : mul0D = 8'h48;
      
		8'h38 : mul0D = 8'h03;
      8'h39 : mul0D = 8'h0E;
      8'h3A : mul0D = 8'h19;
      8'h3B : mul0D = 8'h14;
      8'h3C : mul0D = 8'h37;
      8'h3D : mul0D = 8'h3A;
      8'h3E : mul0D = 8'h2D;
      8'h3F : mul0D = 8'h20;
      
		8'h40 : mul0D = 8'h6D;
      8'h41 : mul0D = 8'h60;
      8'h42 : mul0D = 8'h77;
      8'h43 : mul0D = 8'h7A;
      8'h44 : mul0D = 8'h59;
      8'h45 : mul0D = 8'h54;
      8'h46 : mul0D = 8'h43;
      8'h47 : mul0D = 8'h4E;
     
	   8'h48 : mul0D = 8'h05;
      8'h49 : mul0D = 8'h08;
      8'h4A : mul0D = 8'h1F;
      8'h4B : mul0D = 8'h12;
      8'h4C : mul0D = 8'h31;
      8'h4D : mul0D = 8'h3C;
      8'h4E : mul0D = 8'h2B;
      8'h4F : mul0D = 8'h26;
     
	   8'h50 : mul0D = 8'hBD;
      8'h51 : mul0D = 8'hB0;
      8'h52 : mul0D = 8'hA7;
      8'h53 : mul0D = 8'hAA;
      8'h54 : mul0D = 8'h89;
      8'h55 : mul0D = 8'h84;
      8'h56 : mul0D = 8'h93;
      8'h57 : mul0D = 8'h9E;
      
		8'h58 : mul0D = 8'hD5;
      8'h59 : mul0D = 8'hD8;
      8'h5A : mul0D = 8'hCF;
      8'h5B : mul0D = 8'hC2;
      8'h5C : mul0D = 8'hE1;
      8'h5D : mul0D = 8'hEC;
      8'h5E : mul0D = 8'hFB;
      8'h5F : mul0D = 8'hF6;
      
		8'h60 : mul0D = 8'hD6;
      8'h61 : mul0D = 8'hDB;
      8'h62 : mul0D = 8'hCC;
      8'h63 : mul0D = 8'hC1;
      8'h64 : mul0D = 8'hE2;
      8'h65 : mul0D = 8'hEF;
      8'h66 : mul0D = 8'hF8;
      8'h67 : mul0D = 8'hF5;
      
		8'h68 : mul0D = 8'hBE;
      8'h69 : mul0D = 8'hB3;
      8'h6A : mul0D = 8'hA4;
      8'h6B : mul0D = 8'hA9;
      8'h6C : mul0D = 8'h8A;
      8'h6D : mul0D = 8'h87;
      8'h6E : mul0D = 8'h90;
      8'h6F : mul0D = 8'h9D;
      
		8'h70 : mul0D = 8'h06;
      8'h71 : mul0D = 8'h0B;
      8'h72 : mul0D = 8'h1C;
      8'h73 : mul0D = 8'h11;
      8'h74 : mul0D = 8'h32;
      8'h75 : mul0D = 8'h3F;
      8'h76 : mul0D = 8'h28;
      8'h77 : mul0D = 8'h25;
      
		8'h78 : mul0D = 8'h6E;
      8'h79 : mul0D = 8'h63;
      8'h7A : mul0D = 8'h74;
      8'h7B : mul0D = 8'h79;
      8'h7C : mul0D = 8'h5A;
      8'h7D : mul0D = 8'h57;
      8'h7E : mul0D = 8'h40;
      8'h7F : mul0D = 8'h4D;
      
		8'h80 : mul0D = 8'hDA;
      8'h81 : mul0D = 8'hD7;
      8'h82 : mul0D = 8'hC0;
      8'h83 : mul0D = 8'hCD;
      8'h84 : mul0D = 8'hEE;
      8'h85 : mul0D = 8'hE3;
      8'h86 : mul0D = 8'hF4;
      8'h87 : mul0D = 8'hF9;
      
		8'h88 : mul0D = 8'hB2;
      8'h89 : mul0D = 8'hBF;
      8'h8A : mul0D = 8'hA8;
      8'h8B : mul0D = 8'hA5;
      8'h8C : mul0D = 8'h86;
      8'h8D : mul0D = 8'h8B;
      8'h8E : mul0D = 8'h9C;
      8'h8F : mul0D = 8'h91;
      
		8'h90 : mul0D = 8'h0A;
      8'h91 : mul0D = 8'h07;
      8'h92 : mul0D = 8'h10;
      8'h93 : mul0D = 8'h1D;
      8'h94 : mul0D = 8'h3E;
      8'h95 : mul0D = 8'h33;
      8'h96 : mul0D = 8'h24;
      8'h97 : mul0D = 8'h29;
      
		8'h98 : mul0D = 8'h62;
      8'h99 : mul0D = 8'h6F;
      8'h9A : mul0D = 8'h78;
      8'h9B : mul0D = 8'h75;
      8'h9C : mul0D = 8'h56;
      8'h9D : mul0D = 8'h5B;
      8'h9E : mul0D = 8'h4C;
      8'h9F : mul0D = 8'h41;
     
	   8'hA0 : mul0D = 8'h61;
      8'hA1 : mul0D = 8'h6C;
      8'hA2 : mul0D = 8'h7B;
      8'hA3 : mul0D = 8'h76;
      8'hA4 : mul0D = 8'h55;
      8'hA5 : mul0D = 8'h58;
      8'hA6 : mul0D = 8'h4F;
      8'hA7 : mul0D = 8'h42;
     
	   8'hA8 : mul0D = 8'h09;
      8'hA9 : mul0D = 8'h04;
      8'hAA : mul0D = 8'h13;
      8'hAB : mul0D = 8'h1E;
      8'hAC : mul0D = 8'h3D;
      8'hAD : mul0D = 8'h30;
      8'hAE : mul0D = 8'h27;
      8'hAF : mul0D = 8'h2A;
      
		8'hB0 : mul0D = 8'hB1;
      8'hB1 : mul0D = 8'hBC;
      8'hB2 : mul0D = 8'hAB;
      8'hB3 : mul0D = 8'hA6;
      8'hB4 : mul0D = 8'h85;
      8'hB5 : mul0D = 8'h88;
      8'hB6 : mul0D = 8'h9F;
      8'hB7 : mul0D = 8'h92;
      
		8'hB8 : mul0D = 8'hD9;
      8'hB9 : mul0D = 8'hD4;
      8'hBA : mul0D = 8'hC3;
      8'hBB : mul0D = 8'hCE;
      8'hBC : mul0D = 8'hED;
      8'hBD : mul0D = 8'hE0;
      8'hBE : mul0D = 8'hF7;
      8'hBF : mul0D = 8'hFA;
     
	   8'hC0 : mul0D = 8'hB7;
      8'hC1 : mul0D = 8'hBA;
      8'hC2 : mul0D = 8'hAD;
      8'hC3 : mul0D = 8'hA0;
      8'hC4 : mul0D = 8'h83;
      8'hC5 : mul0D = 8'h8E;
      8'hC6 : mul0D = 8'h99;
      8'hC7 : mul0D = 8'h94;
      
		8'hC8 : mul0D = 8'hDF;
      8'hC9 : mul0D = 8'hD2;
      8'hCA : mul0D = 8'hC5;
      8'hCB : mul0D = 8'hC8;
      8'hCC : mul0D = 8'hEB;
      8'hCD : mul0D = 8'hE6;
      8'hCE : mul0D = 8'hF1;
      8'hCF : mul0D = 8'hFC;
      
		8'hD0 : mul0D = 8'h67;
      8'hD1 : mul0D = 8'h6A;
      8'hD2 : mul0D = 8'h7D;
      8'hD3 : mul0D = 8'h70;
      8'hD4 : mul0D = 8'h53;
      8'hD5 : mul0D = 8'h5E;
      8'hD6 : mul0D = 8'h49;
      8'hD7 : mul0D = 8'h44;
     
	   8'hD8 : mul0D = 8'h0F;
      8'hD9 : mul0D = 8'h02;
      8'hDA : mul0D = 8'h15;
      8'hDB : mul0D = 8'h18;
      8'hDC : mul0D = 8'h3B;
      8'hDD : mul0D = 8'h36;
      8'hDE : mul0D = 8'h21;
      8'hDF : mul0D = 8'h2C;
      
		8'hE0 : mul0D = 8'h0C;
      8'hE1 : mul0D = 8'h01;
      8'hE2 : mul0D = 8'h16;
      8'hE3 : mul0D = 8'h1B;
      8'hE4 : mul0D = 8'h38;
      8'hE5 : mul0D = 8'h35;
      8'hE6 : mul0D = 8'h22;
      8'hE7 : mul0D = 8'h2F;
      
		8'hE8 : mul0D = 8'h64;
      8'hE9 : mul0D = 8'h69;
      8'hEA : mul0D = 8'h7E;
      8'hEB : mul0D = 8'h73;
      8'hEC : mul0D = 8'h50;
      8'hED : mul0D = 8'h5D;
      8'hEE : mul0D = 8'h4A;
      8'hEF : mul0D = 8'h47;
     
	   8'hF0 : mul0D = 8'hDC;
      8'hF1 : mul0D = 8'hD1;
      8'hF2 : mul0D = 8'hC6;
      8'hF3 : mul0D = 8'hCB;
      8'hF4 : mul0D = 8'hE8;
      8'hF5 : mul0D = 8'hE5;
      8'hF6 : mul0D = 8'hF2;
      8'hF7 : mul0D = 8'hFF;
      
		8'hF8 : mul0D = 8'hB4;
      8'hF9 : mul0D = 8'hB9;
      8'hFA : mul0D = 8'hAE;
      8'hFB : mul0D = 8'hA3;
      8'hFC : mul0D = 8'h80;
      8'hFD : mul0D = 8'h8D;
      8'hFE : mul0D = 8'h9A;
      8'hFF : mul0D = 8'h97;
      default : mul0D = 0;
    endcase
  endfunction
 
  //This function stores the tables holding the results of performing the
  //multiplication in GF(256) of any number by 0x0E
  function [7:0] mul0E;
    input [7:0] x;
 
    case (x)
      8'h00 : mul0E = 8'h00;
      8'h01 : mul0E = 8'h0E;
      8'h02 : mul0E = 8'h1C;
      8'h03 : mul0E = 8'h12;
      8'h04 : mul0E = 8'h38;
      8'h05 : mul0E = 8'h36;
      8'h06 : mul0E = 8'h24;
      8'h07 : mul0E = 8'h2A;
      
		8'h08 : mul0E = 8'h70;
      8'h09 : mul0E = 8'h7E;
      8'h0A : mul0E = 8'h6C;
      8'h0B : mul0E = 8'h62;
      8'h0C : mul0E = 8'h48;
      8'h0D : mul0E = 8'h46;
      8'h0E : mul0E = 8'h54;
      8'h0F : mul0E = 8'h5A;
     
	   8'h10 : mul0E = 8'hE0;
      8'h11 : mul0E = 8'hEE;
      8'h12 : mul0E = 8'hFC;
      8'h13 : mul0E = 8'hF2;
      8'h14 : mul0E = 8'hD8;
      8'h15 : mul0E = 8'hD6;
      8'h16 : mul0E = 8'hC4;
      8'h17 : mul0E = 8'hCA;
     
	   8'h18 : mul0E = 8'h90;
      8'h19 : mul0E = 8'h9E;
      8'h1A : mul0E = 8'h8C;
      8'h1B : mul0E = 8'h82;
      8'h1C : mul0E = 8'hA8;
      8'h1D : mul0E = 8'hA6;
      8'h1E : mul0E = 8'hB4;
      8'h1F : mul0E = 8'hBA;
     
	   8'h20 : mul0E = 8'hDB;
      8'h21 : mul0E = 8'hD5;
      8'h22 : mul0E = 8'hC7;
      8'h23 : mul0E = 8'hC9;
      8'h24 : mul0E = 8'hE3;
      8'h25 : mul0E = 8'hED;
      8'h26 : mul0E = 8'hFF;
      8'h27 : mul0E = 8'hF1;
    
   	8'h28 : mul0E = 8'hAB;
      8'h29 : mul0E = 8'hA5;
      8'h2A : mul0E = 8'hB7;
      8'h2B : mul0E = 8'hB9;
      8'h2C : mul0E = 8'h93;
      8'h2D : mul0E = 8'h9D;
      8'h2E : mul0E = 8'h8F;
      8'h2F : mul0E = 8'h81;
     
	   8'h30 : mul0E = 8'h3B;
      8'h31 : mul0E = 8'h35;
      8'h32 : mul0E = 8'h27;
      8'h33 : mul0E = 8'h29;
      8'h34 : mul0E = 8'h03;
      8'h35 : mul0E = 8'h0D;
      8'h36 : mul0E = 8'h1F;
      8'h37 : mul0E = 8'h11;
     
	   8'h38 : mul0E = 8'h4B;
      8'h39 : mul0E = 8'h45;
      8'h3A : mul0E = 8'h57;
      8'h3B : mul0E = 8'h59;
      8'h3C : mul0E = 8'h73;
      8'h3D : mul0E = 8'h7D;
      8'h3E : mul0E = 8'h6F;
      8'h3F : mul0E = 8'h61;
     
	   8'h40 : mul0E = 8'hAD;
      8'h41 : mul0E = 8'hA3;
      8'h42 : mul0E = 8'hB1;
      8'h43 : mul0E = 8'hBF;
      8'h44 : mul0E = 8'h95;
      8'h45 : mul0E = 8'h9B;
      8'h46 : mul0E = 8'h89;
      8'h47 : mul0E = 8'h87;
     
	   8'h48 : mul0E = 8'hDD;
      8'h49 : mul0E = 8'hD3;
      8'h4A : mul0E = 8'hC1;
      8'h4B : mul0E = 8'hCF;
      8'h4C : mul0E = 8'hE5;
      8'h4D : mul0E = 8'hEB;
      8'h4E : mul0E = 8'hF9;
      8'h4F : mul0E = 8'hF7;
     
	   8'h50 : mul0E = 8'h4D;
      8'h51 : mul0E = 8'h43;
      8'h52 : mul0E = 8'h51;
      8'h53 : mul0E = 8'h5F;
      8'h54 : mul0E = 8'h75;
      8'h55 : mul0E = 8'h7B;
      8'h56 : mul0E = 8'h69;
      8'h57 : mul0E = 8'h67;
      
		8'h58 : mul0E = 8'h3D;
      8'h59 : mul0E = 8'h33;
      8'h5A : mul0E = 8'h21;
      8'h5B : mul0E = 8'h2F;
      8'h5C : mul0E = 8'h05;
      8'h5D : mul0E = 8'h0B;
      8'h5E : mul0E = 8'h19;
      8'h5F : mul0E = 8'h17;
      
		8'h60 : mul0E = 8'h76;
      8'h61 : mul0E = 8'h78;
      8'h62 : mul0E = 8'h6A;
      8'h63 : mul0E = 8'h64;
      8'h64 : mul0E = 8'h4E;
      8'h65 : mul0E = 8'h40;
      8'h66 : mul0E = 8'h52;
      8'h67 : mul0E = 8'h5C;
      
		8'h68 : mul0E = 8'h06;
      8'h69 : mul0E = 8'h08;
      8'h6A : mul0E = 8'h1A;
      8'h6B : mul0E = 8'h14;
      8'h6C : mul0E = 8'h3E;
      8'h6D : mul0E = 8'h30;
      8'h6E : mul0E = 8'h22;
      8'h6F : mul0E = 8'h2C;
      
		8'h70 : mul0E = 8'h96;
      8'h71 : mul0E = 8'h98;
      8'h72 : mul0E = 8'h8A;
      8'h73 : mul0E = 8'h84;
      8'h74 : mul0E = 8'hAE;
      8'h75 : mul0E = 8'hA0;
      8'h76 : mul0E = 8'hB2;
      8'h77 : mul0E = 8'hBC;
     
	   8'h78 : mul0E = 8'hE6;
      8'h79 : mul0E = 8'hE8;
      8'h7A : mul0E = 8'hFA;
      8'h7B : mul0E = 8'hF4;
      8'h7C : mul0E = 8'hDE;
      8'h7D : mul0E = 8'hD0;
      8'h7E : mul0E = 8'hC2;
      8'h7F : mul0E = 8'hCC;
     
	   8'h80 : mul0E = 8'h41;
      8'h81 : mul0E = 8'h4F;
      8'h82 : mul0E = 8'h5D;
      8'h83 : mul0E = 8'h53;
      8'h84 : mul0E = 8'h79;
      8'h85 : mul0E = 8'h77;
      8'h86 : mul0E = 8'h65;
      8'h87 : mul0E = 8'h6B;
     
	   8'h88 : mul0E = 8'h31;
      8'h89 : mul0E = 8'h3F;
      8'h8A : mul0E = 8'h2D;
      8'h8B : mul0E = 8'h23;
      8'h8C : mul0E = 8'h09;
      8'h8D : mul0E = 8'h07;
      8'h8E : mul0E = 8'h15;
      8'h8F : mul0E = 8'h1B;
      
		8'h90 : mul0E = 8'hA1;
      8'h91 : mul0E = 8'hAF;
      8'h92 : mul0E = 8'hBD;
      8'h93 : mul0E = 8'hB3;
      8'h94 : mul0E = 8'h99;
      8'h95 : mul0E = 8'h97;
      8'h96 : mul0E = 8'h85;
      8'h97 : mul0E = 8'h8B;
      
		8'h98 : mul0E = 8'hD1;
      8'h99 : mul0E = 8'hDF;
      8'h9A : mul0E = 8'hCD;
      8'h9B : mul0E = 8'hC3;
      8'h9C : mul0E = 8'hE9;
      8'h9D : mul0E = 8'hE7;
      8'h9E : mul0E = 8'hF5;
      8'h9F : mul0E = 8'hFB;
     
	   8'hA0 : mul0E = 8'h9A;
      8'hA1 : mul0E = 8'h94;
      8'hA2 : mul0E = 8'h86;
      8'hA3 : mul0E = 8'h88;
      8'hA4 : mul0E = 8'hA2;
      8'hA5 : mul0E = 8'hAC;
      8'hA6 : mul0E = 8'hBE;
      8'hA7 : mul0E = 8'hB0;
      
		8'hA8 : mul0E = 8'hEA;
      8'hA9 : mul0E = 8'hE4;
      8'hAA : mul0E = 8'hF6;
      8'hAB : mul0E = 8'hF8;
      8'hAC : mul0E = 8'hD2;
      8'hAD : mul0E = 8'hDC;
      8'hAE : mul0E = 8'hCE;
      8'hAF : mul0E = 8'hC0;
      
		8'hB0 : mul0E = 8'h7A;
      8'hB1 : mul0E = 8'h74;
      8'hB2 : mul0E = 8'h66;
      8'hB3 : mul0E = 8'h68;
      8'hB4 : mul0E = 8'h42;
      8'hB5 : mul0E = 8'h4C;
      8'hB6 : mul0E = 8'h5E;
      8'hB7 : mul0E = 8'h50;
     
	   8'hB8 : mul0E = 8'h0A;
      8'hB9 : mul0E = 8'h04;
      8'hBA : mul0E = 8'h16;
      8'hBB : mul0E = 8'h18;
      8'hBC : mul0E = 8'h32;
      8'hBD : mul0E = 8'h3C;
      8'hBE : mul0E = 8'h2E;
      8'hBF : mul0E = 8'h20;
      
		8'hC0 : mul0E = 8'hEC;
      8'hC1 : mul0E = 8'hE2;
      8'hC2 : mul0E = 8'hF0;
      8'hC3 : mul0E = 8'hFE;
      8'hC4 : mul0E = 8'hD4;
      8'hC5 : mul0E = 8'hDA;
      8'hC6 : mul0E = 8'hC8;
      8'hC7 : mul0E = 8'hC6;
      
		8'hC8 : mul0E = 8'h9C;
      8'hC9 : mul0E = 8'h92;
      8'hCA : mul0E = 8'h80;
      8'hCB : mul0E = 8'h8E;
      8'hCC : mul0E = 8'hA4;
      8'hCD : mul0E = 8'hAA;
      8'hCE : mul0E = 8'hB8;
      8'hCF : mul0E = 8'hB6;
      
		8'hD0 : mul0E = 8'h0C;
      8'hD1 : mul0E = 8'h02;
      8'hD2 : mul0E = 8'h10;
      8'hD3 : mul0E = 8'h1E;
      8'hD4 : mul0E = 8'h34;
      8'hD5 : mul0E = 8'h3A;
      8'hD6 : mul0E = 8'h28;
      8'hD7 : mul0E = 8'h26;
      
		8'hD8 : mul0E = 8'h7C;
      8'hD9 : mul0E = 8'h72;
      8'hDA : mul0E = 8'h60;
      8'hDB : mul0E = 8'h6E;
      8'hDC : mul0E = 8'h44;
      8'hDD : mul0E = 8'h4A;
      8'hDE : mul0E = 8'h58;
      8'hDF : mul0E = 8'h56;
     
	   8'hE0 : mul0E = 8'h37;
      8'hE1 : mul0E = 8'h39;
      8'hE2 : mul0E = 8'h2B;
      8'hE3 : mul0E = 8'h25;
      8'hE4 : mul0E = 8'h0F;
      8'hE5 : mul0E = 8'h01;
      8'hE6 : mul0E = 8'h13;
      8'hE7 : mul0E = 8'h1D;
     
	   8'hE8 : mul0E = 8'h47;
      8'hE9 : mul0E = 8'h49;
      8'hEA : mul0E = 8'h5B;
      8'hEB : mul0E = 8'h55;
      8'hEC : mul0E = 8'h7F;
      8'hED : mul0E = 8'h71;
      8'hEE : mul0E = 8'h63;
      8'hEF : mul0E = 8'h6D;
      
		8'hF0 : mul0E = 8'hD7;
      8'hF1 : mul0E = 8'hD9;
      8'hF2 : mul0E = 8'hCB;
      8'hF3 : mul0E = 8'hC5;
      8'hF4 : mul0E = 8'hEF;
      8'hF5 : mul0E = 8'hE1;
      8'hF6 : mul0E = 8'hF3;
      8'hF7 : mul0E = 8'hFD;
      
		8'hF8 : mul0E = 8'hA7;
      8'hF9 : mul0E = 8'hA9;
      8'hFA : mul0E = 8'hBB;
      8'hFB : mul0E = 8'hB5;
      8'hFC : mul0E = 8'h9F;
      8'hFD : mul0E = 8'h91;
      8'hFE : mul0E = 8'h83;
      8'hFF : mul0E = 8'h8D;
      default : mul0E = 0;
    endcase
  endfunction
 
endmodule


