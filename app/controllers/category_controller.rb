class CategoryController < ApplicationController
  def index
    @categories = Category.all
    if @categories.empty?
      render :json => {
          :error => "Sorry, there's nothing here."
      }
    else
      render :json => {
          :response => "Success!",
          :data => @categories
      }
    end
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      render :json => {
          :response => "New category successfully created",
          :data => @new_category
      }
    else
      render :json => {
          :error => "Cannot save this data"
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => "Successful",
          :data => Category.find_by_id(params[:id])
      }
    else
      render :json => {
          :error => "Category not found"
      }
    end
  end

  def update
    if (@updating_category=Category.find_by_id(params[:id])).present?
      @updating_category.update(category_params)
      render :json => {
          :response => "Successfully updated",
          :data => @updating_category
      }
    else
      render :json => {
          :error => "Cannot update selected category"
      }
    end
  end

  def destroy
    if (@category_to_destroy=Category.find_by_id(params[:id])).present?
      @category_to_destroy.destroy
      render :json => {
          :response => "Successfully destroyed",
          :data => @category_to_destroy
      }
    else
      render :json => {
          :error => "Cannot destroy selected category"
      }
    end
  end

  private
  def category_params
    params.permit(:title, :description, :created_by)
  end
end
