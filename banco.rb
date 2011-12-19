require 'sqlite3'
require 'date'
class Banco

  @@db = nil

  def initialize
    @@db = SQLite3::Database.new "air.db"
    self.cria_database
  end

  def cria_database
    begin
      rows = @@db.execute <<-SQL
        CREATE TABLE ar_condicionado("id" INTEGER PRIMARY KEY AUTOINCREMENT, "temperatura" FLOAT, "custo" FLOAT, "data_hora" DATETIME);
      SQL
      self.inserir("30.0", "0.5")
    rescue
      puts " "
      linha = @@db.execute( "select count(*) as cont from ar_condicionado ")
      if linha[0][0] == 1
         custo = @@db.execute( "select custo from ar_condicionado ")
         set_params = " custo = '#{(custo[0][0] + 0.5).to_s}' "
         self.atualizar(set_params)
      end
    end
    
  end

  def inserir(temperat, custo)
    dthr = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    @@db.execute "insert into ar_condicionado( temperatura, custo, data_hora) values ( '#{temperat}', '#{custo}', '#{dthr.to_s}') ;"
  end

  def atualizar(set_params)
    @@db.execute("UPDATE ar_condicionado set #{set_params.to_s} where id = 1; ")
  end

  def inserir_atualizar(temp=0, custo=0)
    linha = @@db.execute( "select count(*) as cont from ar_condicionado ")
        if linha[0][0] == 1
          set_params = " temperatura = #{temp.to_s} , custo = #{custo.to_s} "
          atualizar(set_params)
        else
          inserir(temp, custo)
        end
  end     
     
  def execute_select_all()
    retorna_all = @@db.execute( "select * from ar_condicionado ;" )
    return retorna_all
  end
end