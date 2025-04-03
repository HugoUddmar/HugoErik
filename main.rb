def input()
    puts "Hej! skriv ditt dagboksinlägg under"
    text = gets.chomp
    return text
end

def write(string, dag)
    fil = File.open("dagbok//#{dag}.txt", "w")
    fil.puts string
    fil.close
end

def whichday()
    date = Time.now.strftime("%d-%m-%Y")
    return date
end

def whichtime()
    time = Time.now.strftime("%H:%M")
    return time
end

def main()
    write("hejehejehj", whichday())
    write("hejehhj", 2)
    p whichday()
end
  
main()


