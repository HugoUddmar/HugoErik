
# Beskrivning: Den här funktionen tar en text och datum och skapar en textfil med texten, och dagen blir namnet och rubriken i textfilen.
# Om filen redan finns, kommer den endast lägga till texten och fortsätta under det som redan skrivits.
# 
# Argument 1: String - Text som skrivs i textfilen
# Argument 2: String - Datum som skrivs i textfilen som rubrik och titeln av textfilen
# Return: Inget
# Exempel: "Hej" => returnar inget
#
#
#

def write(string, dag)
    newString = ""
    newString = string

    i = 0
    while i < newString.length
        if newString[i] == "\t"
            newString[i] = "\n"
        end 
        i += 1
    end

    count = 0
    i = 0
    while i < newString.length
        if newString[i] == "\n"
            count = 0
        elsif count == 49
            count = 0
            if newString[i] == " "
                newString[i] = "\n"
            else
                y = 0
                while newString[i-y] != " "
                    y += 1
                end
                newString[i-y] = "\n"
            end
        end
        count += 1
        i += 1
    end

    if !File.exist?("dagbok//#{dag}.txt")
        fil = File.open("dagbok//#{dag}.txt", "w")
        fil.puts "Dag: #{dag}"
        fil.puts " "
        fil.close
    end
    fil = File.open("dagbok//#{dag}.txt", "a")
    fil.puts newString
    fil.close
end

def read(dag)
    x = Dir.chdir("dagbok")
    x = Dir.glob("*")
    puts " "
    puts "Vilken fil vill du läsa?"
    i = 0
    while i < x.length
        puts "#{i + 1}: #{x[i]}"
        i += 1
    end
    fil = gets.chomp
    read = File.read(x[(fil.to_i)-1])
    puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    puts read
    puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    if !File.exist?("dagbok//#{dag}.txt")
    end
end

def getDay()
    date = Time.now.strftime("%d-%m-%Y")
    return date
end

def getTime()
    time = Time.now.strftime("%H:%M")
    return time
end

def main()
    run = true
    i = 5
    dagbokslista = []
    val = ["1","2","3"]
    while run
        puts "Hej! skriv ditt dagbok, vilken funktion vill du använda? 
        
        1: skrivläge
        2: läsläge
        3: avsluta   
        "
        choice = gets.chomp
       while !val.include?(choice)
        puts "fel input"
        choice = gets.chomp
       end

        if choice == val[0]
          puts "Skriv din text, om du vill byta rad, klicka på tab"
          text = gets.chomp
          write(text,i)
        elsif choice == val[1]
            read(i)
        elsif choice == val[2]
            run = false  
            break
        end
        i += 1
    end
end
  
main()


