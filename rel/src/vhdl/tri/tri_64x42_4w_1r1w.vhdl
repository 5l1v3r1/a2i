-- © IBM Corp. 2020
-- This softcore is licensed under and subject to the terms of the CC-BY 4.0
-- license (https://creativecommons.org/licenses/by/4.0/legalcode). 
-- Additional rights, including the right to physically implement a softcore 
-- that is compliant with the required sections of the Power ISA 
-- Specification, will be available at no cost via the OpenPOWER Foundation. 
-- This README will be updated with additional information when OpenPOWER's 
-- license is available.

library ieee,ibm,support,tri;
use ieee.std_logic_1164.all;
use ibm.std_ulogic_function_support.all;
use support.power_logic_pkg.all;
use tri.tri_latches_pkg.all;
-- pragma translate_off
-- pragma translate_on

entity tri_64x42_4w_1r1w is
generic(
   expand_type                         : integer :=  1);
port (
   vdd                                 : INOUT power_logic; 
   vcs                                 : INOUT power_logic; 
   gnd                                 : INOUT power_logic; 

   nclk                                : in clk_logic;
   sg_0                                : in  std_ulogic;
   abst_sl_thold_0                     : in  std_ulogic;
   ary_nsl_thold_0                     : in  std_ulogic;
   time_sl_thold_0                     : in  std_ulogic;
   repr_sl_thold_0                     : in  std_ulogic;

   rd0_act                             : in std_ulogic;
   rd0_adr                             : in std_ulogic_vector(0 to 5);  
   do0                                 : out std_ulogic_vector(0 to 167);
   
   wr_way                              : in std_ulogic_vector (0 to 3);
   wr_act            		       : in std_ulogic;
   wr_adr            		       : in std_ulogic_vector(0 to 5);    		
   di                		       : in std_ulogic_vector(0 to 167);
     
   abst_scan_in                        : in  std_ulogic;
   abst_scan_out                       : out std_ulogic;
   time_scan_in                        : in  std_ulogic;
   time_scan_out                       : out std_ulogic;
   repr_scan_in                        : in  std_ulogic;
   repr_scan_out                       : out std_ulogic;
   
   scan_dis_dc_b                       : in  std_ulogic;
   scan_diag_dc                        : in  std_ulogic;
   ccflush_dc                          : in  std_ulogic;
   ary0_clkoff_dc_b                    : in  std_ulogic;
   ary0_d_mode_dc                      : in  std_ulogic;
   ary0_mpw1_dc_b                      : in  std_ulogic_vector(0 to 4);
   ary0_mpw2_dc_b                      : in  std_ulogic;
   ary0_delay_lclkr_dc                 : in  std_ulogic_vector(0 to 4);
   ary1_clkoff_dc_b                    : in  std_ulogic;
   ary1_d_mode_dc                      : in  std_ulogic;
   ary1_mpw1_dc_b                      : in  std_ulogic_vector(0 to 4);
   ary1_mpw2_dc_b                      : in  std_ulogic;
   ary1_delay_lclkr_dc                 : in  std_ulogic_vector(0 to 4);

   lcb_bolt_sl_thold_0                 : in  std_ulogic;
   pc_bo_enable_2                      : in  std_ulogic; 
   pc_bo_reset                         : in  std_ulogic; 
   pc_bo_unload                        : in  std_ulogic; 
   pc_bo_repair                        : in  std_ulogic; 
   pc_bo_shdata                        : in  std_ulogic; 
   pc_bo_select                        : in  std_ulogic_vector(0 to 1); 
   bo_pc_failout                       : out std_ulogic_vector(0 to 1); 
   bo_pc_diagloop                      : out std_ulogic_vector(0 to 1);
   tri_lcb_mpw1_dc_b                   : in  std_ulogic;
   tri_lcb_mpw2_dc_b                   : in  std_ulogic;
   tri_lcb_delay_lclkr_dc              : in  std_ulogic;
   tri_lcb_clkoff_dc_b                 : in  std_ulogic;
   tri_lcb_act_dis_dc                  : in  std_ulogic;

   abist_di                            : in  std_ulogic_vector(0 to 3);
   abist_bw_odd                        : in  std_ulogic;
   abist_bw_even                       : in  std_ulogic;
   abist_wr_adr                        : in  std_ulogic_vector(0 to 5);
   wr_abst_act                         : in  std_ulogic;
   abist_rd0_adr                       : in  std_ulogic_vector(0 to 5);
   rd0_abst_act                        : in  std_ulogic;
   tc_lbist_ary_wrt_thru_dc            : in  std_ulogic;
   abist_ena_1                         : in  std_ulogic;
   abist_g8t_rd0_comp_ena              : in  std_ulogic;
   abist_raw_dc_b                      : in  std_ulogic;
   obs0_abist_cmp                      : in  std_ulogic_vector(0 to 3)
   );

-- synopsys translate_off
-- synopsys translate_on


end entity tri_64x42_4w_1r1w;
architecture tri_64x42_4w_1r1w of tri_64x42_4w_1r1w is

begin

a : if expand_type = 1 generate

component RAMB16_S36_S36
-- pragma translate_off
generic(
		SIM_COLLISION_CHECK : string := "none"); 
-- pragma translate_on
port(
		DOA : out std_logic_vector(31 downto 0);
		DOB : out std_logic_vector(31 downto 0);
		DOPA : out std_logic_vector(3 downto 0);
		DOPB : out std_logic_vector(3 downto 0);
		ADDRA : in std_logic_vector(8 downto 0);
		ADDRB : in std_logic_vector(8 downto 0);
		CLKA : in std_ulogic;
		CLKB : in std_ulogic;
		DIA : in std_logic_vector(31 downto 0);
		DIB : in std_logic_vector(31 downto 0);
		DIPA : in std_logic_vector(3 downto 0);
		DIPB : in std_logic_vector(3 downto 0);
		ENA : in std_ulogic;
		ENB : in std_ulogic;
		SSRA : in std_ulogic;
		SSRB : in std_ulogic;
		WEA : in std_ulogic;
		WEB : in std_ulogic);
end component;

-- pragma translate_off
-- pragma translate_on

signal clk,             clk2x             : std_ulogic;
signal addra,           addrb             : std_ulogic_vector(0 to 8);
signal wea0, wea1, wea2, wea3             : std_ulogic;
signal web0, web1, web2, web3             : std_ulogic;
signal bdo0, bdo1, bdo2, bdo3             : std_logic_vector(0 to 71);
signal bdi0, bdi1, bdi2, bdi3             : std_ulogic_vector(0 to 71);
signal sreset                             : std_ulogic;
signal tidn                               : std_ulogic_vector(36 to 65);
signal reset_q                            : std_ulogic;
signal gate_fq,         gate_d            : std_ulogic;
signal bdo_d,           bdo_fq            : std_ulogic_vector(0 to 167);

signal toggle_d     : std_ulogic;
signal toggle_q     : std_ulogic;
signal toggle2x_d   : std_ulogic;
signal toggle2x_q   : std_ulogic;

signal unused             : std_ulogic;
-- synopsys translate_off
-- synopsys translate_on

begin

tidn  <= (others=>'0');
clk   <= nclk.clk;
clk2x <= nclk.clk2x;
sreset<= nclk.sreset;

rlatch: process (clk) begin
    if(rising_edge(clk)) then
      reset_q              <= sreset after 10 ps;
    end if;
end process;


tlatch: process (nclk.clk,reset_q)
begin
   if(rising_edge(nclk.clk)) then
      if (reset_q = '1') then
         toggle_q  <= '1';
      else
         toggle_q  <= toggle_d;
      end if;
    end if;
end process;

flatch: process (nclk.clk2x)
begin
   if(rising_edge(nclk.clk2x)) then
      toggle2x_q <= toggle2x_d;
      gate_fq  <= gate_d;
      bdo_fq   <= bdo_d;
   end if;
end process;

toggle_d   <= not toggle_q;
toggle2x_d <= toggle_q;

gate_d <= not(toggle_q xor toggle2x_q);







   bdi0        <= di(0   to  35) & tidn(36 to 65) & di(36  to  41);
   bdi1        <= di(42  to  77) & tidn(36 to 65) & di(78  to  83);
   bdi2        <= di(84  to 119) & tidn(36 to 65) & di(120 to 125);
   bdi3        <= di(126 to 161) & tidn(36 to 65) & di(162 to 167);

bdo_d(0   to  41) <= std_ulogic_vector(bdo0(0 to 35) & bdo0(66 to 71));
bdo_d(42  to  83) <= std_ulogic_vector(bdo1(0 to 35) & bdo1(66 to 71));
bdo_d(84  to 125) <= std_ulogic_vector(bdo2(0 to 35) & bdo2(66 to 71));
bdo_d(126 to 167) <= std_ulogic_vector(bdo3(0 to 35) & bdo3(66 to 71));

do0         <= bdo_fq;

wea0        <= (wr_act and gate_fq and wr_way(0)) after 10 ps;
web0        <= (wr_act and gate_fq and wr_way(0)) after 10 ps;
wea1        <= (wr_act and gate_fq and wr_way(1)) after 10 ps;
web1        <= (wr_act and gate_fq and wr_way(1)) after 10 ps;
wea2        <= (wr_act and gate_fq and wr_way(2)) after 10 ps;
web2        <= (wr_act and gate_fq and wr_way(2)) after 10 ps;
wea3        <= (wr_act and gate_fq and wr_way(3)) after 10 ps;
web3        <= (wr_act and gate_fq and wr_way(3)) after 10 ps;

with gate_fq select
   addra    <= ("00" & wr_adr  & '0') after 10 ps  when '1',
               ("00" & rd0_adr & '0') after 10 ps when others;

with gate_fq select
   addrb    <= ("00" & wr_adr  & '1') after 10 ps when '1',
               ("00" & rd0_adr & '1') after 10 ps when others;

bram0a : ramb16_s36_s36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
port map(
                  clka  => clk2x,
	               clkb  => clk2x,
	               ssra  => sreset,
	               ssrb  => sreset,
	               addra => std_logic_vector(addra),
	               addrb => std_logic_vector(addrb),
	               dia   => std_logic_vector(bdi0(00 to 31)),
	               dipa  => std_logic_vector(bdi0(32 to 35)),
	               dib   => std_logic_vector(bdi0(36 to 67)),
	               dipb  => std_logic_vector(bdi0(68 to 71)),
                  doa   => bdo0(00 to 31),
                  dopa  => bdo0(32 to 35),
                  dob   => bdo0(36 to 67),
                  dopb  => bdo0(68 to 71),
	               ena   => '1',
	               enb   => '1',
	               wea   => wea0,
	               web   => web0
	               );

bram0b : ramb16_s36_s36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
port map(
                  clka  => clk2x,
	               clkb  => clk2x,
	               ssra  => sreset,
	               ssrb  => sreset,
	               addra => std_logic_vector(addra),
	               addrb => std_logic_vector(addrb),
	               dia   => std_logic_vector(bdi1(00 to 31)),
	               dipa  => std_logic_vector(bdi1(32 to 35)),
	               dib   => std_logic_vector(bdi1(36 to 67)),
	               dipb  => std_logic_vector(bdi1(68 to 71)),
                  doa   => bdo1(00 to 31),
                  dopa  => bdo1(32 to 35),
                  dob   => bdo1(36 to 67),
                  dopb  => bdo1(68 to 71),
	               ena   => '1',
	               enb   => '1',
	               wea   => wea1,
	               web   => web1
	               );

bram0c : ramb16_s36_s36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
port map(
                  clka  => clk2x,
	               clkb  => clk2x,
	               ssra  => sreset,
	               ssrb  => sreset,
	               addra => std_logic_vector(addra),
	               addrb => std_logic_vector(addrb),
	               dia   => std_logic_vector(bdi2(00 to 31)),
	               dipa  => std_logic_vector(bdi2(32 to 35)),
	               dib   => std_logic_vector(bdi2(36 to 67)),
	               dipb  => std_logic_vector(bdi2(68 to 71)),
                  doa   => bdo2(00 to 31),
                  dopa  => bdo2(32 to 35),
                  dob   => bdo2(36 to 67),
                  dopb  => bdo2(68 to 71),
	               ena   => '1',
	               enb   => '1',
	               wea   => wea2,
	               web   => web2
	               );


bram0d : ramb16_s36_s36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
port map(
                  clka  => clk2x,
	               clkb  => clk2x,
	               ssra  => sreset,
	               ssrb  => sreset,
	               addra => std_logic_vector(addra),
	               addrb => std_logic_vector(addrb),
	               dia   => std_logic_vector(bdi3(00 to 31)),
	               dipa  => std_logic_vector(bdi3(32 to 35)),
	               dib   => std_logic_vector(bdi3(36 to 67)),
	               dipb  => std_logic_vector(bdi3(68 to 71)),
                  doa   => bdo3(00 to 31),
                  dopa  => bdo3(32 to 35),
                  dob   => bdo3(36 to 67),
                  dopb  => bdo3(68 to 71),
	               ena   => '1',
	               enb   => '1',
	               wea   => wea3,
	               web   => web3
	               );


abst_scan_out  <= abst_scan_in;
time_scan_out  <= time_scan_in;
repr_scan_out  <= repr_scan_in;

bo_pc_failout <= "00";
bo_pc_diagloop <= "00";

unused <= or_reduce( sg_0 & abst_sl_thold_0 & ary_nsl_thold_0 & time_sl_thold_0 & repr_sl_thold_0
                     & ary0_clkoff_dc_b & ary0_d_mode_dc & ary0_mpw1_dc_b & ary0_mpw2_dc_b
                     & ary0_delay_lclkr_dc & ccflush_dc & scan_dis_dc_b & scan_diag_dc
                     & ary1_clkoff_dc_b & ary1_d_mode_dc & ary1_mpw1_dc_b & ary1_mpw2_dc_b
                     & ary1_delay_lclkr_dc & abist_di
                     & abist_bw_odd & abist_bw_even & abist_wr_adr & abist_rd0_adr
                     & wr_abst_act & rd0_abst_act
                     & tc_lbist_ary_wrt_thru_dc & abist_ena_1 & abist_g8t_rd0_comp_ena
                     & abist_raw_dc_b & obs0_abist_cmp & rd0_act
                     & std_ulogic_vector( bdo0(36 to 65) ) & std_ulogic_vector( bdo1(36 to 65) )
                     & std_ulogic_vector( bdo2(36 to 65) ) & std_ulogic_vector( bdo3(36 to 65) )
                     & lcb_bolt_sl_thold_0 & pc_bo_enable_2 & pc_bo_reset
                     & pc_bo_unload & pc_bo_repair & pc_bo_shdata & pc_bo_select
                     & tri_lcb_mpw1_dc_b & tri_lcb_mpw2_dc_b & tri_lcb_delay_lclkr_dc
                     & tri_lcb_clkoff_dc_b & tri_lcb_act_dis_dc );

end generate;

end architecture tri_64x42_4w_1r1w;




