def generate_sellers prng
  sellers = []
  letters = ('A'..'Z').to_a.permutation(3).to_a
  how_many_sellers = prng.rand(5..1000)
  
  how_many_sellers.times do
    maybe_seller = letters.sample.join
    while sellers.count(maybe_seller) > 0
      maybe_seller = letters.sample.join
    end
    sellers << maybe_seller
  end
  
  return sellers
end

if __FILE__ == $0
  # output file format:
  #   nr-dia:
  #     tamanho: 1
  #     tipo: alfanumerico
  #   nr-vendedor:
  #     tamanho: 3
  #     tipo: alfanumerico
  #   valor-vendas:
  #     tamanho: 5
  #     tipo: numerico
  #     posicoes decimais: 2
  #
  prng = Random.new
  sellers = generate_sellers prng
  
  File.open('trans-vendas.db', 'w') do |file|
    for nr_day in 1..5 do
      day_sellers = []
      prng.rand(1..sellers.size).times do
        nr_vendedor = sellers.sample
        while day_sellers.count(nr_vendedor) > 0
          nr_vendedor = sellers.sample
        end
        day_sellers << nr_vendedor
        valor_vendas = ('%5.5s' % prng.rand(0..99999).to_s).gsub(' ', '0')
        line = "#{nr_day}#{nr_vendedor}#{valor_vendas}\n"
        file.write(line)
      end
    end
  end
end