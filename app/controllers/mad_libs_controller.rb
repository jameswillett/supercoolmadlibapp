class MadLibsController < ApplicationController
  before_action :set_mad_lib, only: [:show, :edit, :update, :destroy]

  # GET /mad_libs
  def index
    @mad_libs = MadLib.all
  end

  # GET /mad_libs/1
  def show
  end

  # GET /mad_libs/new
  def new
    @mad_lib = MadLib.new
  end

  # GET /mad_libs/1/edit
  def edit
  end

  # POST /mad_libs
  def create
    @mad_lib = MadLib.new(mad_lib_params)

    if @mad_lib.save
      redirect_to @mad_lib, notice: 'Mad lib was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mad_libs/1
  def update
    if @mad_lib.update(mad_lib_params)
      redirect_to @mad_lib, notice: 'Mad lib was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mad_libs/1
  def destroy
    @mad_lib.destroy
    redirect_to mad_libs_url, notice: 'Mad lib was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mad_lib
      @mad_lib = MadLib.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mad_lib_params
      params.require(:mad_lib).permit(:text)
    end
end
