require 'banco'
require 'date'

class Air
  @@temp_atual = nil
  @@temp_desejada = nil
  @@custo = nil
  @@banco = nil
  @@data_hr = nil
  
  def temperatura_atual
    @@temp_atual
  end
  
  def initialize
    
  end
  
  def ligar
    @@banco = Banco.new
    @@temp_atual = @@banco.execute_select_all[0][1]
  end
  
  def informativo
    sql = @@banco.execute_select_all
    puts "A temperatura atual eh de: "+sql[0][1].to_s+" Graus"
    puts "O custo atual eh de: "+sql[0][2].to_s+" reais"
  end

  def reduz_um_grau()
    sql = @@banco.execute_select_all
    @@custo = sql[0][2].to_f + 0.1
    temperatura = sql[0][1].to_f - 1
    set_params = " temperatura = '#{temperatura.to_s}', custo = '#{@@custo.to_s}' "
    @@banco.atualizar(set_params.to_s)
    
    # puts "Temperatura reduzida em 1 grau!"
    
  end
  
  def refrigera(temp_atual, temp_desejada )
    sql = @@banco.execute_select_all
    if sql.count > 0
      # atualiza
      @@data_hr = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      set_params = " temperatura = '#{temp_desejada.to_s}', data_hora = '#{@@data_hr.to_s}' "
      @@banco.atualizar(set_params)
    else
      # inserir
      @@banco.inserir_atualizar(temp_atual)
    end
  end
  
  def tempo_ligado_360m(tempo = 360, temp_inicial = 30, temp_desejavel = 20)
    self.ligar
    resultado = Array.new
    custo_parcial = 0
    
    temp_result = (temp_inicial - temp_desejavel).to_i
    
    temp_result.times do 
      self.reduz_um_grau()
    end
    
    sql = @@banco.execute_select_all
    custo_parcial = sql[0][2].to_f
    
    custo_total = custo_parcial + ( 0.5 * 0.1 * tempo)
    
    self.altera_custo(custo_total)
    
    resultado << temp_desejavel
    
    resultado << custo_total
    
    return resultado
     
  end
  
  def altera_custo(custo = 0)
    puts custo
    set_params = " custo = '#{custo.to_s}' "
    @@banco.atualizar(set_params)
    sql = @@banco.execute_select_all
    puts sql
  end
   
end