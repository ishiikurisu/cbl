def generate_tax_table
  File.open('tab_impostos.txt', 'w') do |file|
    file.write "09800040010\n"
    file.write "12000080020\n"
    file.write "99999010005\n"
  end
end

def generate_salary_table
  prng = Random.new
  nr = 0
  how_many = prng.rand 10..30
  
  File.open('arq_salario.cbdb', 'w') do |file|
    how_many.times do
      nr += 1
      nr_empregado = nr.to_s.rjust(5, '0')
      nome_empregado = (0..20).map { ('a'..'z').to_a[rand(26)] }.join
      salario_anual = prng.rand(1000..12000).to_s.rjust(5, '0')
      nr_dependentes = prng.rand(0..15).to_s.rjust(2, '0')

      file.write "#{nr_empregado}#{nome_empregado}  #{salario_anual}    #{nr_dependentes}\n"
    end
    10.times do
      nr += 1
      nr_empregado = nr.to_s.rjust(5, '0')
      nome_empregado = (0..20).map { ('a'..'z').to_a[rand(26)] }.join
      salario_anual = prng.rand(12001..99999).to_s.rjust(5, '0')
      nr_dependentes = '00'

      file.write "#{nr_empregado}#{nome_empregado}  #{salario_anual}    #{nr_dependentes}\n"
    end
  end
end

if __FILE__ == $0
  generate_tax_table
  generate_salary_table
end