def generate_sellers
  return [
    'Leandro Swims',
    'Shelba Elrod',
    'Nanci Eidem',
    'Calandra Tancredi',
    'Rachelle Caryl',
    'Tiffani Red',
    'Reyes Waters',
    'Delicia Schwarz',
    'Janene Crumb',
    'Harry Higginbotham',
    'Christiane Stiff',
    'Columbus Hattaway',
    'Benny Keegan',
    'Foster Mulcahy',
    'Magaly Danna',
    'Ayako Lukasiewicz',
    'Beatrice Espitia',
    'Deidra Basham',
    'Harmony Hermosillo',
    'Milford Vantassel'
  ]
end

def generate_sells
  prng = Random.new
  sells = []
  how_many_sells = prng.rand(50..10000)
  
  how_many_sells.times do
    sells << prng.rand(0..99999)
  end
  
  return sells
end

if __FILE__ == $0
  seller_ids = (1..20).to_a
  sellers = generate_sellers
  sells = generate_sells
  
  File.open('trans-vendas.cbdb', 'w') do |file|  
    sells.each do |sell|
      seller_id = seller_ids.sample
      seller = sellers[seller_id-1]
      
      id_s = seller_id.to_s.rjust(2, '0')
      seller_s = seller.ljust(20, ' ')
      sell_s = ('%5.5s' % sell.to_s).gsub(' ', '0')
      file.write "#{id_s}#{seller_s}#{sell_s}\n"
    end
  end
end