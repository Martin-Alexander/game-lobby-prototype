function Square(attributes) {
  this.x = attributes.x;
  this.y = attributes.y;
  this.testAttribute = attributes.testAttribute;
  this.units = [];
}

Square.prototype.serialize = function() {
  serializedUnits = [];
  for(let i = 0; i < this.units.length; i++) {
    serializedUnits.push(this.units[i].serialize());
  }
  return {
    x: this.x,
    y: this.y,
    testAttribute: this.testAttribute,
    units: serializedUnits
  }
}