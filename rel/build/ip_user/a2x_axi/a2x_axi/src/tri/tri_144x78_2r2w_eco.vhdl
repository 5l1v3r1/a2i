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
use ibm.std_ulogic_support.all;
use support.power_logic_pkg.all;
use tri.tri_latches_pkg.all;

entity tri_144x78_2r2w_eco is
generic(
   expand_type                         :     integer :=  1);
port (
   vdd                            :inout power_logic;    
   gnd                            :inout power_logic;    
   nclk                           :in   clk_logic;                 
   abist_en                       :in   std_ulogic;  
   abist_raw_dc_b                 :in   std_ulogic;  
   r0e_abist_comp_en              :in   std_ulogic;  
   r1e_abist_comp_en              :in   std_ulogic;  
   lbist_en                      :in   std_ulogic;  

   lcb_act_dis_dc                 :in   std_ulogic; 
   lcb_clkoff_dc_b                :in   std_ulogic_vector(0 to 1);
   lcb_d_mode_dc                  :in   std_ulogic;
   lcb_delay_lclkr_dc             :in   std_ulogic_vector(0 to 9); 
   lcb_fce_0                      :in   std_ulogic; 
   lcb_mpw1_dc_b                  :in   std_ulogic_vector(1 to 9); 
   lcb_mpw2_dc_b                  :in   std_ulogic; 
   lcb_scan_diag_dc               :in   std_ulogic; 
   lcb_scan_dis_dc_b              :in   std_ulogic; 
   lcb_sg_0                       :in   std_ulogic; 
   lcb_time_sg_0                  :in   std_ulogic;

   lcb_obs0_sg_0                  :in   std_ulogic; 
   lcb_obs1_sg_0                  :in   std_ulogic; 
   lcb_obs0_sl_thold_0            :in   std_ulogic; 
   lcb_obs1_sl_thold_0            :in   std_ulogic; 

   lcb_abst_sl_thold_0            :in   std_ulogic;  
   lcb_time_sl_thold_0            :in   std_ulogic; 
   lcb_ary_nsl_thold_0            :in   std_ulogic;  

   r_scan_in                      :in   std_ulogic;                 
   r_scan_out                     :out  std_ulogic;   
   w_scan_in                      :in   std_ulogic;                 
   w_scan_out                     :out  std_ulogic;   
   time_scan_in                   :in   std_ulogic; 
   time_scan_out                  :out  std_ulogic; 
   obs0_scan_in                   :in   std_ulogic; 
   obs0_scan_out                  :out  std_ulogic; 
   obs1_scan_in                   :in   std_ulogic; 
   obs1_scan_out                  :out  std_ulogic; 

   lcb_bolt_sl_thold_0            :in   std_ulogic;
   pc_bo_enable_2                 :in   std_ulogic; 
   pc_bo_reset                    :in   std_ulogic; 
   pc_bo_unload                   :in   std_ulogic;
   pc_bo_load                     :in   std_ulogic;
   pc_bo_shdata                   :in   std_ulogic; 
   pc_bo_select                   :in   std_ulogic; 
   bo_pc_failout                  :out  std_ulogic; 
   bo_pc_diagloop                 :out  std_ulogic;
   tri_lcb_mpw1_dc_b              :in    std_ulogic;
   tri_lcb_mpw2_dc_b              :in    std_ulogic;
   tri_lcb_delay_lclkr_dc         :in    std_ulogic;
   tri_lcb_clkoff_dc_b            :in    std_ulogic;
   tri_lcb_act_dis_dc             :in    std_ulogic;

   r0e_act                        :in   std_ulogic;                 
   r0e_en_func                    :in   std_ulogic;                 
   r0e_en_abist                   :in   std_ulogic;                 
   r0e_addr_func                  :in   std_ulogic_vector(0 to 7);  
   r0e_addr_abist                 :in   std_ulogic_vector(0 to 7);   
   r0e_data_out                   :out  std_ulogic_vector(0 to 77); 
   r0e_byp_e                      :in   std_ulogic; 
   r0e_byp_l                      :in   std_ulogic; 
   r0e_byp_r                      :in   std_ulogic;
   r0e_sel_lbist                  :in   std_ulogic; 

   r1e_act                        :in   std_ulogic;                 
   r1e_en_func                    :in   std_ulogic;                 
   r1e_en_abist                   :in   std_ulogic;                 
   r1e_addr_func                  :in   std_ulogic_vector(0 to 7);  
   r1e_addr_abist                 :in   std_ulogic_vector(0 to 7);   
   r1e_data_out                   :out  std_ulogic_vector(0 to 77);
   r1e_byp_e                      :in   std_ulogic; 
   r1e_byp_l                      :in   std_ulogic; 
   r1e_byp_r                      :in   std_ulogic;
   r1e_sel_lbist                  :in   std_ulogic; 

   w0e_act                        :in   std_ulogic;                 
   w0e_en_func                    :in   std_ulogic;                 
   w0e_en_abist                   :in   std_ulogic;                 
   w0e_addr_func                  :in   std_ulogic_vector(0 to 7);  
   w0e_addr_abist                 :in   std_ulogic_vector(0 to 7);  
   w0e_data_func                  :in   std_ulogic_vector(0 to 77); 
   w0e_data_abist                 :in   std_ulogic_vector(0 to 3);

   w0l_act                        :in   std_ulogic;                 
   w0l_en_func                    :in   std_ulogic;                 
   w0l_en_abist                   :in   std_ulogic;                 
   w0l_addr_func                  :in   std_ulogic_vector(0 to 7);  
   w0l_addr_abist                 :in   std_ulogic_vector(0 to 7);  
   w0l_data_func                  :in   std_ulogic_vector(0 to 77); 
   w0l_data_abist                 :in   std_ulogic_vector(0 to 3) );

  -- synopsys translate_off
  -- synopsys translate_on

end entity   tri_144x78_2r2w_eco;
architecture tri_144x78_2r2w_eco of tri_144x78_2r2w_eco is

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

signal  tilo                           : std_ulogic;
signal  tihi                           : std_ulogic;
signal  zeross                         : std_logic_vector(0 to 3); 

signal  correct_clk                    : std_ulogic;
signal  clk2x                          : std_ulogic;
signal  reset                          : std_ulogic;
signal  reset_hi                       : std_ulogic;
signal  reset_lo                       : std_ulogic;
signal  reset_q                        : std_ulogic;
signal  sinit0_q        : std_logic;
signal  sinit1_q        : std_logic;
signal  flipper_d                      : std_ulogic;
signal  flipper_q                      : std_ulogic;

signal  doutb0                         : std_logic_vector(0 to 77);
signal  doutb0_q                       : std_ulogic_vector(0 to 77);
signal dinfa0_par                      : std_logic_vector(64 to 95);
signal doutb0_par                      : std_logic_vector(64 to 95);
signal  weaf                           : std_logic;
signal  addra                          : std_logic_vector(0 to 8); 
signal  addrb0                         : std_logic_vector(0 to 8); 
signal  dinfa                          : std_logic_vector(0 to 77); 
signal  dinfb                          : std_logic_vector(0 to 31); 

signal  w0e_data_q                     : std_ulogic_vector(0 to 77);
signal  w0l_data_q                     : std_ulogic_vector(0 to 77);
signal  w0l_en_q                       : std_ulogic;
signal  w0l_addr_q                     : std_ulogic_vector(0 to 7);
signal  r1e_addr_q                     : std_ulogic_vector(0 to 7);

signal   r0e_byp_e_q                   :   std_ulogic; 
signal   r0e_byp_l_q                   :   std_ulogic; 
signal   r1e_byp_e_q                   :   std_ulogic; 
signal   r1e_byp_l_q                   :   std_ulogic; 
signal   r0_byp_sel                    :   std_ulogic_vector(0 to 1);
signal   r1_byp_sel                    :   std_ulogic_vector(0 to 1);

signal unused           : std_ulogic;
-- synopsys translate_off
-- synopsys translate_on

begin

   tilo      <= '0';
   tihi      <= '1';
   zeross    <= (0 to 3  => '0');

       reset       <= nclk.sreset;
       correct_clk <= nclk.clk;
       clk2x       <= nclk.clk2x;

       reset_hi    <=     reset;
       reset_lo    <= not reset_q after 1 ns ;


   flipper_d <= not flipper_q;

   slatch: process (correct_clk,reset) begin
   if rising_edge(correct_clk) then
    if (reset = '1') then
      w0l_en_q    <= '0';
      r1e_addr_q  <= (others => '0');
      r0e_byp_e_q  <= '0';
      r0e_byp_l_q  <= '0';
      r1e_byp_e_q  <= '0';
      r1e_byp_l_q  <= '0';

    else
      w0e_data_q   <= w0e_data_func;
      w0l_data_q   <= w0l_data_func;
      w0l_en_q     <= w0l_en_func;
      w0l_addr_q   <= w0l_addr_func;
      r1e_addr_q   <= r1e_addr_func;
      r0e_byp_e_q  <= r0e_byp_e;
      r0e_byp_l_q  <= r0e_byp_l;
      r1e_byp_e_q  <= r1e_byp_e;
      r1e_byp_l_q  <= r1e_byp_l;

    end if;
   end if;
   end process;

   flatch: process (clk2x,reset_lo) begin
  if clk2x'event and clk2x = '1' then
    if (reset_lo = '0') then
      flipper_q  <= '0';

    else
      flipper_q    <= flipper_d;
      doutb0_q     <= tconv(doutb0);

    end if;
   end if;
   end process;

   rlatch: process (correct_clk) begin
    if(rising_edge(correct_clk)) then
      reset_q   <= reset_hi;
      sinit0_q  <= reset_hi;
      sinit1_q  <= reset_hi;
    end if;
   end process;


   addra(0)       <= '0';
   addra(1 to 8)  <= (tconv((w0e_addr_func and (0 to  7 => flipper_q)) or (w0l_addr_q and (0 to  7 => not flipper_q))))  after 1 ns ; 
   weaf           <= ((      w0e_en_func   and             flipper_q)  or (  w0l_en_q and             not  flipper_q))   after 1 ns;
   dinfa          <= (tconv((w0e_data_func and (0 to 77 => flipper_q)) or (w0l_data_q and (0 to 77 => not flipper_q))))  after 1 ns;
 
   dinfb          <= (others => '0');
   addrb0(0)      <= '0';
   addrb0(1 to 8) <= (tconv((r0e_addr_func and (0 to 7 => flipper_q)) or (r1e_addr_q  and (0 to 7 => not flipper_q)))) after 1 ns ;  

   r0_byp_sel <= r0e_byp_e & r0e_byp_l;
   with r0_byp_sel select 
   r0e_data_out   <= w0e_data_q when "10",
                     w0l_data_q when "01",
                     doutb0_q   when others;

   r1_byp_sel <= r1e_byp_e & r1e_byp_l;
   with r1_byp_sel select 
   r1e_data_out   <= w0e_data_q when "10",
                     w0l_data_q when "01",
                     tconv(doutb0) when others;


U0 : RAMB16_S36_S36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
	port map 
	(
		DOA   => open,
		DOB   => doutb0(0 to 31),
		DOPA  => open,
		DOPB  => open,
		ADDRA => addra,
		ADDRB => addrb0,
		CLKA  => clk2x,
		CLKB  => clk2x,
		DIA   => dinfa(0 to 31),
		DIB   => dinfb,
		DIPA  => zeross,
		DIPB  => zeross,
		ENA   => tihi,
		ENB   => tihi,
		SSRA  => sinit0_q,
		SSRB  => sinit0_q,
		WEA   => weaf,
		WEB   => tilo
	);
U1 : RAMB16_S36_S36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on

	port map 
	(
		DOA   => open,
		DOB   => doutb0(32 to 63),
		DOPA  => open,
		DOPB  => open,
		ADDRA => addra,
		ADDRB => addrb0,
		CLKA  => clk2x,
		CLKB  => clk2x,
		DIA   => dinfa(32 to 63),
		DIB   => dinfb,
		DIPA  => zeross,
		DIPB  => zeross,
		ENA   => tihi,
		ENB   => tihi,
		SSRA  => sinit1_q,
		SSRB  => sinit1_q,
		WEA   => weaf,
		WEB   => tilo
	);

doutb0(64 to 77)     <= doutb0_par(64 to 77);
dinfa0_par(64 to 95) <= dinfa(64 to 77) & (78 to 95 => '0');

U2 : RAMB16_S36_S36
-- pragma translate_off
generic map(
   sim_collision_check => "none")
-- pragma translate_on
	port map 
	(
		DOA   => open,
		DOB   => doutb0_par(64 to 95),
		DOPA  => open,
		DOPB  => open,
		ADDRA => addra,
		ADDRB => addrb0,
		CLKA  => clk2x,
		CLKB  => clk2x,
		DIA   => dinfa0_par(64 to 95),
		DIB   => dinfb,
		DIPA  => zeross,
		DIPB  => zeross,
		ENA   => tihi,
		ENB   => tihi,
		SSRA  => sinit1_q,
		SSRB  => sinit1_q,
		WEA   => weaf,
		WEB   => tilo
	);

r_scan_out <= '0';
w_scan_out <= '0';
time_scan_out <= '0';
obs0_scan_out <= '0';
obs1_scan_out <= '0';

bo_pc_failout <= '0';
bo_pc_diagloop <= '0';

unused <= or_reduce( std_ulogic_vector(doutb0_par(78 to 95))
                     & abist_en & abist_raw_dc_b & r0e_abist_comp_en & r1e_abist_comp_en
                     & lbist_en & lcb_act_dis_dc & lcb_clkoff_dc_b & lcb_d_mode_dc
                     & lcb_delay_lclkr_dc & lcb_fce_0 & lcb_mpw1_dc_b & lcb_mpw2_dc_b
                     & lcb_scan_diag_dc & lcb_scan_dis_dc_b & lcb_sg_0 & lcb_time_sg_0
                     & lcb_obs0_sg_0 & lcb_obs1_sg_0 & lcb_obs0_sl_thold_0 & lcb_obs1_sl_thold_0
                     & lcb_abst_sl_thold_0 & lcb_time_sl_thold_0 & lcb_ary_nsl_thold_0
                     & r_scan_in & w_scan_in & time_scan_in & obs0_scan_in & obs1_scan_in
                     & r0e_act & r0e_en_func & r0e_en_abist & r0e_addr_abist & r0e_byp_r & r0e_sel_lbist
                     & r1e_act & r1e_en_func & r1e_en_abist & r1e_addr_abist & r1e_byp_r & r1e_sel_lbist
                     & w0e_act & w0e_en_abist & w0e_addr_abist & w0e_data_abist
                     & w0l_act & w0l_en_abist & w0l_addr_abist & w0l_data_abist
                     & lcb_bolt_sl_thold_0 & pc_bo_enable_2 & pc_bo_reset
                     & pc_bo_unload & pc_bo_load & pc_bo_shdata & pc_bo_select
                     & tri_lcb_mpw1_dc_b & tri_lcb_mpw2_dc_b & tri_lcb_delay_lclkr_dc
                     & tri_lcb_clkoff_dc_b & tri_lcb_act_dis_dc );

end generate;

end architecture tri_144x78_2r2w_eco;
