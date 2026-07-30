abstract class EndPoints {
  static const baseUrl = "https://accessories-eshop.runasp.net/api";
  static const products = "/products";
  static const categories = "/categories";
  static const verify = "/auth/verify-email";
  static const register = "/auth/register";
  static const login = "/auth/login";
  static const cartItems = "/cart/items";
  static const cart = "/cart";
  static const cartDecrement = "/cart/items/decrement";
  static String cartItemById(String id) => "/cart/items/$id";
  
}