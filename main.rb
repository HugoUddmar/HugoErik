def input()
    puts "Hej! skriv ditt dagboksinlägg under"
    text = gets.chomp
    return text
end

def write(string, dag)
    fil = File.open("//dagbok//#{dag}.txt", "w")
    fil.puts string
    puts "hej"
    fil.close
end
write("hejehejehj", 1)

def whichday()
    
end

def main
  
end
  


