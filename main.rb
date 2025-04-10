

def write(string, dag)
    if !File.exist?("dagbok//#{dag}.txt")
        fil = File.open("dagbok//#{dag}.txt", "w")
        fil.puts "Dag: #{dag}"
        fil.puts "
        "
        fil.close
    end
    fil = File.open("dagbok//#{dag}.txt", "a")
    fil.puts string
    fil.close
end

def read(dag)
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
    i = 3
    while run
        puts "Hej! skriv ditt dagboksinlägg under eller om du vill avsluta programmet skriv 'esc'"
        text = gets.chomp
        if text == 'esc'
            run = false
            break
        end

        write(text,i)
        
        i += 1
    end
end
  
main()


