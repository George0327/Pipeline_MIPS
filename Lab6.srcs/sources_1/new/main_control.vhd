library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;


entity main_control is
  port (
    -- input 
    op_code : in std_logic_vector(2 downto 0);
    -- output
    reg_dst : out std_logic;
    ext_op : out std_logic;
    alu_src : out std_logic;
    branch : out std_logic;
    jump : out std_logic;
    alu_op : out std_logic_vector(2 downto 0);
    mem_write : out std_logic;
    mem_to_reg : out std_logic;
    reg_write : out std_logic
  );
end main_control;

architecture Behavioral of main_control is

begin

  process(op_code)
  begin
  
    case op_code is
      when "000" =>
        reg_dst    <= '1';
        ext_op     <= '0';
        alu_src    <= '0';
        branch     <= '0';
        jump       <= '0';
        alu_op     <= "000";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '1';
        
      when "001" =>
        reg_dst    <= '0';
        ext_op     <= '1';
        alu_src    <= '1';
        branch     <= '0';
        jump       <= '0';
        alu_op     <= "001";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '1';
 
      when "010" =>
        reg_dst    <= '0';
        ext_op     <= '1';
        alu_src    <= '1';
        branch     <= '0';
        jump       <= '0';
        alu_op     <= "010";
        mem_write  <= '0';
        mem_to_reg <= '1';
        reg_write  <= '1';
 
      when "011" =>
        reg_dst    <= '0';
        ext_op     <= '1';
        alu_src    <= '1';
        branch     <= '0';
        jump       <= '0';
        alu_op     <= "011";
        mem_write  <= '1';
        mem_to_reg <= '0';
        reg_write  <= '0';
 
      when "100" =>
        reg_dst    <= '0';
        ext_op     <= '0';
        alu_src    <= '0';
        branch     <= '1';
        jump       <= '0';
        alu_op     <= "100";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '0';
 
      when "101" =>
        reg_dst    <= '0';
        ext_op     <= '1';
        alu_src    <= '0';
        branch     <= '1';
        jump       <= '0';
        alu_op     <= "101";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '0';

      when "110" =>
        reg_dst    <= '0';
        ext_op     <= '1';
        alu_src    <= '0';
        branch     <= '1';
        jump       <= '0';
        alu_op     <= "110";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '0';
 
      when "111" =>
        reg_dst    <= '0';
        ext_op     <= '0';
        alu_src    <= '0';
        branch     <= '0';
        jump       <= '1';
        alu_op     <= "000";
        mem_write  <= '0';
        mem_to_reg <= '0';
        reg_write  <= '0';
        
      when others =>
        reg_dst <= '0';
        ext_op <= '0';
        alu_src <= '0';
        branch <= '0';
        jump <= '0';
        alu_op <= "000";
        mem_write <= '0';
        mem_to_reg <= '0';
        reg_write <= '0';
    end case;
    
  end process;

end Behavioral;
