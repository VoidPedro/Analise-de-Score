class AnalysesController < ApplicationController
  before_action :set_analysis, only: %i[ show edit update destroy ]
  before_action :set_applicant, only: [:index]

  # GET /analyses or /applicants/:applicant_id/analyses
  def index
    if @applicant
      # Se vem de /applicants/:applicant_id/analyses, mostra apenas análises daquele applicant
      @analyses = @applicant.analyses.order(created_at: :desc)
    else
      # Se acessa /analyses, mostra todas (ou pode mudar para não permitir)
      @analyses = Analysis.order(created_at: :desc)
    end
  end

  # GET /analyses/1 or /analyses/1.json
  def show
  end

  # GET /analyses/new
  def new
    @analysis = Analysis.new
    # Se vem com applicant_id, pré-seleciona
    @applicant = Applicant.find(params[:applicant_id]) if params[:applicant_id]
  end

  # GET /analyses/1/edit
  def edit
  end

  # POST /analyses or /analyses.json
  def create
    @analysis = Analysis.new(analysis_params)

    respond_to do |format|
      if @analysis.save
        format.html { redirect_to @analysis, notice: "Analysis was successfully created." }
        format.json { render :show, status: :created, location: @analysis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analyses/1 or /analyses/1.json
  def update
    respond_to do |format|
      if @analysis.update(analysis_params)
        format.html { redirect_to @analysis, notice: "Analysis was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @analysis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyses/1 or /analyses/1.json
  def destroy
    @analysis.destroy!

    respond_to do |format|
      format.html { redirect_to analyses_path, notice: "Analysis was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analysis
      @analysis = Analysis.find(params[:id])
    end

    # Carrega o applicant se vem de rota aninhada
    def set_applicant
      @applicant = Applicant.find(params[:applicant_id]) if params[:applicant_id]
    end

    # Only allow a list of trusted parameters through.
    def analysis_params
      params.require(:analysis).permit(:applicant_id)
    end
end
