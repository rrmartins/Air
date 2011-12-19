require "air.rb"

air = Air.new
str = "string"
on_off = ""

puts "---------- App Air ----------"
puts " "

while (str.eql? "string")
    puts "\nEscolha uma opcao:" 
    puts " 1 - Ligar o Ar-Condicionado.\n 2 - Ligar | Verificar custo de tempo por temperturas. \n 3 - Sair. \n"

    on_off = gets()[0..0]
    
    if on_off.to_i == 0
      str = "string"
    else 
      str = "num"
    end
end

if !(on_off.eql? "1" or on_off.eql? "2" or on_off.eql? "3")
    puts "Opcao errada! sai!"
elsif on_off.eql? "1"
    
    air.ligar
    
    puts "Seu ar-condicionado foi ligado com sucesso!"
    air.informativo
    
    sair = ""
    
    while !(sair.eql? "sair")
        temp_atual = air.temperatura_atual
        
        str = "string"
        resposta = ""
        while (str.eql? "string")
            puts "\nEscolha uma opcao:" 
            puts " 1 - alterar temperatura.\n 2 - sair. \n 3 - informativo. \n 4 - Reduz 1 grau. \n"
    
            resposta = gets()[0..0]
            
            if resposta.to_i == 0
                str = "string"
            else 
                str = "num"
            end
        end
        if resposta.eql? "1"
            puts "Qual a temperatura desejada: (para digitar decimal, coloque com ponto '.')"
            temp = gets()[0..-2]
         
            if temp.split.length > 0
                air.refrigera(temp_atual, temp)
            end
        elsif resposta.eql? "2"
            sair = "sair"
        elsif resposta.eql? "3"
            air.informativo
        elsif resposta.eql? "4"
            air.reduz_um_grau
        end
    end
    
    air.informativo
    puts "Estou sendo encerrado. Ate outro dia! :) "
    
elsif on_off.eql? "2"
  
    str = "string"
    resposta = ""
    while (str.eql? "string")
        
        puts "Quanto tempo ficara ligado?"
        tempo = gets()[0..-2]
        
        puts "Qual a temperatura Inicial?"
        temp_inicial = gets()[0..-2]

        puts "Qual a temperatura Desejavel?"
        temp_desejavel = gets()[0..-2]
        
        if tempo.to_i == 0
          str = "string"
          puts "Este tempo não é aceito"
        end
        
        if temp_inicial.to_f == 0.0 or temp_desejavel.to_f == 0.0
            str = "string"
            puts "Uma das temperaturas nao sao numeros."
        elsif temp_inicial.to_f < temp_desejavel.to_f
            puts "A temperatura inicial precisa ser maior que a desejavel."
            str = "string"
        else
            str = "num"
        end

    end
    
    tempo_custo = air.tempo_ligado_360m(tempo.to_i, temp_inicial.to_f, temp_desejavel.to_f)
    puts "Após #{tempo.to_s} minutos, a temperatura será de #{tempo_custo[0]}"
    puts "Temperatura desejada: #{temp_desejavel.to_s} Graus"
    puts "Temperatura inicial:  #{temp_inicial.to_s} Graus"
    puts "Ola, o custo em #{tempo.to_s} minutos eh de "+ tempo_custo[1].to_s


elsif on_off.eql? "3"
    puts "Estou sendo desligado!"
else
    puts "Opção invalida! Hora de sair."
end

