class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]

  # GET /solutions
  def index
    puts params[:mad_lib_id]
    @solutions = Solution.where(mad_lib_id: params[:mad_lib_id]).all
    @mad_lib_text = MadLib.find(params[:mad_lib_id]).text
    @mad_lib_id = params[:mad_lib_id]
  end

  # GET /solutions/1
  def show
  end

  # GET /solutions/new
  def new
    @solution = Solution.new
    @mad_lib = MadLib.find(params[:mad_lib_id])
  end

  # GET /solutions/1/edit
  def edit
  end

  # POST /solutions
  def create
    words = []
    @solution = Solution.new({ :mad_lib_id => params[:mad_lib_id]})
    @mad_lib = MadLib.find(params[:mad_lib_id])
    params[:solution].each do |k, v|
      @solution.fill_field(k, :with => v)
      words.push(v)
    end
    @solution.words = words.join('%')
    @solution.text = @solution.resolve
    if @solution.save
      redirect_to mad_lib_solutions_path(@mad_lib), notice: 'Your solution has been created'
    else
      render :new
    end
  end

  # PATCH/PUT /solutions/1
  def update
    if @solution.update(solution_params)
      redirect_to @solution, notice: 'Solution was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /solutions/1
  def destroy
    @solution.destroy
    @mad_lib = MadLib.find(params[:id])
    redirect_to mad_lib_solutions_path(@mad_lib), notice: 'Solution was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def solution_params
      params.require(:solution).permit(:mad_lib_id, :text)
    end
end
