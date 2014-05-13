class RetrievedCoupon
  attr_reader :coupon
  attr_reader :price
  def initialize(coupon)
    @coupon = coupon
    @price = 800
  end

  def text
    "Coupon applied for #{ off_text }"
  end

  def new_price
    if off = coupon["percent_off"]
      price * (1 - (1.0 / off))
    else off = coupon["amount_off"]
      price - off
    end
  end

  def off_text
    string = (coupon["percent_off"] || (coupon["amount_off"] / 100)).to_s
    if coupon["percent_off"]
      string += "%"
    else coupon["amount_off"]
      string += " dollars"
    end
    string += " off"
    if months = coupon["duration_in_months"]
      string += " for #{ months } "
      if months == 1
        string += "month"
      else
        string += "months"
      end
    end
    string += "."
    string
  end
end
