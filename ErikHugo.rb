# Filnamn: ErikHugo.rb
# Syfte: En digital dagbok
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09



# Beskrivning: Den här funktionen krypterar en text relativt slumpmässigt.
# Den tar ett tecken och letar efter dess placering (index+1) i strängen signs i funktionen. Sen adderas placeringen med
# längden på strängen signs vilket blir värde1(int). Sen krypterar den slumpmässigt det tecknet med två andra tecken där deras placering i signs summerat blir värde1.
# Om tecknet inte finns i signs krypteras det inte och det sista tecknet i signs ')' blir alltid '))'. Det finns alltså fler kombinationer på lägre index i signs. 
# Det som händer är att ett värde t.ex. 60 krypteras genom att beskriva det som 30+30 / 15+45 / 10+50 t.ex. (alltid två tecken) och att det även sker med tecken som inte är siffror.
# Strängen signs är även ordnad i tecknen som är använda mest på svenska.
#
# Argument 1: String - Text som ska dekrypteras
# Return: String - Krypterad text
# Exempel: "Hej" => "3WWäWV"
# Exempel: "Hej" => "3W8lWV"
# Exempel: ")" => "))"
# Exempel: "+" => "+"
#
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09

def kryptering(string)
    signs = " eanrtsildomkgvhfupäbc.,\nåöyjxwzqEANRTSILDOMKGVHFUPÄBCÅÖYJXWZQ0123456789/!?%()"
    length = signs.length
    encryptedString = ""
    othersign = true

    i = 0
    while i < string.length

        y = 0
        othersign = true
        while y < length
            if string[i] == signs[y]
                value = y + length + 1
                y = length
                othersign = false
                while value > length
                    tecken = rand(value/2..length)
                    value -= tecken
                    encryptedString += signs[tecken-1]
                end

                encryptedString += signs[value-1]
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

# Beskrivning: Funktionen dekrypterar en text. Den tar två tecken i taget och adderar deras placering (index+1) i strängen signs och subtraherar längden av signs från värdet.
# Sen tar den det värdet - 1 som index i signs och det blir det dekrypterade tecknet.
# Om ett tecken inte är med i signs dekrypteras det inte. Om dekrypteringen inte går jämt ut (någon har försökt hacka krypteringen och slutgiltiga index är utanför signs) kastas ett fel ut och progammet kraschar.
# 
# Parameter 1: String - strängen som ska dekrypteras
# Return: String - dekrypterade strängen
# Exempel: "3WWäWV" => "Hej"
# Exempel: "3W8lWV" => "Hej"
# Exempel: "+" => "+"
# Exempel: "a" => ""
# Exempel (krypteringen går inte jämnt ut): "ab" => "Security breach dont mess with us."
#
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09

def dekryptering(string)
    signs = " eanrtsildomkgvhfupäbc.,\nåöyjxwzqEANRTSILDOMKGVHFUPÄBCÅÖYJXWZQ0123456789/!?%()"
    length = signs.length
    decryptedString = ""
    i = 0
    value = 0
    count = 0
    while i < string.length
        y = 0
        while y < length
            if string[i] == signs[y]
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
                    raise "Security breach dont mess with us."
                end
                decryptedString += signs[value-length-1]
                value = 0
                count = 0
            end   
        end
        i += 1
    end
    return decryptedString
end

# Beskrivning: Den här funktionen tar en text och datum och skapar en textfil med texten, och dagen blir namnet och rubriken i textfilen.
# Om filen redan finns, kommer den endast lägga till texten och fortsätta under det som redan skrivits. Den skapar även radbrytning efter 50 tecken
# 
# Argument 1: String - Text som skrivs i textfilen
# Argument 2: String - Datum som skrivs i textfilen som rubrik och titeln av textfilen
# Return: void
#
# Exempel: "Hej dagboken" , "1""  (om filen inte finns) => skriver strängen krypterat i filen 1.txt: 
# Dag: 1
#
# Hej dagboken
#
# Exempel: "Hej dagboken" , "1"  (om filen finns) => skriver strängen krypterat i filen 1.txt efter annan text utan space: 
# Hej dagboken
#
# Exempel: "AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA" , "1"  (om filen inte finns) => skriver strängen krypterat i filen 1.txt: 
# Dag: 1
#
# AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA
# AAAAA 
#
# Exempel: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" , "1"  (om filen inte finns) => skriver strängen krypterat i filen 1.txt: 
# Dag: 1
#
# AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# AAA
#
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09

def write(string, dag)
    if !File.exist?("dagbok//#{dag}.txt")
        fil = File.open("dagbok//#{dag}.txt", "w")
        fil.puts kryptering("Dag: #{dag}\n\n")
        fil.close
    end

    file = File.read("dagbok//#{dag}.txt")
    if file != ""
        file[file.length-1] = ""
    end

    newString = ""
    newString = string

    wholeString = dekryptering(file) + newString

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
            bool = true
            y = 0
            while y < 30
                if newString[i-y] == " "
                    newString[i-y] = "\n"
                    y = 30
                    bool = false
                end
                y += 1
            end

            if bool 
                y = 1
                index = newString.length - y
                while index > i
                    index = newString.length - y
                    newString[index + 1] = newString[index]
                    y += 1
                end
                newString[i] = "\n"
            end
        end
        count += 1
        i += 1
    end

    fil = File.open("dagbok//#{dag}.txt", "w")
    fil.puts kryptering(newString)
    fil.close
end


# Beskrivning: Den här funktionen skriver ut för användaren vilka filer som finns i mappen dagbok och låter sedan användaren välja vilken av dessa filer hen vill läsa.
# Filerna som användaren kan välja mellan visas i en lista och användaren väljer vilken hen vill läsa genom att skriva in siffran som korresponderat ill dess placering i listan. Denna input valideras
# Strängen från den valda filen skrivs sedan ut i terminalen.
#
# Argument: sträng - en sträng med en siffra som korresponderar till placeringen på textfilen som ska visas
# Return: void
#
# Exempel (3 filer i mappen dagbok): "1" => strängen från fil 1 skrivs ut i terminalen
# Exempel (3 filer i mappen dagbok): "4" => "Fel input, skriv en siffra som korresponderar till en fil"
# Exempel (3 filer i mappen dagbok): "h" => "Fel input, skriv en siffra som korresponderar till en fil"
# Exempel (0 filer i mappen dagbok): => "Det finns inga filer att läsa"
#
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09


def read(dag)
    x = Dir.chdir("dagbok")
    x = Dir.glob("*")
    if x.length == 0
        puts "Det finns inga filer att läsa
        "
    else
        puts " "
        puts "Vilken fil vill du läsa?"
        i = 0
        while i < x.length
            puts "#{i + 1}: #{x[i]}"
            i += 1
        end
        input = gets.chomp

        while input.to_i > x.length || input.to_i < 1 || input.to_i.to_s != input
            puts "Fel input, skriv en siffra som korresponderar till en fil"
            input = gets.chomp
        end

        read = File.read(x[(input.to_i)-1])
        read[read.length] = ""
        read = dekryptering(read)
        puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
        puts read
        puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"

    end

    x = Dir.chdir("..")
end

# Beskrivning: Den här funktionen läser av ett krypterat lösenord (sträng) som sparats i filen password.txt.
# Om det inte har skapats ett lösenord än finns bara en tab i documentet (som vi placerade där) och användarer får skriva in ett nytt. Detta lösenord måste vara över 5 tecken långt.
# Om det redan finns ett lösenord (sträng) i filen får användare försöka låsa upp dagboken genom att skirva in sitt lösenord i terminalen och denna sträng jämmförs med lösenordet i filen som körs genom en dektrypteringsfuntkion.
# Slutligen finns det en säkerhetsfunktion som kollar om password.txt filen är tom, vilket betyder att någon har tagit bort lösenordet (när vi skapar filen lägger vi in en tab). 
#
# Argument: void
# Return: void
#
# Exempel (ingen sträng i filen (med en tab) ): "hej" => sparas krypterat i password.txt
# Exempel (ingen sträng i filen (utan en tab) ): raise: "Password has been delted, security breach"
# Exempel (strängen "hej" har sparats krypterat i password.txt): "hej" => användaren får tillgång till programmets funktioner
# Exempel (strängen "hej" har sparats krypterat i password.txt): "hejdå" => användaren bes skriva in lösenordet igen
#
# Författare: Hugo Uddmar, Erik Karlen
# Datum: 2025-05-09

def password()
    password = File.read("password.txt")
    
    if password.length < 5 && password != "    "
        raise "Password has been delted, security breach"
    end

    if password == "    "
        puts "du har inget löseord, skriv in vilket löseord du vill ha:"
        word = gets.chomp

        while word.length < 5 || word.length > 100
            puts "Lösenordet måste vara minst 5 tecken långt och max 100 tecken långt"
            word = gets.chomp
        end
        
        word = kryptering(word)
        fil = File.open("password.txt","w")
        fil.puts word
        fil.close
    end

    password = File.read("password.txt")
    password[password.length-1] = ""
    puts "Skriv in ditt lösenord:"
    input = gets.chomp

    while input != dekryptering(password)
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
   while word.length < 5 || word.length > 100
    puts "Lösenordet måste vara minst 5 tecken långt och max 100 tecken långt"
    word = gets.chomp
   end
   word = kryptering(word)
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
            while text.length > 100000
                puts "Din text får max vara 100 000 tecken långt"
                text = gets.chomp
            end
            write(text,i)
            i += 1

        elsif choice == val[1]

            read(i)

        elsif choice == val[2]

            change_password()

        elsif choice == val[3]

            run = false  

            break
        end
       
    end
end

main()


