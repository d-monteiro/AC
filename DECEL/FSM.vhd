LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FSM_Example IS           -- Nella entity definisco sempre il clk e tutti i segnali che possono causare un cambiamento di stato
    port ( clk: in std_logic;   -- Definisco anche un segnale di output se la macchina prevede un eventuale messaggio di output.
           DATA: in std_logic_VECTOR (3 downto 0);
           RESET_BUTTON: in std_logic;
           RED : out std_logic_vector (3 downto 0);
           GREEN : out std_logic_vector (3 downto 0);
           BLUE : out std_logic_vector (3 downto 0);
           ALARM_ENABLE : OUT std_logic);
END ENTITY;

ARCHITECTURE Behav OF FSM_Example is

TYPE state_type is (idle, hit, middle);       -- Tipo di dato enumerativo che raccoglie tutti gli stati in cui posso trovarmi 
signal current_state, next_state : state_type;      -- Segnali che regolano il funzionamento della FSM

BEGIN

state_memory: PROCESS(clk)                          -- Processo che salva nello stato corrente, il prossimo stato calcolato
begin                                               -- Nella sensitivity sempre il clk ed eventuali segnali di enable/set/reset
    if( clk'event and clk = '1') then
        current_state <= next_state;
    end if;
end process;

next_state_logic: PROCESS(DATA, RESET_BUTTON, current_state)    -- Processo che calcola lo stato successivo in base ai segnali che si 
begin                                                                   -- Ricevono in ingresso
    case current_state IS               -- In questo caso nella sensitivity solo i segnali responsabili di cambiamenti di stato e ovviamente o stato
        when idle =>                    -- corrente. Non è necessario il clk in questo caso.
            if (UNSIGNED(DATA) > "1100") then
                next_state <= hit;
            else 
                next_state <= idle;
            end if;
        
        when hit =>                     -- Per ogni possibile stato con una struttura di tipo CASE si valutano quali potrebbero essere gli stati
            if (RESET_BUTTON = '0') then         -- futuri a seconda dei segnali di ingresso
                next_state <= MIDDLE;
            else
                next_state <= HIT;
            end if;
        
        when MIDDLE => 
            if (RESET_BUTTON = '1') then         -- futuri a seconda dei segnali di ingresso
                next_state <= IDLE;
            else
                next_state <= MIDDLE;
            end if;
            
    end case;
end process;

generate_output: PROCESS(current_state)     -- Processo che genera un eventuale output se previsto dalle specifiche di progetto
begin
    if(current_state = HIT) then             -- Se sono nello stato di output allora al segnale output viene assegnato il valore che voglio.
        RED <= "1111";
        GREEN <= "0000";
        BLUE <= "0000";
        ALARM_ENABLE <= '1';
    else
        RED <= "0000";
        GREEN <= "1111";
        BLUE <= "0000";
        ALARM_ENABLE <= '0';
    end if;
    End process;

END ARCHITECTURE;