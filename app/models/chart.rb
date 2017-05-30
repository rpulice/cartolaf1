class Chart
  def self.chart_geral(data)
    nome = []
    time = []
    rodada = []
    pie_rodada = []
    media = 0
    i = 0
    data['times'].each do |statistic|
      nome << statistic['nome']
      time << statistic['nome_cartola']
      rodada << statistic['pontos']['campeonato'].round(2)
      pie_rodada << {name: statistic['nome'].to_s, y: statistic['pontos']['campeonato'].round(2)}
      media += statistic['pontos']['campeonato'].round(2)
      i += 1
    end
    line_rodada = media/i
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Campeonato")
      f.xAxis(categories: nome)
      f.series(type: 'column', name: "Jogador", data: rodada)
      f.series(type: 'pie', name: 'Pontos', data: pie_rodada, center: [250, 20], size: 100, showInLegend: false, dataLabels: {enabled: false},
          tooltip: {pointFormat: '{series.name}: {point.y} - <b>{point.percentage:.1f}%</b>'})
      f.yAxis [{title: [{text: 'Pontos'}], plotLines: [{color: '#ff3860', value: line_rodada, width: 2}]}]
      f.plotOptions(column: {colorByPoint: true})
      f.legend(align: 'right', verticalAlign: 'top', y: 0, x: -50, layout: 'vertical')
    end
  end

  def self.chart_rodada(data)
    nome = []
    rodada = []
    pie_rodada = []
    media = 0
    i = 0
    data['times'].each do |statistic|
      nome << statistic['nome']
      rodada << statistic['pontos']['rodada'].round(2)
      pie_rodada << {name: statistic['nome'].to_s, y: statistic['pontos']['rodada'].round(2)}
      media += statistic['pontos']['rodada'].round(2)
      i += 1
    end
    line_rodada = media/i
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Última rodada")
      f.xAxis(categories: nome)
      f.series(type: 'column', name: "Jogador", data: rodada, color: '#23d160')
      f.series(type: 'pie', name: '%', data: pie_rodada, center: [250, 20], size: 100, showInLegend: false, dataLabels: {enabled: false},
          tooltip: {pointFormat: '{series.name}: {point.y} - <b>{point.percentage:.1f}%</b>'})
      f.yAxis [{title: [{text: 'Pontos'}], plotLines: [{color: '#ff3860', value: line_rodada, width: 2}]}]
      f.plotOptions(column: {colorByPoint: true})
      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
    end
  end

  def self.chart_parcial(data)
    nome = []
    rodada = []
    pie_rodada = []
    media = 0
    i = 0
    data.each do |k, v|
      nome << k
      rodada << v.round(2)
      pie_rodada << {name: k.to_s, y: v.round(2)}
      media += v.round(2)
      i += 1
    end
    line_rodada = media/i
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Parcial")
      f.xAxis(categories: nome)
      f.series(type: 'column', name: "Jogador", data: rodada, color: '#23d160')
      f.series(type: 'pie', name: '%', data: pie_rodada, center: [250, 20], size: 100, showInLegend: false, dataLabels: {enabled: false},
          tooltip: {pointFormat: '{series.name}: {point.y} - <b>{point.percentage:.1f}%</b>'})
      f.yAxis [{title: [{text: 'Pontos'}], plotLines: [{color: '#ff3860', value: line_rodada, width: 2}]}]
      f.plotOptions(column: {colorByPoint: true})
      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
    end
  end
end
