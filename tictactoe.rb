class Game
    def initialize(name)
        @top_row = [" ", "tl", " ", "|", " ", "tm", " ", "|", " ", "tr", " "]
        @middle_row = [" ", "ml", " ", "|", " ", "mm", " ", "|", " ", "mr", " "]
        @bottom_row = [" ", "bl", " ", "|", " ", "bm", " ", "|", " ", "br", " "]
        @row_seperator = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"]
        
        @player_one = Player.new(name, " X")
        @player_two = Player.new("CPU", " O")
    end
    
    def play
        rnd = Random.new(2)
        round ||= rnd.rand(1..2)
        a_winner = {}
        end_game = true
        while end_game
            draw_game
            if round.even?
                puts "It is #{@player_one.name}s turn. "
                get_player_move(@player_one) 
                update_game(@player_one)
            else
                puts "It is the CPUs turn. "
                get_player_move(@player_two)
                update_game(@player_two)
            end
            puts("-----------------------------------------------------")
            a_winner = check_for_winner
            print "Winner check: \n"
            #puts a_winner.class
            a_winner.each do |k, v|
                if v 
                    puts "#{k} is the winner!"
                    end_game = false
                else    
                    puts "No winner yet...."
                end
            end
            round += 1
        end
    end
    
    def update_game(player)
        #puts "in update game."
        player_cells = player.player_moves
        player_cells.each do |cell|
            
            #puts "Cell #{cell}"
            case cell
                when "tl" then @top_row[1] = player.code
                when "tm" then @top_row[5] = player.code
                when "tr" then @top_row[9] = player.code
                when "ml" then @middle_row[1] = player.code
                when "mm" then @middle_row[5] = player.code
                when "mr" then @middle_row[9] = player.code
                when "bl" then @bottom_row[1] = player.code
                when "bm" then @bottom_row[5] = player.code
                when "br" then @bottom_row[9] = player.code
            end
        end
    end
    
    def get_player_move(player)
        bad_input = true
        while bad_input
            if player.name === "CPU"
                move = get_ramdom_cell
                #puts ("CPU move: #{move}")
            else
                puts "Enter a move: "
                move = gets.chomp
            end
            bad_input = is_illegal(move)
            puts "That is not a legal move." if bad_input 
        end
        player.get_move(move)
        
    end
    
    def get_ramdom_cell()
        rnd = Random.new
        arr = [1,5,9]
        col = rnd.rand(0..2)
        row = rnd.rand(1..3)
        case row
            when 1 then return @top_row[arr[col]]
            when 2 then return @middle_row[arr[col]]
            when 3 then return @bottom_row[arr[col]]
        end
    end
    
    def is_illegal(entred_cell)
        found = false
        return true if entred_cell === " X"
        return true if entred_cell === " O"
        @top_row.each do |cell|
            return false if entred_cell.include?(cell)
        end
        @middle_row.each do |cell|
            return false if entred_cell.include?(cell)
        end
        @bottom_row.each do |cell|
            return false if entred_cell.include?(cell)
        end
        
        return true
    end
    
    def check_for_winner
        winner = {}
        
        # check rows
        winner[@top_row[1]] = true if @top_row[1] === @top_row[5] && @top_row[5] === @top_row[9]
        winner[@middle_row[1]] = true if @middle_row[1] === @middle_row[5] && @middle_row[5] === @middle_row[9]
        winner[@bottom_row[1]] = true if @bottom_row[1] === @bottom_row[5] && @bottom_row[5] === @bottom_row[9]
        # check cols
        winner[@top_row[1]] = true if @top_row[1] === @middle_row[1] && @middle_row[1] === @bottom_row[1]
        winner[@top_row[5]] = true if @top_row[5] === @middle_row[5] && @middle_row[5] === @bottom_row[5]
        winner[@top_row[9]] = true if @top_row[9] === @middle_row[9] && @middle_row[9] === @bottom_row[9]
        #check diagnals
        winner[@top_row[1]] = true if @top_row[1] === @middle_row[5] && @middle_row[5] === @bottom_row[9]
        winner[@top_row[9]] = true if @top_row[9] === @middle_row[5] && @middle_row[5] === @bottom_row[1]
        
        if winner.empty?
            winner["--"] = false
            return winner
        else
            return winner
        end
    end
    
    def draw_game
        @top_row.each { |cell| print cell }
        puts
        @row_seperator.each { |cell| print cell }
        puts
        @middle_row.each { |cell| print cell }
        puts
        @row_seperator.each { |cell| print cell }
        puts
        @bottom_row.each { |cell| print cell }  
        puts  
    end
end

class Player
    
    attr_accessor :code, :name
    def initialize(name, code)
        @name = name
        @code = code
        @moves = []
    end
    
    def get_move(move)
        puts move
        @moves << move
    end
    
    def player_moves
        return @moves
    end
end

new_game = Game.new("Player one")
new_game.play
