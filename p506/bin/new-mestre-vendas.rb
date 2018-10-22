if __FILE__ == $0
  File.open('mestre-vendas.cbdb', 'w') do |file|
    for i in 1..50
      file.write("#{i.to_s.rjust(5,'0')}                                000000000000      000000000000   \n")
    end
  end
end