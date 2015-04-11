# coding: utf-8
class Api::V1::EntriesController < ApiController 
  before_filter :restrict_access_user

  # GET /v1/entries
  def index
    @entries = Entry.all
  end

  # GET /v1/entries/1
  def show
    @entry = Entry.find(params[:id])
  end

  # POST /v1/entries
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      render
    else
      render json: {
        message: 'Unprocessable Entity',
        errors: @entry.errors.full_messages
      }, status: 422
    end
  end

  # PATCH/PUT /v1/entries/1
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      render
    else
      render json: {
        message: 'Unprocessable Entity',
        errors: @entry.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    if @entry.destroy
      render
    else
      render json: {
        message: 'Unprocessable Entity',
        errors: @entry.errors.full_messages
      }, status: 422
    end
  end
  
  private

  def entry_params
    params.require(:entry).permit(:title, :body)
  end
  
end
