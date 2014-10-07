(function() {
  var Glasses, Mask, Messages;

  Glasses = (function() {
    function Glasses() {}

    Glasses.prototype.putOn = function() {
      this.findMasks();
      this.hideLies();
      return this.showTruth();
    };

    Glasses.prototype.findMasks = function() {
      var mask, masks, _i, _len, _results;
      masks = $('iframe');
      _results = [];
      for (_i = 0, _len = masks.length; _i < _len; _i++) {
        mask = masks[_i];
        _results.push(new Mask(mask));
      }
      return _results;
    };

    Glasses.prototype.hideLies = function() {};

    Glasses.prototype.showTruth = function() {};

    return Glasses;

  })();

  Mask = (function() {
    function Mask(mask) {
      this.mask = mask;
    }

    return Mask;

  })();

  Messages = (function() {
    function Messages(height, width) {
      this.height = height;
      this.width = width;
    }

    return Messages;

  })();

  this.putOnTheGlasses = function() {
    var g;
    g = new Glasses;
    return g.putOn();
  };

}).call(this);

//# sourceMappingURL=maps/nada.js.map
