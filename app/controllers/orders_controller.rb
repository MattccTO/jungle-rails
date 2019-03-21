class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @products = find_products_by_order_id(@order.id)
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)
    if order.valid?
      empty_cart!
      products = find_products_by_order_id(order.id)
      UserMailer.order_email(order, products).deliver_now
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

  def find_products_by_order_id(order_id)
    order_line_items = Order.find(order_id).line_items
    order_products = []
    order_line_items.each do |line_item|
      product = line_item.product
      product.quantity = line_item.quantity
      order_products << product
    end
    order_products
  end
end
