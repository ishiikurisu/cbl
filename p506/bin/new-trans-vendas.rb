if __FILE__ == $0
  sells = [0,1,0,2,3,0,4,5,6,0,0,7,8,9,0,0,0,0,10]

  File.open('trans-vendas.cbdb', 'w') do |file|
    prng = Random.new
    for i in 1..50 
      how_many_sells = sells.sample
      unless how_many_sells == 0
        how_many_sells.times do
          v = prng.rand 1...9999
          c = v * 0.10
          vendas = v.to_s.rjust 6, '0'
          comissao = c.to_i.to_s.rjust 6, '0'
          file.write "#{i.to_s.rjust(5, '0')}#{vendas}#{comissao}\n"
        end
      end
    end
  end
end