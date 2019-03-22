class ReviewsController < ApplicationController
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

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end
end
