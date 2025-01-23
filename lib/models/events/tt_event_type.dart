enum TTEventType {
  addToCart('AddToCart'),
  addToWishlist('AddToWishlist'),
  checkout('Checkout'),
  purchase('Purchase'),
  viewContent('ViewContent'),
  none('None');

  final String name;
  const TTEventType(this.name);
}
