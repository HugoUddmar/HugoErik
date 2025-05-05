# Beskrivning: Den här funktionen krypterar en text relativt slumpmässigt
# 
# Argument 1: String - Text som skrivs i textfilen
# Return: Inget
# Exempel: "Hej" => returnar inget
#
def kryptering2(string)
    alphabet = " eanrtsildomkgvhfupäbc.,\nåöyjxwzqEANRTSILDOMKGVHFUPÄBCÅÖYJXWZQ0123456789/!?%()"
    length = alphabet.length
    encryptedString = ""
    othersign = true

    i = 0
    while i < string.length

        y = 0
        othersign = true
        while y < length
            if string[i] == alphabet[y]
                value = y + length + 1
                y = length
                othersign = false
                while value > length
                    tecken = rand(value/2..length)
                    value -= tecken
                    encryptedString += alphabet[tecken-1]
                end

                encryptedString += alphabet[value-1]
            end
            y += 1
        end

        if othersign
            encryptedString += string[i]
        end

        i += 1
    end
    return encryptedString
end

def dekryptering2(string)
    alphabet = " eanrtsildomkgvhfupäbc.,\nåöyjxwzqEANRTSILDOMKGVHFUPÄBCÅÖYJXWZQ0123456789/!?%()"
    length = alphabet.length
    decryptedString = ""
    i = 0
    value = 0
    count = 0
    while i < string.length
        y = 0
        while y < length
            if string[i] == alphabet[y]
                value += y + 1
                y = length
            end

            y += 1
        end

        if value == 0
            decryptedString += string[i]
            count = 0
        else
            count += 1
            if count == 2
                index = value - length - 1
                if index < 0 || index > 77
                    raise "nono"
                end
                decryptedString += alphabet[value-length-1]
                value = 0
                count = 0
            end   
        end
        i += 1
    end
    return decryptedString
end

def kryptering(string)
    alphabet = "abcdefghijklmnopqrstuvwxyzåäö,. 0123456789/!?%()"
    encryptedString = ""
    encryptedString = string
    
    i = 0
    while i < encryptedString.length
        encryptedString[i] = encryptedString[i].downcase
        y = 0
        while y < alphabet.length
            if encryptedString[i] == alphabet[y]
                index = y + 1000
                index = index % 48
                encryptedString[i] = alphabet[index]
                y = alphabet.length
            end
            y += 1
        end
        i += 1
    end
    
    return encryptedString
end

def dekryptering(string)
    alphabet = "abcdefghijklmnopqrstuvwxyzåäö,. 0123456789/!?%()"
    decryptedString = ""
    decryptedString = string

    i = 0
    while i < decryptedString.length
        y = 0
        while y < alphabet.length
            if decryptedString[i] == alphabet[y]
                index = y - 1000
                index = index % 48
                decryptedString[i] = alphabet[index]
            end
            y += 1
        end
        i += 1
    end
    p decryptedString
    return decryptedString
end

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
    if !File.exist?("dagbok//#{dag}.txt")
        fil = File.open("dagbok//#{dag}.txt", "w")
        fil.puts kryptering2("Dag: #{dag}\n\n")
        fil.close
    end

    file = File.read("dagbok//#{dag}.txt")
    file[file.length-1] = ""

    newString = ""
    newString = string

    wholeString = dekryptering2(file) + newString

    newString = wholeString

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
            y = 1
            index = newString.length - y
            while index > i
                index = newString.length - y
                newString[index + 1] = newString[index]
                y += 1
            end
            newString[i] = "\n"
        end
        count += 1
        i += 1
    end

    fil = File.open("dagbok//#{dag}.txt", "w")
    fil.puts kryptering2(newString)
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
    read[read.length-1] = ""
    read = dekryptering2(read)
    puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    puts read
    puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    if !File.exist?("dagbok//#{dag}.txt")
    end
    x = Dir.chdir("..")
  
  
end

def getDay()
    date = Time.now.strftime("%d-%m-%Y")
    return date
end

def getTime()
    time = Time.now.strftime("%H:%M")
    return time
end

def password()
    password = File.read("password.txt")
    
    if password == "" || password == "\n"
        raise "no"
    end

    if password == "    "
        puts "du har inget löseord, skriv in vilket löseord du vill ha:"
       word = gets.chomp
       while word.length < 5
        puts "Lösenordet måste vara minst 5 tecken långt"
        word = gets.chomp
       end
       word = kryptering2(word)
      fil = File.open("password.txt","w")
      fil.puts word
      fil.close
    end

    password = File.read("password.txt")
    password[password.length-1] = ""
    puts "Skriv in ditt lösenord:"
    input = gets.chomp

    while input != dekryptering2(password)
        puts "fel lösenord, skriv igen"
        input = gets.chomp
    end
    puts "korrekt lösenord
    "
end

def change_password()
   puts "
   Skriv in ditt nya lösenord:"
   word = gets.chomp
   while word.length < 5
    puts "Lösenordet måste vara minst 5 tecken långt"
    word = gets.chomp
   end
   word = kryptering2(word)
   fil = File.open("password.txt","w")
   fil.puts word
   fil.close
end

def main()
    run = true
    i = 1
    dagbokslista = []
    val = ["1","2","3","4"]
    puts"Välkommen till din digitala dagbok
    "
    password()

    while run

        puts "Vilken funktion vill du använda? 
        
        1: skrivläge
        2: läsläge
        3: byt lösenord
        4: avsluta   
        "
        choice = gets.chomp
        while !val.include?(choice)
            puts "fel input"
            choice = gets.chomp
        end

        if choice == val[0]
            puts "Skriv din text, om du vill byta rad, klicka på tab"
            text = gets.chomp
            i = 1
            write(text,i)
        elsif choice == val[1]
            read(i)
        elsif choice == val[2]
            change_password()
        elsif choice == val[3]
            run = false  
            break
        end
        i += 1
    end
end

main()


