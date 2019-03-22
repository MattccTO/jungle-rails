class ReviewsController < ApplicationController
  before_filter :check_logged_in

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product = @product
    if @review.save
      redirect_to @product
    else
      render "products/show"
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    if @review.user = current_user
      @review.destroy
    end
    redirect_to @product
  end
  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end
end
