class TeamsController < ApplicationController
	before_action :authenticate_user

	def index
		@teams = Team.order(:nome)
	end

	def edit
    @team = Team.find(params[:id])
    @liga = liga
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:success] = 'Time removido com sucesso!'
    redirect_to teams_url
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = 'Time atualizado com sucesso!'
      redirect_to teams_url
    else
      @liga = liga
      render 'edit'
    end
  end

  def new
    @team = Team.new
    @liga = liga
  end

  def create
    @team = Team.new(team_params)
    @team.ativo = true
    if @team.save
      flash[:success] = 'Time criado com sucesso!'
      redirect_to teams_url
    else
      @liga = liga
      render 'new'
    end
  end

  def toggle_status
    @team = Team.find params[:id]
    @team.toggle :ativo
    @team.save
    respond_to :js
  end

	private

  def team_params
    params.require(:team).permit(:nome, 
      team_players_attributes: [:id, :team_id, :player, :_destroy])
  end
end
