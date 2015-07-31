class OrderNotifier < ApplicationMailer
  default from: 'Nguyen Quoc Kien <no-reply@mydomain.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(cart)
    @cart = cart
    mail to: cart.email, subject: 'Venshop - Order Carts'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
