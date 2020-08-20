class RecipesController < ApplicationController

  def index
    @recipes = Recipe.where(:category_id => params[:category_id])
    if @recipes.present?
      render :json => {
          :response => "successful",
          :data => @recipes
      }
    else
      render :json => {
          :error => "Oops, you have no recipes in this category"
      }
    end
  end

  def create
    puts "this is the create method"
    @new_category_recipe = Recipe.new(recipe_params)
    if Category.exists?(@new_category_recipe.category_id)
      if @new_category_recipe.save
        render :json => {
            :response => "successfully created the recipe",
            :data => @new_category_recipe
        }
      else
        render :json => {
            :response => "oops something went wrong"
        }
      end
    else
      render :json => {
          :error => 'Category does not exist'
      }
    end
  end

  def show
    @found_recipe = Recipe.where(category_id: params[:category_id]).find(params[:id])
    @single_category_of_recipes=Category.exists?(params[:category_id])
    @single_recipe=Recipe.where(category_id: params[:category_id]).exists?(params[:id])
    if @single_category_of_recipes && @single_recipe
      render :json => {
          :response => "successful",
          :data => @found_recipe
      }
    # elsif @single_recipe == false
    #   render :json => {
    #       :error => "Recipe not found"
    #   }
    else
      render :json => {
          :error => "Recipe not found"
      }
    end
    # elsif @single_category_of_recipes == false
    #   render :json => {
    #       :error => "Category does not exist"
    #   }
    # else
    #   render :json => {
    #       :error => "Category does not exist"
    #   }
    # end
  end

  def update
    @found_recipe = Recipe.where(category_id: params[:category_id]).find(params[:id])
    @single_category_of_recipes=Category.exists?(params[:category_id])
    @single_recipe=Recipe.where(category_id: params[:category_id]).exists?(params[:id])
    if @single_category_of_recipes
      if @single_recipe
        @found_recipe.update(recipe_params)
        render :json => {
            :response => "successfully updated",
            :data => @found_recipe
        }
      else
        render :json => {
            :error => "cannot update the selected recipe"
        }
      end
    else
      render :json => {
          :error => "cannot update the selected recipe"
      }
    end
  end

  def destroy
    @found_recipe = Recipe.where(category_id: params[:category_id]).find(params[:id])
    @single_category_of_recipes=Category.exists?(params[:category_id])
    @single_recipe=Recipe.where(category_id: params[:category_id]).exists?(params[:id])
    if @single_category_of_recipes
      if @single_recipe
        @found_recipe.destroy
        render :json => {
            :response => "deletion successful",
            :data => @found_recipe
        }
      else
        render :json => {
            :error => "cannot delete the selected recipe"
        }
      end
    else
      render :json => {
          :error => "cannot delete the selected recipe"
      }
    end
  end

  private
  def recipe_params
    params.permit(:category_id, :name, :ingredients, :directions, :notes, :tags)
  end

end
