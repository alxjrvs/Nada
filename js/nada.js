(function() {
  var Glasses, Mask, Message;

  Glasses = (function() {
    function Glasses() {}

    Glasses.prototype.putOn = function() {
      this.findMasks();
      this.hideLies();
      return this.showTruth();
    };

    Glasses.prototype.findMasks = function() {
      var masks;
      masks = $('iframe');
      return this.masks = _.map(masks, function(mask) {
        return new Mask(mask);
      });
    };

    Glasses.prototype.hideLies = function() {
      return _.each(this.masks, function(mask) {
        return mask.hide();
      });
    };

    Glasses.prototype.showTruth = function() {};

    return Glasses;

  })();

  Mask = (function() {
    function Mask(mask) {
      this.mask = mask;
      this.buildMask();
    }

    Mask.prototype.buildMask = function() {
      this.height = this.mask.offsetHeight;
      this.width = this.mask.offsetWidth;
      this.left = this.mask.offsetLeft;
      return this.top = this.mask.offsetTop;
    };

    Mask.prototype.hide = function() {
      this.mask.style.visibility = "hidden";
      return this.placeMessage();
    };

    Mask.prototype.show = function() {
      this.removeMessage();
      return this.mask.style.visibility = "visible";
    };

    Mask.prototype.message = function() {
      return new Message(this.height, this.width, this.left, this.top);
    };

    Mask.prototype.removeMessage = function() {};

    Mask.prototype.placeMessage = function() {
      $('head').after(this.message().skin());
      return $('body').after(this.message().truth());
    };

    return Mask;

  })();

  Message = (function() {
    function Message(height, width, left, top) {
      this.height = height;
      this.width = width;
      this.left = left;
      this.top = top;
    }

    Message.prototype.skin = function() {
      return $('<link />', this.skinConfig());
    };

    Message.prototype.skinConfig = function() {
      return {
        rel: "stylesheet",
        href: "./css/skin.css",
        type: "text/css",
        media: "all"
      };
    };

    Message.prototype.truth = function() {
      return $('<theyframe />', this.truthConfig());
    };

    Message.prototype.truthConfig = function() {
      return {
        text: "OBEY",
        css: {
          height: "" + this.height + "px",
          width: "" + this.width + "px",
          left: "" + this.left + "px",
          top: "" + this.top + "px",
          position: "absolute",
          background: "white",
          color: "black",
          border: "solid 10px black",
          "text-align": "center",
          "font-size": "32px",
          "line-height": "" + this.height + "px"
        }
      };
    };

    return Message;

  })();

  this.g = new Glasses;

  this.putOnTheGlasses = function() {
    return this.g.putOn();
  };

}).call(this);

//# sourceMappingURL=nada.js.map
