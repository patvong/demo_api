class ProductsController < ApplicationController
  before_action :load_product, only: [:show, :update, :destroy]

  def create
    product = Product.new(
      sku: params[:sku],
      description: params[:description]
    )
    product.save
    render json: product
  end

  def show
    render json: @product
  end

  def update
    @product.update_attributes(params[:product].permit(:description))
    render json: @product
  end

  def destroy
    @product.destroy
  end

  private

  def load_product
    @product = Product.find_by(sku: params[:sku])

    raise ActiveRecord::RecordNotFound unless @product
  end
end
