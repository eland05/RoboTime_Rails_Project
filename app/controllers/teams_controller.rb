class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    if signed_in?
      @teams = Team.where(user_id: current_user.id)
    else
      redirect_to root_path, notice: 'You are not currently signed in.'
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    if signed_in? && @team.user_id == current_user.id
      team_members = TeamMember.where(team_id: @team.id)
      @team_members = []
      if !team_members.empty?
        team_members.each do |member|
        @team_members << User.find(member.user_id)
        end
      end
    else
      redirect_to teams_path, notice: 'Please select one of your teams.'
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    raise params.inspect
    if signed_in?
      @team = Team.new(team_params)
      @team.user_id = (current_user.id)
      if @team.save
        redirect_to @team, notice: 'Team was successfully created.'
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    raise params.inspect
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :number, :user_id, team_members_attributes: [:_destroy, :id, :user_id, :team_id])
    end
end
