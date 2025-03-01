library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

  entity mem_unit is
    port (
      -- INPUTS
      clk        : in std_logic;
      alu_res_in : in std_logic_vector(15 downto 0);
      rd2        : in std_logic_vector(15 downto 0);
      -- CONTROL SIGNALS
      mem_write : in std_logic;
      -- OUTPUTS
      mem_data    : out std_logic_vector(15 downto 0);
      alu_res_out : out std_logic_vector(15 downto 0)
    );
  end entity;
  
  architecture rtl of mem_unit is

    component ram
    port (
      clk  : in  std_logic;
      wen  : in  std_logic;
      addr : in  std_logic_vector(3  downto 0);
      di   : in  std_logic_vector(15 downto 0);
      do   : out std_logic_vector(15 downto 0)
    );
    end component;


  begin

    ram_inst : ram
    port map (
      clk  => clk,
      wen  => mem_write,
      addr => alu_res_in(3 downto 0),
      di   => rd2,
      do   => mem_data
    );

    alu_res_out <= alu_res_in;    
  
  end architecture;