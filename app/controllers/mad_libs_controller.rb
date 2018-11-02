class MadLibsController < ApplicationController
  before_action :set_mad_lib, only: [:show, :edit, :update, :destroy]

  # GET /mad_libs
  def index
    @mad_libs = MadLib.all
  end

  # GET /mad_libs/1
  def show
    fields = []
    @mad_lib = MadLib.find(params[:id])
    @mad_lib.buildhash.each do |k, v|
      fields.push(k)
    end
    @fields = fields
    @solution = Solution.new({ :mad_lib_id => params[:id] })
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
    if @mad_lib.text == nil || @mad_lib.parse.length == 0
      redirect_to '/', notice: "You didn't follow the instructions!"
    elsif @mad_lib.save
      redirect_to @mad_lib, notice: 'New Mad Lib created'
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
      params.permit(:text)
    end
end
