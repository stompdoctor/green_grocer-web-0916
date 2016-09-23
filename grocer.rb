require "pry"


def consolidate_cart(cart)
	new_cart = {}
	cart.each do |item|
	  	count = cart.count(item)
	  	new_cart[item.keys[0]] = item.values[0]
	  	new_cart[item.keys[0]][:count] = count
	end
	new_cart
end


def apply_coupons(cart, coupons)
	new_cart = cart.clone
 	cart.each do |item, attributes|
 		coupons.each do |coupon|
 			if item == coupon[:item] && attributes[:count] >= coupon[:num]
 				elegible = attributes[:count] - (attributes[:count] - (coupons.count(coupon) * coupon[:num])).abs
 				new_item = "#{item} W/COUPON"
 				new_cart[new_item] = attributes.clone
 				new_cart[new_item][:count] = elegible / coupon[:num]
 				new_cart[new_item][:price] = coupon[:cost]
 				new_cart[item][:count] -= elegible
 			end
 		end
 	end
 	new_cart
end


def apply_clearance(cart)
  new_cart = cart.clone
  cart.each do |item, attributes|
  	if attributes[:clearance] == true
  		new_cart[item][:price] = (attributes[:price] * 0.8).round(2)
  	end
  end
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each {|item, attributes| total += attributes[:price] * attributes[:count]}
  total = (total * 0.9).round(2) if total > 100.00
  total
end

