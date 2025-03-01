library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity inst_fetch is
  port (
    -- inputs
    clk                   : in  std_logic;
    branch_target_address : in  std_logic_vector(15 downto 0);
    jump_address          : in  std_logic_vector(15 downto 0);
    pc_en                 : in  std_logic;
    pc_reset              : in  std_logic;
    -- control signals
    jump                  : in  std_logic;
    pc_src                : in  std_logic;
    -- outputs
    instruction           : out std_logic_vector(15 downto 0);
    pc_plus_one           : out std_logic_vector(15 downto 0)
  );
end inst_fetch;

architecture Behavioral of inst_fetch is

  type t_rom is array (0 to 255) of std_logic_vector(15 downto 0);
  signal rom : t_rom := (
  --  opc rs  rt  rd sa func
    b"000_001_010_011_0_000", -- x"0530" add $3 <= $1 + $2
    b"000_110_100_010_0_001", -- x"1a21" sub $2 <= $6 - $4
    b"000_000_100_101_1_010", -- sll $5 <= $4 << 1
    b"000_000_100_101_1_011", -- srl $5 <= $4 << 1
    others => (others => '1')
  );
  
  signal s_mux_jmp_out    : std_logic_vector(15 downto 0) := x"0000";
  signal s_pc_out         : std_logic_vector(15 downto 0) := x"0000";
  signal s_adder_out      : std_logic_vector(15 downto 0) := x"0000";
  signal s_mux_branch_out : std_logic_vector(15 downto 0) := x"0000";  

begin

  -- Program Counter (D Flip-Flop with enable + reset)
  process(clk) 
  begin
    if rising_edge(clk) then
      if pc_reset = '1' then
        s_pc_out <= (others => '0');
      elsif pc_en = '1' then 
        s_pc_out <= s_mux_jmp_out;
      end if;
    end if;
  end process;
  
  -- Instruction Memory (ROM) related
  instruction <= rom(conv_integer(s_pc_out(7 downto 0)));
  
  -- Adder related
  s_adder_out <= s_pc_out + 1;
  pc_plus_one <= s_adder_out;
  
  -- MUX for branch
  s_mux_branch_out <= branch_target_address when pc_src = '1' else s_adder_out;
  
  -- MUX for jump
  s_mux_jmp_out <= jump_address when jump = '1' else s_mux_branch_out;


end Behavioral;