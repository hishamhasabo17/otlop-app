abstract class BrandStates {}

class BrandLoading extends BrandStates {}

class BrandSuccess extends BrandStates {
  final List brands;

  BrandSuccess(this.brands);
}

class BrandFailure extends BrandStates {}