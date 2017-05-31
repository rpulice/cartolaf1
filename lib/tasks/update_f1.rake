# encoding: utf-8
namespace :update_f1 do
  task :insert => :environment do
    client = HTTPClient.new
    extheader = {'X-GLB-Token' => '19ef4ab5c7c76e0e6a4485aeb681e56ea4e474347337a36734f66524546436c4e786663716c764a6a6b5f58346d63526466433072726b324736505a6e6f69706b2d6635376e792d4834586d627a712d434c614c3866314770635f314b792d2d614b2d623130773d3d3a303a7269636172646f70756c6963655f323031315f35'}
    url = 'https://api.cartolafc.globo.com/auth/liga/openbar-liga-espetaculosa'
    @liga = client.get_content(url, '', extheader)
    @teams = Team.all
    @liga = ActiveSupport::JSON.decode(@liga)
    client = HTTPClient.new
    @status = client.get_content('https://api.cartolafc.globo.com/mercado/status')
    status = ActiveSupport::JSON.decode(@status)
    ponto_f1_rodada = []
    ponto_f1 = []
    (status['rodada_atual']-1).times do |i|
      @liga['times'].each do |j|
        url = "https://api.cartolafc.globo.com/time/slug/#{j['slug']}/#{i+1}"
        client = HTTPClient.new
        ponto = client.get_content(url)
        ponto = ActiveSupport::JSON.decode(ponto)
        ponto_f1_rodada.push(j['slug'] => ponto['pontos'])
      end
      n = {}
      ponto_f1_rodada.map {|e| n.merge! e}
      ponto_f1.push(n.sort_by {|k,v| v}.reverse)
    end

    (status['rodada_atual']-1).times do |i|
      z = 0
      @liga['times'].each do |v|
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
    ponto_f1_equipe = []
    ponto_equipe = 0
    z = 0
    (status['rodada_atual']-1).times do |i|
      ponto_f1_equipe_parcial = []
      @teams.each do |v|
        ponto_equipe = 0
        TeamPlayer.where(team_id: v.id).each do |j|
          ponto_f1[z].each do |pf|
            if j['player'] == pf[0]
              ponto_equipe += pf[2]
            end
          end
        end
        ponto_f1_equipe_parcial << [v.id, ponto_equipe]
      end
      ponto_f1_equipe << ponto_f1_equipe_parcial
      z += 1  
    end
    Alysson.delete_all
    alysson = Alysson.new(:pontos => ponto_f1_equipe)
    alysson.save
  end
end
