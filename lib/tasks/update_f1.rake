# encoding: utf-8
namespace :update_f1 do
  task :insert => :environment do    
    @teams = Team.all
    client = HTTPClient.new
    @status = client.get_content('https://api.cartolafc.globo.com/mercado/status')
    status = ActiveSupport::JSON.decode(@status)
    ponto_f1_rodada = []
    ponto_f1 = []
    (status['rodada_atual']-1).times do |i|
      @teams.each do |v|
        ponto_equipe = 0
        TeamPlayer.where(team_id: v.id).each do |j|
          url = "https://api.cartolafc.globo.com/time/slug/#{j.player}/#{i+1}"
          client = HTTPClient.new
          ponto = client.get_content(url)
          ponto = ActiveSupport::JSON.decode(ponto)
          ponto_equipe += ponto['pontos']
        end
        ponto_f1_rodada.push(v.id => ponto_equipe)
      end
      n = {}
      ponto_f1_rodada.map {|e| n.merge! e}
      ponto_f1.push(n.sort_by {|k,v| v}.reverse)
    end
    (status['rodada_atual']-1).times do |i|
      z = 0
      @teams.each do |v|
        ponto_final = 0
        case z
        when 0
          ponto_final = 25
        when 1
          ponto_final = 18
        when 2
          ponto_final = 15
        when 3
          ponto_final = 12
        when 4
          ponto_final = 10
        when 5
          ponto_final = 8
        when 6
          ponto_final = 6
        when 7
          ponto_final = 4
        when 8
          ponto_final = 2
        when 9
          ponto_final = 1
        end
        ponto_f1[i][z].push(ponto_final)
        z += 1
      end
    end 
    Alysson.delete_all
    alysson = Alysson.new(:pontos => ponto_f1)
    alysson.save
  end
end
